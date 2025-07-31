FROM jenkins/jenkins:2.452.4-jdk11

# Set JVM heap memory to 4GB
ENV JAVA_OPTS="-Xmx4g -Xms2g"

USER root

# Install Firefox and other requirements 
# Try to work around GPG signature issues
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get update --allow-releaseinfo-change --fix-missing && apt-get install -y \
    lsb-release \
    wget \
    vim \
    bzip2 \
    libx11-xcb1 \
    libdbus-glib-1-2 \
    python3-pip \
    python3-venv \
    -yqq \
    unzip \
    curl \
    libgtk-3-0 \
    libxcb1 \
    libxcomposite1 \
    libxcursor1 \
    libxdamage1 \
    libxext6 \
    libxfixes3 \
    libxi6 \
    libxrandr2 \
    libxrender1 \
    libxss1 \
    libxtst6 \
    ca-certificates \
    fonts-liberation \
    libappindicator1 \
    libnss3 \
    xdg-utils \
    firefox-esr

# ENV FIREFOX_VER=99.0b8
ENV FIREFOX_VER=121.0

# install FireFox
# RUN curl -sSLO https://download-installer.cdn.mozilla.net/pub/firefox/releases/${FIREFOX_VER}/linux-x86_64/en-US/firefox-${FIREFOX_VER}.tar.bz2
# RUN curl -sSLO https://download-installer.cdn.mozilla.net/pub/firefox/releases/${FIREFOX_VER}/linux-x86_64/en-US/firefox-${FIREFOX_VER}.tar.bz2
# RUN tar -jxf firefox-*
# RUN mv firefox /opt/
# RUN chmod 755 /opt/firefox
# RUN chmod 755 /opt/firefox/firefox

# Set Firefox binary path for Selenium
ENV PATH="/usr/bin:${PATH}"

# Install geckodriver for multi-platform support (ARM64 and x86_64)
RUN if [ "$(uname -m)" = "aarch64" ]; then \
        wget -q https://github.com/mozilla/geckodriver/releases/download/v0.33.0/geckodriver-v0.33.0-linux-aarch64.tar.gz \
        && tar -xzf geckodriver-v0.33.0-linux-aarch64.tar.gz \
        && mv geckodriver /usr/local/bin/ \
        && chmod +x /usr/local/bin/geckodriver \
        && rm geckodriver-v0.33.0-linux-aarch64.tar.gz; \
    else \
        wget -q https://github.com/mozilla/geckodriver/releases/download/v0.33.0/geckodriver-v0.33.0-linux64.tar.gz \
        && tar -xzf geckodriver-v0.33.0-linux64.tar.gz \
        && mv geckodriver /usr/local/bin/ \
        && chmod +x /usr/local/bin/geckodriver \
        && rm geckodriver-v0.33.0-linux64.tar.gz; \
    fi

# Set environment variables for Firefox headless
ENV MOZ_HEADLESS=1
ENV MOZ_NO_REMOTE=1

# Set memory-related environment variables
ENV MOZ_DISABLE_SANDBOX=1
ENV MOZ_DISABLE_GMP_SANDBOX=1
ENV MOZ_DISABLE_CONTENT_SANDBOX=1

# Test if Firefox can run at all
RUN /usr/bin/firefox --version

# Copy the Selenium script to the container
COPY selenium_examples /selenium_examples

WORKDIR /

# Create a Python virtual environment and install Selenium
RUN python3 -m venv myenv \
    && . myenv/bin/activate \
    && pip install --upgrade pip \
    && pip install selenium

RUN . myenv/bin/activate && python -m pip freeze
# Test Firefox and Selenium during build
# This ensures Firefox and Selenium work properly before the image is used
# Commented out due to timeout issues in ARM64 builds
# RUN --mount=type=cache,target=/root/.cache \
#     timeout 300 . myenv/bin/activate && python selenium_examples/selenium_firefox_example.py

# Switch to Jenkins user
USER jenkins

# Note: No CMD specified - uses the base image's CMD which starts Jenkins properly
# This is better than specifying our own CMD because:
# 1. Uses the official Jenkins startup script from jenkins/jenkins:2.521-jdk21
# 2. Automatically inherits any improvements from the base image
# 3. Follows Docker best practices of inheriting from base image defaults


