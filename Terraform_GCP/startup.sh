#!/bin/bash

# Install prerequisites (choose one method, snap or apt)

# Method 1: Using snap (recommended for simplicity)
sudo snap refresh
sudo snap install google-cloud-cli --classic
sudo snap install kubectl --classic
sudo ln -s /snap/bin/kubectl /usr/bin/kubectl
echo "vagrant ALL=(ALL) NOPASSWD: /usr/bin/kubectl" | sudo tee /etc/sudoers.d/vagrant-kubectl > /dev/null # Suppress output

echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
sudo apt-get update
sudo apt-get install google-cloud-sdk-gke-gcloud-auth-plugin -y


# Set project, region, and zone
gcloud config set project api-project-269968866265
gcloud config set compute/region us-central1
gcloud config set compute/zone us-central1-b

# Create the GKE cluster
gcloud container clusters create nasa3-cluster

kubectl config use-context gke_api-project-269968866265_us-central1-b_nasa3-cluster

echo $(pwd)
cd /tmp

kubectl apply -f secret.yaml
kubectl apply -f K8-deployment.yaml
kubectl apply -f K8-service.yaml
kubectl apply -f frontend-hpa.yaml