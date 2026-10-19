# Task 3: Provision an AWS EC2 Instance Using Terraform

## 📌 Project Overview

This project demonstrates how to use **Terraform**, an Infrastructure as Code (IaC) tool, to provision an Amazon EC2 virtual machine and configure a security group that allows SSH and HTTP traffic.

The infrastructure is deployed on Amazon Web Services (AWS) in the Asia Pacific (Mumbai) region (`ap-south-1`).

## 🎯 Objectives

- Understand Infrastructure as Code using Terraform.
- Configure the AWS provider.
- Create an EC2 security group with SSH and HTTP access.
- Provision an EC2 instance using Terraform.
- Validate and apply Terraform configurations.
- Verify the deployed AWS resources.

## 🛠️ Technologies Used

- **Cloud Provider:** Amazon Web Services (AWS)
- **Infrastructure as Code:** Terraform
- **Compute Service:** Amazon EC2
- **Security:** AWS Security Groups
- **Operating System:** Ubuntu Server 24.04 LTS
- **Instance Type:** `t3.micro`
- **Region:** Asia Pacific (Mumbai) — `ap-south-1`
- **Development Environment:** GitHub Codespaces
- **Command-Line Tool:** AWS CLI

## 🏗️ Architecture

```text
                 Terraform
                     |
                     v
             AWS Provider
                     |
          +----------+----------+
          |                     |
          v                     v
   Security Group           EC2 Instance
          |                     |
          |                     |
    +-----+------+        Ubuntu Server
    |            |
    v            v
 SSH (Port 22)  HTTP (Port 80)
 Restricted     Public Access
 Source IP
```

## ⚙️ Infrastructure Configuration

### 1. EC2 Instance

| Configuration | Value |
|---|---|
| Service | Amazon EC2 |
| Instance ID | `i-055cbd2d540a7c34f` |
| Instance Type | `t3.micro` |
| Operating System | Ubuntu Server 24.04 LTS |
| Region | `ap-south-1` |
| Public IP | `13.127.135.129` |

### 2. Security Group

| Protocol | Port | Source | Purpose |
|---|---:|---|---|
| TCP | 22 | `47.11.6.171/32` | Restricted SSH access |
| TCP | 80 | `0.0.0.0/0` | HTTP access |
| All | All | `0.0.0.0/0` | Outbound traffic |

**Security note:** SSH access is restricted to a specific public IP address instead of being open to everyone.

### 3. Terraform Resources

- `aws_security_group` — creates the security group.
- `aws_instance` — provisions the EC2 virtual machine.
- AWS provider configuration — connects Terraform to the AWS Mumbai region.

## 🚀 Implementation Steps

### Step 1: Configure AWS Credentials

Configure AWS credentials securely using environment variables or GitHub Codespaces Secrets.

Required environment variable names:

- `AWS_ACCESS_KEY_ID`
- `AWS_SECRET_ACCESS_KEY`

Never upload AWS access keys or secret keys to GitHub.

### Step 2: Initialize Terraform

```bash
terraform init
```

Downloads the required provider plugins and initializes the Terraform working directory.

### Step 3: Validate the Configuration

```bash
terraform validate
```

Checks the Terraform configuration for syntax and structural errors.

### Step 4: Review the Execution Plan

```bash
terraform plan
```

Previews the infrastructure changes Terraform intends to make.

### Step 5: Provision the Infrastructure

```bash
terraform apply
```

Review the plan and type `yes` when prompted to approve the changes.

### Step 6: Verify the EC2 Instance

```bash
aws ec2 describe-instances \
  --instance-ids i-055cbd2d540a7c34f \
  --region ap-south-1 \
  --query "Reservations[0].Instances[0].{State:State.Name,PublicIP:PublicIpAddress,InstanceType:InstanceType}" \
  --output table
```

The instance was verified as running with a public IP address and the `t3.micro` instance type.

## 🧪 Testing and Validation

The following checks were performed:

- Terraform initialization completed successfully.
- Terraform configuration validation passed.
- Terraform plan showed two resources to create.
- Terraform apply completed successfully.
- EC2 instance state was verified as `running`.
- Security group rules for SSH and HTTP were verified.
- AWS instance and system status checks returned `ok`.
- SSH connectivity was tested, but a successful SSH connection has not yet been established.

**SSH limitation:** The EC2 instance was created without an attached key pair. Normal key-based SSH login therefore remains incomplete and requires further configuration.

## 📸 Screenshots and Evidence

Add your practical screenshots to a folder named `screenshots/`, if required by your submission.

Suggested evidence:

1. `Task3_01_Terraform_Init.png`
2. `Task3_02_Terraform_Validate.png`
3. `Task3_03_Terraform_Plan.png`
4. `Task3_04_Terraform_Apply.png`
5. `Task3_05_EC2_Instance_Verification.png`
6. `Task3_06_SSH_Connectivity_Test.png`

Review screenshots before uploading to ensure they do not contain credentials, secret keys, tokens, or sensitive Terraform state.

## 🔐 Security and Best Practices

- Never commit AWS credentials to version control.
- Restrict SSH access to trusted IP addresses.
- Avoid exposing SSH to `0.0.0.0/0`.
- Add `.terraform/`, `terraform.tfstate`, and backup state files to `.gitignore`.
- Store credentials in GitHub Codespaces Secrets or another secure credential store.
- Review AWS resource costs and clean up resources when they are no longer required.

## 🧹 Cleanup

When the project is no longer needed, review the resources managed by Terraform and run:

```bash
terraform destroy
```

Review the destruction plan and type `yes` only if you intend to remove the Terraform-managed resources. This removes the resources managed by the current configuration and may affect anything still needed for evaluation.

## ✅ Result

Successfully used Terraform to provision an AWS EC2 instance and configure a security group allowing HTTP traffic and restricted SSH traffic. The instance was verified as running, and the Terraform deployment completed successfully. SSH login remains a pending validation step.



--
