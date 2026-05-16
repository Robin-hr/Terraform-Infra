# 🏗️ Secure Bastion Host Infrastructure — Terraform on AWS

A self-learning project to understand production-grade AWS network architecture using Terraform as Infrastructure as Code (IaC). This project provisions a highly available, secure web server environment with proper network segmentation, a hardened Bastion Host for private access, and an Application Load Balancer for traffic distribution.

---

## 🎯 What I Was Trying to Learn

- How to design a VPC with proper public/private subnet separation
- Why a Bastion Host is used instead of directly exposing private EC2 instances
- How an ALB distributes traffic across multiple instances
- How Security Groups enforce least-privilege access at the network level
- How to write clean, separated Terraform code across multiple `.tf` files

---

## 🏛️ Architecture

```
Internet
    │
    ▼
[Application Load Balancer]  ← Public Subnet (us-east-1a / us-east-1b)
    │
    ▼
[Private EC2 Web Server]     ← Private Subnet (no direct internet access)
    ▲
    │
[Bastion Host]               ← Public Subnet (SSH jump server)
    ▲
    │
[Engineer's machine]         ← SSH via PEM key → Bastion → Private EC2
```

**Key design decision:** The web server EC2 sits in a private subnet with no public IP. The only way to SSH into it is through the Bastion Host — this eliminates direct attack surface on the production server.

---

## 📁 File Structure

| File | What it does |
|---|---|
| `main.tf` | AWS provider configuration |
| `vpc.tf` | VPC with DNS support enabled (`10.0.0.0/16`) |
| `publicsubnet.tf` | Public subnets for Bastion Host and ALB |
| `privatesubnet.tf` | Private subnet for the web server EC2 |
| `sg.tf` | Security Groups — controls who can talk to what |
| `ec2.tf` | Bastion Host + Web Server EC2 instances |
| `alb.tf` | Application Load Balancer configuration |
| `targetgroup.tf` | Target group + health check rules |
| `variable.tf` | Input variables for reusability |

---

## 🔒 Security Design Decisions

- **Bastion Host only allows SSH (port 22)** from a specific IP — not `0.0.0.0/0`
- **Web server Security Group** only accepts traffic from the ALB Security Group — not the open internet
- **Private EC2** has no public IP assigned
- **ALB** handles all public-facing HTTP/HTTPS traffic

---

## 🧰 Tech Stack

- **Terraform** — Infrastructure as Code
- **AWS VPC** — Custom network with CIDR `10.0.0.0/16`
- **AWS EC2** — Bastion Host + Web Server
- **AWS ALB** — Application Load Balancer with health checks
- **AWS Security Groups** — Least-privilege network access control

---

## 🚀 How to Deploy

### Prerequisites
- AWS CLI configured (`aws configure`)
- Terraform installed (`terraform -v`)
- An existing EC2 Key Pair in your AWS account

### Steps

```bash
# Clone the repo
git clone https://github.com/Robin-hr/Terraform-Infra.git
cd Terraform-Infra

# Initialize Terraform
terraform init

# Preview what will be created
terraform plan

# Deploy the infrastructure
terraform apply

# When done learning — destroy all resources (avoid AWS charges)
terraform destroy
```

---

## 💡 What I Learned

- **Subnet design matters** — putting everything in a public subnet is an anti-pattern. Private subnets for compute, public for edge services.
- **Security Groups are stateful** — you only need to define inbound rules; return traffic is automatically allowed.
- **ALB health checks** — the target group won't route traffic to an instance unless it passes health checks. This was a debugging moment I didn't expect.
- **Bastion vs SSM** — Bastion Hosts are the traditional approach; AWS Systems Manager Session Manager is the modern alternative (no open port 22 needed). Next thing to explore.

---

## 🔭 What I'd Add Next (Enhancements Planned)

- [ ] Refactor into Terraform **modules** (`modules/networking`, `modules/compute`)
- [ ] Add **NAT Gateway** so private EC2 can pull updates without a public IP
- [ ] Add **AWS SSM Session Manager** as an alternative to Bastion Host
- [ ] Add **CloudWatch alarms** for CPU and network metrics
- [ ] Add **S3 remote backend** for Terraform state management
- [ ] Add **GitHub Actions** workflow to run `terraform validate` and `terraform plan` on every PR

---

## 📌 Status

> ✅ Learning project — infrastructure was successfully deployed and destroyed.
> Architecture validated, all resources created and accessible as designed.

---

## 👤 Author

**Hebrus Robin** — AWS Certified Solutions Architect (SAA-C03)
- LinkedIn: [linkedin.com/in/hebrus-robin](https://linkedin.com/in/hebrus-robin)
- GitHub: [github.com/Robin-hr](https://github.com/Robin-hr)
