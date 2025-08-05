# Jenkins Firefox Docker Image

A Docker image containing Jenkins with Firefox and Selenium for automated testing. Perfect for CI/CD pipelines, learning environments, and development teams.

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

- **Jenkins** (latest LTS version with JDK 11)
- **Firefox ESR** browser for Selenium testing
- **Python 3** with Selenium library
- **Geckodriver** (Firefox WebDriver) for ARM64 and x86_64
- **Selenium test examples** in `selenium_examples/`
- **Multi-platform support** (AMD64 and ARM64)

## 🏃‍♂️ Running the Container

### Start Jenkins Server
```bash
docker run -p 8080:8080 -p 50000:50000 jenkins-firefox:latest
```

### Run Selenium Tests
```bash
docker run --rm jenkins-firefox:latest bash -c ". myenv/bin/activate && python selenium_examples/selenium_firefox_example.py"
```

### Interactive Shell
```bash
docker run -it --rm jenkins-firefox:latest bash
```

## 📋 Requirements

- **Docker Desktop** installed and running
- **Internet connection** (for initial download)
- **Docker Hub account** (only for publishing scripts)
- **4GB+ RAM** recommended for Selenium testing

## 🎯 Use Cases

- **Students**: Use local build scripts for learning and development
- **Developers**: Use publishing scripts to share images with the community
- **CI/CD**: Use the Docker image in automated testing pipelines
- **QA Teams**: Run Selenium tests in isolated environments

## 🔧 Architecture

### Base Image
- **Jenkins LTS** with JDK 11
- **Debian-based** Linux distribution

### Firefox Setup
- **Firefox ESR** (Extended Support Release)
- **Headless mode** enabled for containerized testing
- **Multi-architecture** support (ARM64/x86_64)

### Python Environment
- **Virtual environment** (`myenv`) for dependency isolation
- **Selenium 4.x** for modern browser automation
- **Geckodriver** automatically configured

## 🐛 Troubleshooting

### Build Issues
```bash
# Clear Docker cache
docker system prune -a

# Check Docker version
docker --version

# Verify buildx is available
docker buildx version
```

### Selenium Test Failures
```bash
# Check if Firefox is installed
docker run --rm jenkins-firefox:latest firefox --version

# Test geckodriver
docker run --rm jenkins-firefox:latest geckodriver --version

# Run with verbose output
docker run --rm jenkins-firefox:latest bash -c ". myenv/bin/activate && python -v selenium_examples/selenium_firefox_example.py"
```

### Platform-Specific Issues
**Apple Silicon Macs:**
```bash
# Use AMD64 platform explicitly
docker run --platform linux/amd64 jenkins-firefox:latest
```

**ARM64 Systems:**
```bash
# Use ARM64 platform explicitly  
docker run --platform linux/arm64 jenkins-firefox:latest
```

## 🔄 Advanced Usage

### Custom Selenium Scripts
```bash
# Mount your scripts into the container
docker run -v $(pwd)/my_scripts:/scripts jenkins-firefox:latest bash -c ". myenv/bin/activate && python /scripts/my_test.py"
```

### Jenkins Configuration
```bash
# Mount Jenkins home directory
docker run -v jenkins_home:/var/jenkins_home -p 8080:8080 jenkins-firefox:latest
```

### Environment Variables
```bash
# Set Firefox options
docker run -e MOZ_HEADLESS=1 -e MOZ_DISABLE_SANDBOX=1 jenkins-firefox:latest
```

## 📊 Performance

- **Build time**: 5-10 minutes (first time)
- **Image size**: ~2GB
- **Memory usage**: ~512MB (Jenkins) + ~256MB (Firefox)
- **Startup time**: ~30 seconds

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Test your changes with the build scripts
4. Submit a pull request

## 📄 License

This project is open source and available under the [MIT License](LICENSE).

## 🆘 Support

- **Issues**: Create an issue on GitHub
- **Documentation**: Check the `selenium_examples/` directory
- **Community**: Join our discussions

---

**Happy testing! 🚀**

---

## 4c4 Platform-Specific Instructions

### Mac
- Ensure Docker Desktop is installed and running.
- Use the following command to start the Jenkins container:
  ```bash
  docker run -p 8080:8080 -p 50000:50000 -v $(pwd)/jenkins_data:/var/jenkins_home jenkins-firefox:latest
  ```

### Windows
- Ensure Docker Desktop is installed and running.
- Use the following command in Command Prompt:
  ```cmd
  docker run -p 8080:8080 -p 50000:50000 -v %cd%\jenkins_data:/var/jenkins_home jenkins-firefox:latest
  ```

### Linux
- Ensure Docker is installed and running.
- Use the following command to start the Jenkins container:
  ```bash
  docker run -p 8080:8080 -p 50000:50000 -v $(pwd)/jenkins_data:/var/jenkins_home jenkins-firefox:latest
  ```

---

## 4c4 Consistency and Cross-Referencing

For more detailed Docker-specific instructions, refer to the [README_DOCKERHUB.md](README_DOCKERHUB.md) file.

---

## 4c4 Visual Enhancements

Consider adding diagrams or flowcharts to illustrate the setup process or architecture. This can be done using tools like [Mermaid](https://mermaid-js.github.io/mermaid/#/) for markdown-based diagrams.

---

## 4c4 User Feedback

We welcome your feedback and contributions! Feel free to open issues or submit pull requests on our [GitHub repository](https://github.com/supersqa1/jenkins-firefox-docker).
