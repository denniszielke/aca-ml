@description('Specifies the Azure location for all resources.')
param location string = resourceGroup().location
param tags object = {}
param storageAccountName string 
param containerName string

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-04-01' = {
  name: storageAccountName
  location: location
  sku: {
      name: 'Standard_LRS'
  }
}

resource blobService 'Microsoft.Storage/storageAccounts/blobServices@2023-01-01' = {
  name: 'default'
  parent: storageAccount
  properties: {
  }
}

resource blobContainer 'Microsoft.Storage/storageAccounts/blobServices/containers@2023-01-01' = {
  name: containerName
  parent: blobService
  properties: {
      publicAccess: 'None' // You can set it to 'Container' or 'None' as needed
  }
}

output storageAccountName string = storageAccount.name
