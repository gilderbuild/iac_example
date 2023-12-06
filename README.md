# zero-downtime

# Description

This repository contains the terraform definitions required to build the infraestructure associated with the zero-downtime project

## Requirements

- AWS Access

- Terraform > v1.2.3

## Usage

- Regular terraform commands
- Terraform workspaces, the backend should be initialized using the following configuration

| Environment       | AWS Account | Workspace | Terraform init                                             |
| ----------------- | ----------- | --------- | ---------------------------------------------------------- |
| Development       | be-Prod  | prod      | terraform init -backend-config="bucket=hlk-prod-terraform" |
| Staging           | be-Stg   | stg       | terraform init -backend-config="bucket=hlk-stg-terraform"  |
| Development       | be-Dev   | dev       | terraform init -backend-config="bucket=hlk-dev-terraform"  |

# Support

Team: <team_contact_information>
