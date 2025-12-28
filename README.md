
## Terraform AWS NAT Instance Lab

This repository contains a Terraform-based AWS infrastructure lab where a **custom VPC with public and private subnets** is provisioned using a **NAT instance** (not NAT Gateway).  
The infrastructure was **created, verified, and safely destroyed** following best practices.

---

## 📌 What This Project Demonstrates

This project demonstrates practical, hands-on understanding of:

- AWS VPC networking fundamentals
- CIDR planning and subnet isolation
- Public vs private subnet design
- Internet Gateway vs NAT instance
- Bastion host (jump server) access pattern
- Terraform AWS provider (v5) behavior
- Secure IAM usage for Terraform
- Safe infrastructure lifecycle (create → verify → destroy)

---

## 🏗️ Architecture Overview

**VPC CIDR:** `10.0.0.0/16`

### Subnets

- **Public Subnet:** `10.0.0.0/24`
- **Private Subnet:** `10.0.1.0/24`

### Compute

- **NAT Instance**
  - Deployed in public subnet
  - Provides outbound internet access for private subnet
- **Public EC2**
  - Acts as a bastion (SSH access point)
- **Private EC2**
  - No public IP
  - Internet access only via NAT instance

### Networking

- Internet Gateway attached to VPC
- Public route table → `0.0.0.0/0` → Internet Gateway
- Private route table → `0.0.0.0/0` → NAT instance (via ENI)

---

## 🔐 Security Design

- **Security Groups**
  - Public EC2 allows SSH (port 22)
  - Private EC2 allows SSH only from public EC2 security group
  - NAT instance allows outbound traffic forwarding
- **IAM**
  - Terraform authenticated using a dedicated IAM user (not root)
  - Permissions assigned via IAM group
- **SSH**
  - EC2 key pair referenced by name
  - Private key (`.pem`) stored locally and never committed

---

## ⚙️ Terraform Highlights

- Uses `aws_ami` data source to dynamically fetch the latest Ubuntu 22.04 AMI
- Restricts AMI selection to Canonical-owned images
- Uses ENI-based routing (`network_interface_id`) for NAT instance
- Compatible with Terraform AWS provider v5+
- Variables used for configurability (e.g., key pair name)

---

## 🚀 Usage

### Initialize Terraform

```bash
terraform init
```

### Validate configuration

```bash
terraform validate
```

### Plan infrastructure

```bash
terraform plan
```

### Apply (create infrastructure)

```bash
terraform apply
```

### Verify

- SSH into public EC2
- SSH from public EC2 to private EC2
- Run `sudo apt update` from private EC2 to confirm NAT access

### Destroy (clean teardown)

```bash
terraform destroy
```

---

## 🧹 Cleanup & Safety

- All infrastructure was destroyed using `terraform destroy`
- Verified:

  - No running EC2 instances
  - No custom VPCs remaining
  - Terraform state is empty

- No ongoing AWS costs

---

## 🔒 Repository Hygiene

The following are intentionally **excluded** from version control:

- Terraform state files
- `.terraform/` directory
- `.pem` SSH keys
- `.tfvars` files

This ensures no credentials or sensitive data are exposed.

---

## 🧠 Key Learnings

- NAT instances require explicit routing via network interfaces
- AMI IDs are region-specific
- Terraform destroys only what is tracked in state
- SSH access depends entirely on security group rules
- Infrastructure should always be verified before destruction

---

## 📎 Notes

This project is intended as a **learning and portfolio lab**, not production infrastructure.
It focuses on understanding AWS networking and Terraform behavior rather than managed services like NAT Gateway.

---

## ✅ Status

✔ Infrastructure created
✔ Connectivity verified
✔ Infrastructure destroyed safely
✔ AWS account left clean

---

## 📜 License

This project is licensed under the **MIT License**.

You are free to:

- Use
- Modify
- Distribute
- Learn from this code

No warranty is provided.  
This project is intended for **educational and portfolio purposes**.

---

## 🤝 Contributions

This is a personal learning project, but suggestions and improvements are welcome.

If you’d like to contribute:

1. Fork the repository
2. Create a feature branch
3. Submit a pull request with a clear description

---

## 📌 Disclaimer

- This project is **not production-ready infrastructure**
- It is intentionally designed for **learning AWS networking and Terraform**
- Do not deploy this directly in production environments
- Always review and customize security rules before real-world use

---

## 🙌 Acknowledgements

- AWS documentation
- Terraform documentation
- Hands-on experimentation and debugging

---

## ✍️ Author

**Swaroop C H**

DevOps & Cloud Enthusiast  
Focused on learning infrastructure design, automation, and cloud security.

---

## ⭐ If You Found This Useful

If this project helped you understand:

- Terraform basics
- AWS VPC networking
- NAT instance behavior

Feel free to ⭐ the repository or use it as a reference.

---