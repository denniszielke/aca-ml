# Deploying event driven machine learning solution


## Deploy Azure resources

```
ENV_NAME="mlgpu1"
LOCATION="northeurope"

bash ./deploy-infra.sh $ENV_NAME $LOCATION

```

## Deploy Apps into Container Apps

```
ENV_NAME="mlgpu1"
IMAGE="nu1.azurecr.io/denniszielke/ml"


bash ./deploy-app.sh $ENV_NAME $IMAGE

```
