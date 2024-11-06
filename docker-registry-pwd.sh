#!/bin/bash

# Define variables
AUTH_DIR=./auth
REGISTRY_USER=docker
REGISTRY_PASS=$(openssl rand -base64 12)  # Auto-generated password

# Create auth directory if it doesn't exist
mkdir -p "$AUTH_DIR"

# Check if openssl is installed, if not install it
if ! command -v openssl &> /dev/null; then
    echo "openssl not found, installing..."
    sudo apt-get update && sudo apt-get install -y openssl
fi

# Check if htpasswd is installed, if not install it
if ! command -v htpasswd &> /dev/null; then
    echo "htpasswd not found, installing apache2-utils..."
    sudo apt-get update && sudo apt-get install -y apache2-utils
fi

# Generate Docker registry password file using htpasswd
htpasswd -Bbn "$REGISTRY_USER" "$REGISTRY_PASS" > "$AUTH_DIR/htpasswd"
echo "Docker registry credentials generated successfully."
