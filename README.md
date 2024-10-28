## Description

This is just a POC showing usage of Terraform and Kubernetes working together to deploy various applications.

## To-do

1. Automatic port-forwarding for each application deployed (nice to have)

## Setup

```
# Install kind and kubectl 
# P.S. This requires homebrew on WSL or MacOS
brew install kind kubectl

# Create cluster using WSL friendly (haven't tested on MacOS) config
kind create cluster --config=kindconfig.yml

# Get the kubeconfig of the cluster after it's created
kind get kubeconfig > kubeconfig

# Init terraform, because this is just a local testing setup
terraform init

# Apply terraform
terraform apply
```