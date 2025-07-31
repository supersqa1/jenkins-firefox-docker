import os
import subprocess
from selenium import webdriver
from selenium.webdriver.firefox.options import Options as FFOptions
from selenium.webdriver.firefox.service import Service

print(f"Adding firefox options")
ff_options = FFOptions()
ff_options.add_argument("--disable-gpu")
ff_options.add_argument("--no-sandbox")
ff_options.add_argument("--headless")

# Set Firefox binary path explicitly
ff_options.binary_location = "/usr/bin/firefox"

# Use the manually installed geckodriver for ARM64
service = Service('/usr/local/bin/geckodriver')

print(f"Creating a Firefox browser instance")
driver = webdriver.Firefox(service=service, options=ff_options)

# Example usage
url = "http://demostore.supersqa.com"
print(f"Navigating to url: {url}")
driver.get(url)
print(f"Getting page title")
print(f"Current page Title = {driver.title}")

# Quit the browser
driver.quit()
