# Jenkins Firefox Docker Image

A Docker image containing Jenkins with Firefox and Selenium for automated testing.

## 🚀 Quick Start

### For Students (Local Development)

**Mac:**
```bash
./build_and_test_mac.sh
```

**Windows:**
```cmd
build_and_test_windows.bat
```

### For Developers (Publishing to Docker Hub)

**Mac:**
```bash
./build_test_and_push_mac.sh
```

**Ubuntu:**
```bash
./build_test_and_push_ubuntu.sh
```

## 📁 Build Scripts

### Local Development (No Docker Hub Account Required)
- `build_and_test_mac.sh` - Build and test locally on Mac
- `build_and_test_windows.bat` - Build and test locally on Windows

### Publishing (Requires Docker Hub Account)
- `build_test_and_push_mac.sh` - Build, test, and push to Docker Hub from Mac
- `build_test_and_push_ubuntu.sh` - Build, test, and push to Docker Hub from Ubuntu

## 🐳 What's Included

- **Jenkins** (latest LTS version)
- **Firefox** browser for Selenium testing
- **Python** with Selenium library
- **Geckodriver** (Firefox WebDriver)
- **Selenium test examples** in `selenium_examples/`

## 🏃‍♂️ Running the Container

After building, run Jenkins:

```bash
docker run -p 8080:8080 -p 50000:50000 jenkins-firefox:latest
```

Run Selenium tests:

```bash
docker run --rm jenkins-firefox:latest bash -c ". myenv/bin/activate && python selenium_examples/selenium_firefox_example.py"
```

## 📋 Requirements

- Docker Desktop installed and running
- Internet connection (for initial download)
- Docker Hub account (only for publishing scripts)

## 🎯 Use Cases

- **Students**: Use local build scripts for learning and development
- **Developers**: Use publishing scripts to share images with the community
- **CI/CD**: Use the Docker image in automated testing pipelines
