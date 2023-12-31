# Boilerplate Kubernetes Repository

This repository serves as a boilerplate for deploying your applications to Google Kubernetes Engine (GKE) using Terraform and GitHub Actions. It contains configuration files for two example applications (`example-go` and `example-node`) which demonstrate the working of this repository.

## Prerequisites

Before you start using this repository, ensure that you have the following:

- A GitHub Account
- A Google Cloud Platform (GCP) Account
- Google Cloud Platform credentials in JSON format
- Terraform Installed (It's recommended to use tfenv)

## Repository Structure

The repository contains several key files and directories, each with a specific purpose. Here's a brief overview:

- `LICENSE`: The license for this repository
- `backends`: Contains the application code and GitHub workflows (in `.github`) for two sample applications (example-go and example-node)
- `terraform`: Contains Terraform configuration files for provisioning infrastructure on Google Cloud Platform.

```
.
├── LICENSE
├── backends
│   ├── .github
│   │   ├── workflows
│   │   │   ├── pipeline-example-go.yml
│   │   │   └── pipeline-example-node.yml
│   ├── example-go
│   └── example-node
└── terraform
    ├── data.tf
    ├── main.tf
    ├── providers.tf
    └── variables.tf
```

## Terraform

Terraform is used to provision infrastructure on Google Cloud Platform (GCP), specifically a Google Kubernetes Engine (GKE) autopilot cluster.

First, ensure that `tfenv` (or Terraform) is installed on your system. `tfenv` is recommended over Terraform as it allows you to easily switch between different versions of Terraform. 

Then, you'll need to create a `.tfvars` file (e.g. `environment-production.tfvars`) in the `terraform` directory to define any necessary variables. The following is an example of a `.tfvars` file:

```tfvars 
# environment-production.tfvars
service_name = "my-service"
environment  = "production"
```

Next, navigate to the `terraform` directory and initialize your Terraform workspace by running `terraform init`. This will prep your workspace for Terraform usage.

To see a plan of what resources Terraform will create, run `terraform plan -var-file=<your tfvars file>`.

If the plan is as expected, you can apply the plan and create these resources by using `terraform apply -var-file=<your tfvars file>`. 

## GitHub Actions

This repository uses GitHub Actions for Continuous Integration/Continuous Deployment (CI/CD). GitHub Actions workflows located in `.github/workflows` automate the process of testing, building, and deploying applications to the GKE cluster. 

The workflows are configured to handle three jobs:

1. **Test Job**: Runs unit tests in the respective backend application.
2. **Build Job**: Builds a containerized version of the application.
3. **Deploy Job**: Deploys the built container to the GKE cluster and exposes it to the internet.

## Setting up Environment Variables and Secrets

For the GitHub Actions workflows to run correctly, you'll need to configure certain environment variables in the Settings of your GitHub repository:

- `GAR_LOCATION`: Defines the region of your Google Artifact Registry. For instance, `asia-southeast2`.
- `GKE_CLUSTER`: Refers to the name of the GKE cluster generated by Terraform.

You also need to add two secrets in your GitHub repository. You can do this by navigating to the "Secrets" option under the "Settings" tab of your repository, and add:

- `GCP_PROJECT_ID`: Your GCP project ID.
- `GCP_SA_KEY`: Your GCP service account key.

## Conclusion

Now that you have set up the Terraform configurations and GitHub Actions workflows, with every push to your repository, your applications would automatically be tested, built and deployed to the GKE cluster.