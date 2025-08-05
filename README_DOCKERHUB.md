<!-- Badges -->
<p align="center">
  <a href="https://hub.docker.com/r/supersqa/jenkins-firefox"><img src="https://img.shields.io/docker/pulls/supersqa/jenkins-firefox?style=for-the-badge&logo=docker" alt="Docker Pulls"></a>
  <a href="https://hub.docker.com/r/supersqa/jenkins-firefox"><img src="https://img.shields.io/docker/image-size/supersqa/jenkins-firefox/latest?style=for-the-badge&logo=docker" alt="Docker Image Size"></a>
  <a href="https://github.com/supersqa1/jenkins-firefox-docker"><img src="https://img.shields.io/github/stars/supersqa1/jenkins-firefox-docker?style=for-the-badge&logo=github" alt="GitHub Stars"></a>
</p>

# Jenkins Controller with Firefox & Selenium

This Docker image provides a full-featured **Jenkins Controller** environment based on the official LTS release, enhanced with **Firefox, Python, and Selenium** to enable seamless execution of browser-based UI automation jobs.

**Source Code on GitHub:** [https://github.com/supersqa1/jenkins-firefox-docker](https://github.com/supersqa1/jenkins-firefox-docker)

---

## 🚀 Quick Start: Run as a Jenkins Controller

To run this image as a proper Jenkins controller, you must mount a volume to persist your Jenkins data (`jenkins_home`). This ensures your jobs, plugins, and configurations are saved even if the container is removed.

The recommended approach is to use a **bind mount**, which maps a directory from your local machine into the container.

```bash
# This command will create a 'jenkins_data' directory in your current folder for persistence.
docker run -p 8080:8080 -p 50000:50000 -v $(pwd)/jenkins_data:/var/jenkins_home supersqa/jenkins-firefox
```

**Breakdown of the command:**
* `-p 8080:8080`: Maps the Jenkins web UI port to your host machine.
* `-p 50000:50000`: Maps the agent communication port.
* `-v $(pwd)/jenkins_data:/var/jenkins_home`: Creates a directory named `jenkins_data` in your current location and maps it to the Jenkins home directory inside the container. This is how your data is persisted.
* `supersqa/jenkins-firefox`: The name of the Docker image.

After running the command, access Jenkins at `http://localhost:8080`.

### Alternative: Using a Named Volume
If you prefer not to manage a local folder directly, you can use a Docker-managed named volume. Docker will handle the storage location for you.

```bash
docker run -p 8080:8080 -p 50000:50000 -v jenkins_home:/var/jenkins_home supersqa/jenkins-firefox
```

---

## ✨ Running Standalone Selenium Scripts

While the primary purpose of this image is to serve as a Jenkins controller, you can also use it to run standalone Python Selenium scripts for testing or validation. This is useful for verifying that your automation scripts work correctly within the container's environment.

**Note:** This method runs a single script and then exits. It does **not** start the Jenkins service.

```bash
# General command structure
docker run -it --rm --platform linux/amd64 -v /path/to/your/scripts:/scripts supersqa/jenkins-firefox /myenv/bin/python3 /scripts/your_script.py

# Example using the included scripts
docker run -it --rm --platform linux/amd64 supersqa/jenkins-firefox /myenv/bin/python3 /selenium_examples/selenium_firefox_example.py
```

---

## 🔧 Key Features

* **Jenkins Controller:** Based on the official `jenkins/jenkins:lts-jdk21` image.
* **Browser Included:** Comes with Firefox pre-installed for UI testing.
* **Test Automation Ready:** Includes Python 3, a virtual environment, and Selenium.
* **Multi-Platform:** Built for `linux/amd64` (Intel/AMD). Note: ARM compatibility for UI tests may vary.

---

## 🏗️ Building from Source

If you need to customize the image (e.g., add more tools or plugins), you can build it from the Dockerfile.

1.  Clone the [GitHub repository](https://github.com/supersqa1/jenkins-firefox-docker).
2.  Run the build command from the repository's root directory:

```bash
docker build -t my-custom-jenkins-ff .
```

---

## About SuperSQA

<a href="https://supersqa.com"><img src="https://i.imgur.com/q2y13a8.png" alt="SuperSQA Logo" width="100"></a>

SuperSQA is your source for learning QA automation and becoming an SDET. Find tutorials on engineering, pipelines, coding, and testing on our platforms.

* **Website:** [supersqa.com](https://supersqa.com)
* **YouTube Channel:** [Visit our YouTube Channel!](https://www.youtube.com/@supersqa)
