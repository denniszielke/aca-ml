param storageAccountName string
param principalId string

// Storage Blob Data Reader
var storageReaderRole = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', '2a2b9908-6ea1-4ae2-8e65-a410df84e7d1')

resource readerPermissions 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  scope: storageAccount // Use when specifying a scope that is different than the deployment scope
  name: guid(subscription().id, resourceGroup().id, principalId, storageReaderRole)
  properties: {
    roleDefinitionId: storageReaderRole
    principalType: 'ServicePrincipal'
    principalId: principalId
  }
}

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-04-01' existing = {
  name: storageAccountName
}
