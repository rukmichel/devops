# Configure Google Cloud Platform (GCP) monitoring alert policies.

## Get all metric types associated  with GCP alert policies

Ensure that you have the Google Cloud SDK installed and configured. You can download it from [here](https://cloud.google.com/sdk?hl=en) and follow the instructions for installation and setup.

1. step 1: Enable the Monitoring API

```powershell
gcloud services enable monitoring.googleapis.com
```
2. step 2: Authenticate with Google Cloud

```powershell
gcloud auth login
```
3. step 3: Create a Service Account

```powershell
gcloud iam service-accounts create my-monitoring-sa --display-name "Monitoring Service Account"
gcloud projects add-iam-policy-binding YOUR_PROJECT_ID --member "serviceAccount:my-monitoring-sa@YOUR_PROJECT_ID.iam.gserviceaccount.com" --role "roles/monitoring.viewer"
```
4. step 4: Generate and Download a JSON Key File

```powershell
gcloud iam service-accounts keys create key.json --iam-account=my-monitoring-sa@YOUR_PROJECT_ID.iam.gserviceaccount.com
```
5. step 5: Set the Environment Variable for Authentication

```powershell
export GOOGLE_APPLICATION_CREDENTIALS="path/to/key.json"
```
Keep in mind that the metric types you see will depend on the resources and services you have in your Google Cloud project. Additionally, you might want to explore the [Google Cloud Monitoring API documentation](https://cloud.google.com/monitoring/api/ref_v3/rest/v3/projects.metricDescriptors/list) for more details on querying and filtering metric types

6. step 6: List Metric Types

```powershell
gcloud monitoring metric-descriptors list
gcloud monitoring metric-types list

```
