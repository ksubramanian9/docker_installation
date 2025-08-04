#!/bin/bash

# install-docker-fedora.sh
# Install Docker CE on Fedora

set -e

echo "🚀 Starting Docker installation on Fedora..."

# Step 1: Remove older Docker versions if any
echo "🧹 Removing old Docker versions..."
sudo dnf remove -y docker \
    docker-client \
    docker-client-latest \
    docker-common \
    docker-latest \
    docker-latest-logrotate \
    docker-logrotate \
    docker-engine || true

# Step 2: Add Docker CE repository
echo "📦 Adding Docker CE repository..."
sudo dnf -y install dnf-plugins-core
sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo

# Step 3: Install Docker Engine and related packages
echo "📥 Installing Docker Engine..."
sudo dnf install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Step 4: Start and enable Docker service
echo "🔧 Starting and enabling Docker service..."
sudo systemctl start docker
sudo systemctl enable docker

# Step 5: Optional - Add current user to docker group
echo "👤 Adding current user ($USER) to the docker group..."
sudo usermod -aG docker $USER

echo "✅ Docker installed successfully."

# Step 6: Test Docker installation
echo "🔍 Verifying Docker with 'hello-world' container..."
docker run hello-world || echo "⚠️ You may need to log out and log back in before running Docker without sudo."

echo "💡 Please log out and log back in to use Docker as a non-root user."
