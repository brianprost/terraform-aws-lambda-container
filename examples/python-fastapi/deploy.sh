#!/bin/bash

set -e

IMAGE_NAME="python-fastapi-service"
IMAGE_TAG="python-fastapi-greeter-v0.1.1-4"

# get AWS Account ID
AWS_ACCOUNT_ID=$(aws sts get-caller-identity --query Account --output text)

# Build and push the Docker image
aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com
docker build -t $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$IMAGE_NAME:$IMAGE_TAG .
docker push $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com/$IMAGE_NAME:$IMAGE_TAG

# Apply the terraform
tofu init
tofu apply -var="image_tag=$IMAGE_TAG" -auto-approve