#!/bin/bash
# ============================================================================
# Jenkins Firefox Docker Image Builder for Mac (with Docker Hub push)
# ============================================================================
# 
# This script builds, tests, and pushes a multi-platform Docker image containing:
# - Jenkins (latest LTS version)
# - Firefox browser (for Selenium testing)
# - Python with Selenium library
# - Geckodriver (Firefox WebDriver)
#
# USAGE: Run this script to build, test, and push to Docker Hub
#        Requires Docker Hub account and login
#
# REQUIREMENTS:
# - Docker Desktop for Mac installed and running
# - Docker Hub account and login (docker login)
# - Internet connection
#
# OUTPUT: Multi-platform images pushed to Docker Hub
# ============================================================================

set -e
set -x

echo "=== Building Jenkins Firefox Docker Image for Mac (with push) ==="

# Remove existing builder if it exists
docker buildx rm my-builder 2>/dev/null || true

# Create a multi-platform builder
docker buildx create --use --platform linux/amd64,linux/arm64 --name my-builder

# Build for AMD64 first (usually faster)
echo "Building for AMD64..."
docker buildx build --platform linux/amd64 --load --tag supersqa/jenkins-firefox:latest-amd64 .

# Build for ARM64 separately
echo "Building for ARM64..."
docker buildx build --platform linux/arm64 --load --tag supersqa/jenkins-firefox:latest-arm64 .

echo "=== Testing Selenium Functionality ==="

# Test AMD64 image
echo "Testing AMD64 image..."
docker run --rm --name test-amd64 supersqa/jenkins-firefox:latest-amd64 \
  bash -c ". myenv/bin/activate && python selenium_examples/selenium_firefox_example.py"
echo "✅ AMD64 test passed"

# Test ARM64 image - only if we're on ARM64 or have proper emulation
if [ "$(uname -m)" = "aarch64" ]; then
    echo "Testing ARM64 image (native)..."
    docker run --rm --name test-arm64 supersqa/jenkins-firefox:latest-arm64 \
      bash -c ". myenv/bin/activate && python selenium_examples/selenium_firefox_example.py"
    echo "✅ ARM64 test passed"
else
    echo "⚠️  Skipping ARM64 test - QEMU emulation not available for this image"
    echo "   ARM64 image will be pushed without runtime testing"
fi

echo "=== Pushing to Docker Hub ==="

# Push both images to Docker Hub
echo "Pushing images to Docker Hub..."
docker push supersqa/jenkins-firefox:latest-amd64
docker push supersqa/jenkins-firefox:latest-arm64

# Create a multi-platform manifest
echo "Creating multi-platform manifest..."
docker buildx imagetools create -t supersqa/jenkins-firefox:latest \
  supersqa/jenkins-firefox:latest-amd64 \
  supersqa/jenkins-firefox:latest-arm64

echo "✅ Build and test completed successfully!"
echo "Images are now available on Docker Hub: supersqa/jenkins-firefox:latest" 