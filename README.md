# AWS Elastic Kubernetes Exercise Repository

## Overview
Welcome to the AWS Elastic Kubernetes Exercise Repository. This repository contains all the resources, practice exercises, and reference materials I used while exercising for AWS EKS.

## Table of Contents
- [Introduction](#introduction)
- [Getting Started](#getting-started)
- [Repository Structure](#repository-structure)
- [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)

## Introduction
This repository is designed to help individuals preparing for the AWS EKS Skill Set. It includes a variety of study materials, hands-on labs, and reference documents that cover the key topics required for the ability on-site.

## Getting Started
To get started with this repository, you will need to clone it to your local machine and ensure you have the necessary dependencies installed.

### Prerequisites
- Git
- Hashicorp Terraform
- AWS CLI

### Installation
1. Clone the repository:
    ```bash
    git clone https://github.com/Macer-Park/AWS-EKS.git
    ```
2. Navigate to the project directory:
    ```bash
    cd AWS-EKS
    ```
3. Install the required dependencies:
    ```bash
    terraform init && terraform apply -parallelism=30
    ```

## Repository Structure
The repository is organized as follows:
- `/exercises`: Hands-on lab exercises.

## Usage
Each section of the repository contains detailed instructions and materials to aid in your study and practice. Here are some key highlights:
- **Docs**: Contains detailed study guides and notes on each topic.
- **Exercises**: Practical exercises to reinforce your understanding.
- **Scripts**: Helpful scripts to automate common tasks.
- **resources**: Real-world configurations to help understand best practices.

### Exercises Usage
To run a sample script from the `HCL Code` directory:
```bash
terraform init && terraform apply -parallelism=30
```

Contributing
Contributions are welcome! If you have any improvements or additional resources to share, please follow these steps:

Fork the repository.
Create a new branch: git checkout -b feature/new-feature.
Make your changes.
Commit your changes: git commit -m 'Add new feature'.
Push to the branch: git push origin feature/new-feature.
Open a pull request.

## License
This project is licensed under the MIT License. See the LICENSE file for details.
