# Deploying event driven machine learning solution


## Deploy Azure resources

```
ENV_NAME="mlgpu1"
LOCATION="northeurope"

bash ./deploy-infra.sh $ENV_NAME $LOCATION

```

## Deploy cuda

```
ENV_NAME="mlgpu1"
LOCATION="northeurope"
IMAGE="nvidia/cuda:12.5.0-runtime-ubuntu22.04"

bash ./deploy-cuda.sh $ENV_NAME $IMAGE

```

## Build runner app

```
ENV_NAME="mlgpu1"
LOCATION="northeurope"

bash ./build-app.sh $ENV_NAME runner

```

## Deploy Apps into Container Apps

```
ENV_NAME="mlgpu1"
IMAGE="creru56tm3vaz6w.azurecr.io/runner:latest"
IMAGE="creru56tm3vaz6w.azurecr.io/test:latest"

bash ./deploy-app.sh $ENV_NAME $IMAGE

```


## Show cuda details

```

az containerapp exec -g $ENV_NAME --name cuda --command nvidia-smi


024-06-25T18:45:27.095437505Z +-----------------------------------------------------------------------------------------+
2024-06-25T18:45:27.095442704Z | NVIDIA-SMI 550.54.15              Driver Version: 550.54.15      CUDA Version: 12.5     |
2024-06-25T18:45:27.095445379Z |-----------------------------------------+------------------------+----------------------+
2024-06-25T18:45:27.095447684Z | GPU  Name                 Persistence-M | Bus-Id          Disp.A | Volatile Uncorr. ECC |
2024-06-25T18:45:27.095449817Z | Fan  Temp   Perf          Pwr:Usage/Cap |           Memory-Usage | GPU-Util  Compute M. |
2024-06-25T18:45:27.095451981Z |                                         |                        |               MIG M. |
2024-06-25T18:45:27.095454166Z |=========================================+========================+======================|
2024-06-25T18:45:27.115967808Z |   0  NVIDIA A100 80GB PCIe          On  |   00000001:00:00.0 Off |                    0 |
2024-06-25T18:45:27.115984359Z | N/A   29C    P0             40W /  300W |       0MiB /  81920MiB |      0%      Default |
2024-06-25T18:45:27.115987876Z |                                         |                        |             Disabled |
2024-06-25T18:45:27.115990390Z +-----------------------------------------+------------------------+----------------------+
2024-06-25T18:45:27.116121416Z                                                                                          
2024-06-25T18:45:27.116134169Z +-----------------------------------------------------------------------------------------+
2024-06-25T18:45:27.116137506Z | Processes:                                                                              |
2024-06-25T18:45:27.116139579Z |  GPU   GI   CI        PID   Type   Process name                              GPU Memory |
2024-06-25T18:45:27.116141443Z |        ID   ID                                                               Usage      |
2024-06-25T18:45:27.116143417Z |=========================================================================================|
2024-06-25T18:45:27.116409236Z |  No running processes found                                                             |
2024-06-25T18:45:27.116421770Z +-----------------------------------------------------------------------------------------+

```