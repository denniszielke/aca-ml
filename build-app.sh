#!/bin/bash

set -e

# infrastructure deployment properties
ENV_NAME="$1"
IMAGE="$2"

if [ "$ENV_NAME" == "" ]; then
echo "No project name provided - aborting"
exit 0;
fi

if [ "$IMAGE" == "" ]; then
echo "No iamge provided - aborting"
exit 0;
fi

if [[ $ENV_NAME =~ ^[a-z0-9]{5,10}$ ]]; then
    echo "project name $ENV_NAME is valid"
else
    echo "project name $ENV_NAME is invalid - only numbers and lower case min 5 and max 10 characters allowed - aborting"
    exit 0;
fi

RESOURCE_GROUP="$ENV_NAME"

AZURE_CORE_ONLY_SHOW_ERRORS="True"

if [ $(az group exists --name $RESOURCE_GROUP) = false ]; then
    echo "resource group $RESOURCE_GROUP does not exist"
    error=1
else   
    echo "resource group $RESOURCE_GROUP already exists"
    LOCATION=$(az group show -n $RESOURCE_GROUP --query location -o tsv)
fi

ENVIRONMENT_NAME=$(az resource list -g $RESOURCE_GROUP --resource-type "Microsoft.App/managedEnvironments" --query "[0].name" -o tsv)
IDENTITY_NAME=$(az resource list -g $RESOURCE_GROUP --resource-type "Microsoft.ManagedIdentity/userAssignedIdentities" --query "[0].name" -o tsv)
AZURE_CONTAINER_REGISTRY_NAME=$(az resource list -g $RESOURCE_GROUP --resource-type "Microsoft.ContainerRegistry/registries" --query "[0].name" -o tsv)
AZURE_SUBSCRIPTION_ID=$(az account show --query id -o tsv)

IMAGE_NAME="${AZURE_CONTAINER_REGISTRY_NAME}.azurecr.io/$IMAGE:latest"
echo "building image $IMAGE_NAME"
az acr build --subscription ${AZURE_SUBSCRIPTION_ID} --registry ${AZURE_CONTAINER_REGISTRY_NAME} --image $IMAGE:latest ./src/$IMAGE
echo "built image $IMAGE_NAME"
