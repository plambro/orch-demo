# Orchestration Demo

## Project Description

A word count service demo to showcase orchestration. The service itself is written in Python 3.7 and uses the [Flask](flask.palletsprojects.com/) microframework. Orchestration is handled via [Terraform](terraform.io) and [Docker](docker.com). Deployment is to [Google Cloud Platform](cloud.google.com).

## Assumptions

This is currently http traffic sent directly to a VM IP address. In actual production this would be behind a load balancer with a fully qualified name and require SSL, I assumed this was outside the scope of the exercise. I am choosing to share my service account credentials JSON via email rather than asking you to use your own GCP resources, this is insecure and a bad practice but for demo purposes I felt it was ok.


## Requirements

- The provided JSON credentials document.
- A ssh key pair (Go [Here](https://help.dreamhost.com/hc/en-us/articles/115001736671-Creating-a-new-Key-pair-in-Mac-OS-X-or-Linux) for instructions)
- Terraform CLI https://terraform.io


## Deployment Instructions

- Clone the repo and `cd` into it
- Export the following environment variables:
    - CREDENTIALS_PATH = path to JSON credentials file
    - PUBLIC_KEY_PATH = path to your ssh public key
    - PRIVATE_KEY_PATH = path to your ssh private key(this does not get transferred anywhere, just instructs terraform which key to use)

You may also open and edit plan.sh and hardcode these variables.

- From inside the repo run `terraform init`
- Run `bash plan.sh`
- Run `terraform apply .plan`
- When complete it will provide the public IP address in output
- Navigate in browser to http://public-ip/count
- Upload a .txt file to test


## Upgrading and Scaling

As is the terraform plan runs the docker image tagged `latest`. Upgrading the service would involve making code changes, building the image and pushing to docker hub, then running the terraform plan to rebuild and deploy the new version.

Scaling this to a larger instance would require a terraform plan change, as well as a code change to increase the number of gunicorn workers. Scaling to multiple instances across availability zones/regions is also possible via changes to the terraform plan. This would require a load balancer as well.
