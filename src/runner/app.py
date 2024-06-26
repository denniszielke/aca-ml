import time
import sys

import os, uuid
from azure.identity import DefaultAzureCredential
from azure.storage.blob import BlobServiceClient, BlobClient, ContainerClient

try:
    print("Starting download of file")
    start = time.time()
    print(start)
    account_url = f"https://{os.environ.get('STORAGE_ACCOUNT_NAME')}.blob.core.windows.net" 
    default_credential = DefaultAzureCredential()

    # Create the BlobServiceClient object to download a file named "bigfile.bin" from container name 'model'
    blob_service_client = blob_client = BlobClient(
        account_url=account_url, 
        container_name=os.environ.get('STORAGE_ACCOUNT_CONTAINER_NAME'), 
        blob_name=os.environ.get('FILE_NAME'),
        credential=default_credential,
        max_single_get_size=1024*1024*16, # 16 MiB
        max_chunk_get_size=1024*1024*1 # 1 MiB
    )

    with open(file=os.path.join(os.environ.get('FILE_NAME')), mode="wb") as model_blob:
        download_stream = blob_client.download_blob(max_concurrency=2)
        model_blob.write(download_stream.readall())

    print("Download finished")
    end = time.time()
    print(end - start)

except Exception as ex:
    print('Exception:')
    print(ex)
