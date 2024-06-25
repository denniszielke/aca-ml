#!/bin/bash

set -e

# infrastructure deployment properties
ENV_NAME="$1"
LOCATION="$2"

if [ "$ENV_NAME" == "" ]; then
echo "No env name provided - aborting"
exit 0;
fi

if [[ $ENV_NAME =~ ^[a-z0-9]{5,10}$ ]]; then
    echo "env name $ENV_NAME is valid"
else
    echo "env name $ENV_NAME is invalid - only numbers and lower case min 5 and max 10 characters allowed - aborting"
    exit 0;
fi

RESOURCE_GROUP="$ENV_NAME"

AZURE_CORE_ONLY_SHOW_ERRORS="True"

if [ $(az group exists --name $RESOURCE_GROUP) = false ]; then
    echo "creating resource group $RESOURCE_GROUP..."
    az group create -n $RESOURCE_GROUP -l $LOCATION -o none
    echo "resource group $RESOURCE_GROUP created"
else   
    echo "resource group $RESOURCE_GROUP already exists"
    LOCATION=$(az group show -n $RESOURCE_GROUP --query location -o tsv)
fi

az deployment group create -g $RESOURCE_GROUP -f ./infra/main.bicep \
          -p environmentName=$ENV_NAME 



