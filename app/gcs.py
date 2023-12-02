from google.cloud import storage

def create_gcs_client():
    return storage.Client.from_service_account_json('docpet-project-ch2-ps068-72a7769fa5c2.json')

def upload_blob(bucket_name, source_file_name, destination_blob_name):
    """Uploads a file to the bucket."""
    storage_client = create_gcs_client()
    bucket = storage_client.bucket(bucket_name)
    blob = bucket.blob(destination_blob_name)

    blob.upload_from_filename(source_file_name)

    print('File {} uploaded to {}.'.format(
        source_file_name,
        destination_blob_name))