# DevOps Resource Management
This Terraform project provides code to create and manage resources across multiple cloud providers, currently supporting Microsoft Azure and Google Cloud Platform (GCP). It also automates the configuration of metric alert policies based on user-defined YAML configurations.

## Features
* Cloud Provider Support: Create and manage resources on:
    * Microsoft Azure
    * Google Cloud Platform (GCP)
* Custom Alert Policies: Configure metric-based alert policies using YAML for seamless monitoring.
## Getting Started
To begin working with this project, choose the relevant cloud provider and refer to its documentation:

* [Azure Instructions](azure/README.md)
* [GCP Instructions](gcp/README.md)

## Requirements
* Terraform installed on your local machine
* Proper credentials and permissions for the selected cloud provider
* YAML configurations defining the desired alert policies
## Contributing
Contributions are welcome! Please open an issue or submit a pull request if you want to:

* Add support for additional cloud providers
* Enhance the functionality or documentation
### License
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more details.

