#!/bin/bash
# ============================================================================
# Jenkins Firefox Docker Image Builder for Mac
# ============================================================================
# 
# This script builds a Docker image containing:
# - Jenkins (latest LTS version)
# - Firefox browser (for Selenium testing)
# - Python with Selenium library
# - Geckodriver (Firefox WebDriver)
#
# USAGE: Simply run this script to build and test the image locally
#        No Docker Hub account or internet connection required after download
#
# REQUIREMENTS:
# - Docker Desktop for Mac installed and running
# - Internet connection (for initial download)
#
# OUTPUT: A local Docker image ready for Jenkins + Selenium testing
# ============================================================================

set -e

echo "=== Building Jenkins Firefox Docker Image for Mac ==="
echo ""
echo "This will create a local Docker image with Jenkins and Firefox for Selenium testing."
echo "The build process may take 5-10 minutes depending on your internet speed."
echo ""

# Remove existing builder if it exists
docker buildx rm my-builder 2>/dev/null || echo "Creating new builder..."

# Create a builder for local builds
docker buildx create --use --name my-builder

# Build the image for your system architecture
echo "Building Docker image..."
docker buildx build --load --tag jenkins-firefox:latest .

echo ""
echo "=== Testing Selenium Functionality ==="
echo "Testing that Firefox and Selenium work correctly..."

# Test the image with Selenium
docker run --rm --name selenium-test jenkins-firefox:latest bash -c ". myenv/bin/activate && python selenium_examples/selenium_firefox_example.py"

if [ $? -eq 0 ]; then
    echo ""
    echo "✅ Build and test completed successfully!"
    echo ""
    echo "Your image is ready to use:"
    echo "- Image name: jenkins-firefox:latest"
    echo ""
    echo "To run Jenkins with this image:"
    echo "  docker run -p 8080:8080 -p 50000:50000 jenkins-firefox:latest"
    echo ""
    echo "To run Selenium tests in the container:"
    echo "  docker run --rm jenkins-firefox:latest bash -c '. myenv/bin/activate && python selenium_examples/selenium_firefox_example.py'"
else
    echo ""
    echo "❌ Test failed. Please check the error messages above."
    echo "The image was built but Selenium testing failed."
fi

echo ""
echo "=== Build Summary ==="
echo "- Image: jenkins-firefox:latest"
echo "- Status: Ready for use"
echo "- Location: Local Docker daemon"
echo ""
echo "Happy coding! 🚀" 