#!/bin/bash

# Exit on any error
set -e

# Update the system
echo "Updating system packages..."
sudo dnf -y update

# Install required dependencies
echo "Installing dependencies..."
sudo dnf -y install dnf-plugins-core

# Add the Docker repository using DNF5 syntax
echo "Adding Docker repository..."
sudo dnf config-manager addrepo --from-repofile=https://download.docker.com/linux/fedora/docker-ce.repo

# Install Docker Engine
echo "Installing Docker Engine..."
sudo dnf -y install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Start and enable Docker service
echo "Starting and enabling Docker service..."
sudo systemctl start docker
sudo systemctl enable docker

# Verify Docker installation
echo "Verifying Docker installation..."
docker --version

# Add current user to the docker group (optional, for running Docker without sudo)
echo "Adding user to docker group..."
sudo usermod -aG docker $USER

# Inform user to log out and back in for group changes to take effect
echo "Docker installed successfully! Please log out and log back in to apply group changes, or run 'newgrp docker' in this terminal."

# Test Docker with a hello-world container
echo "Running a test container..."
docker run hello-world
