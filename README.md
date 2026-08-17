# 🍔 Food-Delivery-mytask

A production-oriented **MERN Food Delivery Application** with a complete **DevOps and Cloud deployment pipeline**.

This project was developed as part of my **DevOps Internship at Mise Academy**, where I implemented the application deployment lifecycle from containerization and CI/CD to Kubernetes orchestration, GitOps, AWS infrastructure provisioning, monitoring, database deployment, DNS, CDN, and HTTPS.

---

## 🚀 Project Overview

**Food-Delivery-mytask** is a full-stack food ordering application built using the **MERN stack** and progressively transformed into a cloud-ready, automated DevOps deployment.

The project demonstrates how a modern application can move from:

**Source Code → Docker → Jenkins CI/CD → Kubernetes → Helm → ArgoCD → AWS → Monitoring → Production Deployment**

### Key Areas Covered

* Full-stack MERN application
* Docker containerization
* Jenkins CI/CD
* GitHub Webhooks
* Kubernetes orchestration
* Blue-Green deployment
* Helm packaging
* ArgoCD GitOps
* ArgoCD Image Updater
* Terraform Infrastructure as Code
* Amazon EKS
* Amazon RDS
* Amazon EC2
* Amazon S3
* Amazon CloudFront
* Amazon Route 53
* AWS Certificate Manager
* Prometheus
* Grafana
* Amazon CloudWatch
* Amazon SNS
* Secure AWS networking
* Public and private subnets
* NAT Gateway
* Bastion Host

---

## 🏗️ High-Level Architecture

```text
                         ┌──────────────────────┐
                         │      GitHub Repo     │
                         │ Food-Delivery-mytask │
                         └──────────┬───────────┘
                                    │
                              GitHub Webhook
                                    │
                                    ▼
                         ┌──────────────────────┐
                         │       Jenkins        │
                         │      CI Pipeline     │
                         └──────────┬───────────┘
                                    │
                              Build & Test
                                    │
                                    ▼
                         ┌──────────────────────┐
                         │        Docker        │
                         │ Frontend + Backend   │
                         └──────────┬───────────┘
                                    │
                              Push Images
                                    │
                                    ▼
                         ┌──────────────────────┐
                         │    Container Registry│
                         │      Docker Hub      │
                         └──────────┬───────────┘
                                    │
                                    ▼
                         ┌──────────────────────┐
                         │       ArgoCD         │
                         │       GitOps         │
                         └──────────┬───────────┘
                                    │
                                    ▼
                         ┌──────────────────────┐
                         │ Kubernetes / EKS     │
                         │                      │
                         │ Frontend             │
                         │ Backend              │
                         │ MongoDB / RDS        │
                         └──────────┬───────────┘
                                    │
                       ┌────────────┴────────────┐
                       ▼                         ▼
                ┌──────────────┐         ┌──────────────┐
                │ CloudFront   │         │   Route 53   │
                │     CDN      │         │     DNS      │
                └──────┬───────┘         └──────┬───────┘
                       │                         │
                       └───────────┬─────────────┘
                                   ▼
                              End Users
```

---

# 🛠️ Technology Stack

## Application

| Layer           | Technology           |
| --------------- | -------------------- |
| Frontend        | React / Vite         |
| Backend         | Node.js / Express.js |
| Database        | MongoDB              |
| Authentication  | JWT                  |
| Payments        | Stripe               |
| Package Manager | npm                  |

## DevOps

| Area               | Technology           |
| ------------------ | -------------------- |
| Version Control    | Git / GitHub         |
| CI/CD              | Jenkins              |
| Containerization   | Docker               |
| Orchestration      | Kubernetes           |
| Package Management | Helm                 |
| GitOps             | ArgoCD               |
| Image Automation   | ArgoCD Image Updater |
| IaC                | Terraform            |

## AWS

| Service                 | Purpose                                        |
| ----------------------- | ---------------------------------------------- |
| Amazon EC2              | Compute / Bastion / Application infrastructure |
| Amazon EKS              | Managed Kubernetes                             |
| Amazon RDS              | Managed relational database                    |
| Amazon S3               | Static hosting / Terraform state               |
| Amazon CloudFront       | CDN                                            |
| Amazon Route 53         | DNS                                            |
| AWS Certificate Manager | SSL/TLS certificates                           |
| VPC                     | Network isolation                              |
| NAT Gateway             | Private subnet internet access                 |
| Internet Gateway        | Public internet access                         |
| SNS                     | Alert notifications                            |
| CloudWatch              | Monitoring and logging                         |

## Monitoring

* Prometheus
* Node Exporter
* Grafana
* Amazon CloudWatch
* CloudWatch Agent
* Amazon SNS

---

# ✨ Application Features

The application provides the core functionality expected from a food delivery platform.

### 👤 User Features

* User registration
* User authentication
* JWT-based authentication
* Browse food items
* Add items to cart
* Manage cart
* Place orders
* Order processing
* Payment integration

### 👨‍💼 Admin Features

* Admin dashboard
* Food management
* Order management
* User/order administration
* Backend API management

---

# 🐳 Docker Containerization

The application is containerized into separate services.

### Frontend

```text
React / Vite
     ↓
Multi-stage Docker Build
     ↓
Nginx
     ↓
Port 80
```

### Backend

```text
Node.js / Express
     ↓
Docker Container
     ↓
Backend API
```

Docker provides:

* Consistent environments
* Portable deployments
* Isolated services
* Reproducible builds
* Easier Kubernetes deployment

---

# 🔄 CI/CD Pipeline

The project implements an automated CI/CD pipeline using **Jenkins** and **GitHub Webhooks**.

```text
Developer
    │
    ▼
Git Push
    │
    ▼
GitHub
    │
    │ Webhook
    ▼
Jenkins
    │
    ├── Checkout Source
    ├── Build Application
    ├── Build Docker Images
    ├── Tag Images
    ├── Push Images
    └── Trigger Deployment Flow
             │
             ▼
          ArgoCD
             │
             ▼
       Kubernetes
```

### Jenkins Pipeline

The repository contains a `Jenkinsfile` that automates the application build and deployment workflow.

The pipeline includes activities such as:

* Source code checkout
* Application build
* Docker image creation
* Docker image tagging
* Docker image publishing
* Deployment integration

---

# ☸️ Kubernetes

Kubernetes is used to orchestrate the application containers.

The project includes Kubernetes configurations for:

* Frontend Deployment
* Backend Deployment
* MongoDB
* Services
* Ingress
* ConfigMaps
* Secrets
* Persistent Volumes
* Persistent Volume Claims
* StorageClass

### Example Application Flow

```text
                   Ingress
                      │
          ┌───────────┴───────────┐
          ▼                       ▼
     Frontend Service        Backend Service
          │                       │
          ▼                       ▼
     Frontend Pods           Backend Pods
                                  │
                                  ▼
                            Database Service
                                  │
                                  ▼
                             MongoDB
```

---

# 🔵🟢 Blue-Green Deployment

The project implements a **Blue-Green Deployment strategy** to reduce deployment risk and downtime.

```text
                 Ingress
                    │
                    ▼
             Active Environment
                    │
          ┌─────────┴─────────┐
          ▼                   ▼
       🔵 BLUE              🟢 GREEN
       Stable              New Version
```

### Deployment Strategy

1. Blue environment runs the stable application.
2. Green environment is deployed separately.
3. New version is tested in Green.
4. Traffic is switched from Blue to Green.
5. Blue remains available for rollback.
6. If the Green deployment fails, traffic can be redirected to Blue.

Repository directories:

```text
blue/
green/
```

---

# ⛵ Helm

Helm is used to package and manage Kubernetes deployments.

The project includes:

```text
food-delivery-chart/
```

Helm manages Kubernetes resources such as:

* Deployments
* Services
* Ingress
* Configurations
* Image versions
* Replica counts

This makes Kubernetes deployment more reusable and configurable.

---

# 🔱 ArgoCD & GitOps

The project uses **ArgoCD** to implement a GitOps-based deployment workflow.

```text
GitHub
   │
   │ Desired State
   ▼
 ArgoCD
   │
   │ Sync
   ▼
Kubernetes Cluster
```

ArgoCD continuously monitors the Git repository and synchronizes the Kubernetes environment with the desired configuration stored in Git.

### Benefits

* Git as the source of truth
* Automated synchronization
* Deployment visibility
* Easy rollback
* Declarative infrastructure
* Continuous reconciliation

---

# 🤖 ArgoCD Image Updater

ArgoCD Image Updater is used to automate container image version updates.

```text
Application Change
       │
       ▼
Docker Image Build
       │
       ▼
Docker Hub
       │
       ▼
ArgoCD Image Updater
       │
       ▼
Helm Values Updated
       │
       ▼
ArgoCD Sync
       │
       ▼
Kubernetes
```

This reduces manual image version updates during application deployment.

---

# ☁️ AWS Infrastructure

AWS infrastructure is provisioned using **Terraform**.

The project includes infrastructure for:

* VPC
* Public subnet
* Private subnet
* Internet Gateway
* NAT Gateway
* Elastic IP
* Route Tables
* EC2
* EKS
* RDS
* S3
* CloudFront
* Route 53
* ACM

---

# 🏗️ Terraform Infrastructure as Code

Terraform is used to provision AWS infrastructure declaratively.

Example structure:

```text
terraform-project/
├── main.tf
├── variables.tf
├── outputs.tf
├── providers.tf
└── terraform.tfvars
```

Terraform enables:

* Infrastructure automation
* Reproducible environments
* Version-controlled infrastructure
* Easier infrastructure changes
* Reduced manual configuration

---

# 🌐 AWS Networking

The infrastructure uses a custom VPC architecture.

```text
                     AWS VPC
                  10.0.0.0/16
                       │
          ┌────────────┴────────────┐
          │                         │
          ▼                         ▼
    Public Subnet             Private Subnet
    10.0.1.0/24               10.0.2.0/24
          │                         │
          ▼                         ▼
      Bastion EC2              Private EC2
          │                         │
          │                    NAT Gateway
          │                         │
          └──────────────┬──────────┘
                         │
                   Internet Gateway
```

### Security Approach

* Public resources are placed in public subnets.
* Private workloads are isolated in private subnets.
* SSH access to private resources is routed through the Bastion Host.
* NAT Gateway provides outbound internet access for private resources.
* Security Groups restrict unnecessary inbound traffic.

---

# ☸️ Amazon EKS

Amazon EKS is used to run Kubernetes workloads in AWS.

Terraform is used to provision the EKS infrastructure.

The deployment includes:

* EKS cluster
* Node groups
* Kubernetes workloads
* Storage configuration
* Services
* Ingress
* Helm deployment
* ArgoCD integration

---

# 🗄️ Amazon RDS

The project also includes an AWS RDS deployment task.

The RDS configuration demonstrates:

* Terraform-based database provisioning
* Private database deployment
* Security Group configuration
* Database connectivity
* Infrastructure automation

---

# 🌍 DNS with Route 53

Amazon Route 53 is used for DNS management.

The deployment demonstrates:

```text
Domain
   │
   ▼
Route 53
   │
   ▼
AWS Infrastructure
   │
   ▼
Application
```

This allows the application to be accessed using a domain name instead of relying directly on an IP address.

---

# 🚀 CloudFront CDN

Amazon CloudFront is used to provide global content delivery.

```text
User
 │
 ▼
CloudFront
 │
 ├── Cache
 │
 └── Origin
       │
       ▼
   Application
```

Benefits:

* Lower latency
* Global content delivery
* CDN caching
* Improved application performance
* HTTPS support

---

# 🔐 HTTPS with AWS Certificate Manager

AWS Certificate Manager is used to provide SSL/TLS certificates.

The HTTPS flow is:

```text
User
  │
  │ HTTPS
  ▼
CloudFront
  │
  ▼
Application
```

This provides encrypted communication between users and the deployed application.

---

# 📊 Monitoring & Observability

The project implements monitoring using both AWS and open-source monitoring tools.

## Prometheus

Prometheus collects infrastructure and application metrics.

Node Exporter is used to expose system-level metrics.

```text
Node Exporter
      │
      ▼
 Prometheus
      │
      ▼
   Metrics
```

Metrics include:

* CPU usage
* Memory usage
* Disk usage
* System performance

---

# 📈 Grafana

Grafana is connected to Prometheus as a data source.

```text
Node Exporter
      │
      ▼
 Prometheus
      │
      ▼
 Grafana
      │
      ▼
Dashboards
```

Grafana provides visual dashboards for infrastructure monitoring.

---

# ☁️ Amazon CloudWatch

AWS CloudWatch is used for cloud infrastructure monitoring and log collection.

The CloudWatch Agent collects metrics including:

* CPU usage
* Memory usage
* Disk usage

Application/system logs can also be collected for troubleshooting and observability.

---

# 🔔 Amazon SNS Alerts

Amazon SNS is integrated with CloudWatch alarms for notifications.

Example monitoring conditions include:

```text
CPU > Threshold
       │
       ▼
CloudWatch Alarm
       │
       ▼
SNS Topic
       │
       ▼
Email Notification
```

Configured monitoring includes:

* High CPU usage
* High memory usage
* Application error conditions

---

# 📁 Repository Structure

```text
Food-Delivery-mytask/
│
├── admin/
├── aws/
├── backend/
├── blue/
├── green/
├── kubernetes/
│
├── food-delivery-chart/
├── helm-backup/
│
├── task20-eks/
├── task21-rds/
├── task22-static-site/
├── task22-terraform/
│
├── terraform-project/
│
├── Jenkinsfile
├── docker-compose.yml
├── README.md
│
├── TASK-17.md
├── TASK-22.md
├── TROUBLESHOOTING.md
│
└── .gitignore
```

---

# 🔧 Local Development

## Prerequisites

Install:

* Node.js
* npm
* MongoDB
* Git
* Docker

### Clone Repository

```bash
git clone https://github.com/thabith12/Food-Delivery-mytask.git

cd Food-Delivery-mytask
```

---

## Backend Setup

```bash
cd backend

npm install
```

Create an environment file:

```env
PORT=4000
MONGO_URL=<your-mongodb-url>
JWT_SECRET=<your-jwt-secret>
SALT=<your-salt>
STRIPE_SECRET_KEY=<your-stripe-secret>
FRONTEND_URL=<your-frontend-url>
```

Start the backend:

```bash
npm start
```

---

## Frontend Setup

```bash
cd frontend

npm install

npm run dev
```

The frontend can then be accessed through the Vite development server.

---

# 🐳 Run with Docker

Build the application containers:

```bash
docker build -t food-backend ./backend

docker build -t food-frontend ./frontend
```

Run the containers according to the application's environment configuration.

Alternatively, Docker Compose configuration is available in:

```text
docker-compose.yml
```

---

# ☸️ Kubernetes Deployment

Create or use a Kubernetes cluster and deploy the application manifests.

Example:

```bash
kubectl apply -f kubernetes/
```

Verify deployments:

```bash
kubectl get pods
kubectl get services
kubectl get deployments
```

Check cluster nodes:

```bash
kubectl get nodes
```

---

# ⛵ Helm Deployment

Navigate to the Helm chart:

```bash
cd food-delivery-chart
```

Install the application:

```bash
helm install food-delivery .
```

Check the deployment:

```bash
helm list
```

---

# 🔱 ArgoCD Deployment

ArgoCD is configured to monitor the Git repository and deploy the Helm-based application.

Typical GitOps workflow:

```text
Git Commit
    │
    ▼
GitHub
    │
    ▼
ArgoCD detects change
    │
    ▼
ArgoCD Sync
    │
    ▼
Kubernetes
```

---

# 🧪 Troubleshooting

A dedicated troubleshooting document is maintained in:

```text
TROUBLESHOOTING.md
```

It contains solutions and notes related to:

* Kubernetes pod failures
* Networking issues
* Docker problems
* Application configuration
* Ingress issues
* Deployment problems
* AWS infrastructure issues

---

# 📋 DevOps Task Progress

The project was developed incrementally through multiple DevOps tasks.

| Task    | Main Area                           |
| ------- | ----------------------------------- |
| Task 13 | Helm                                |
| Task 15 | Jenkins / CI/CD / ArgoCD            |
| Task 16 | Terraform + Kubernetes              |
| Task 17 | Blue-Green Deployment               |
| Task 18 | Monitoring & Observability          |
| Task 20 | Amazon EKS                          |
| Task 21 | Amazon RDS                          |
| Task 22 | Route 53 + CloudFront + EC2 + HTTPS |

This progression demonstrates the transformation of a traditional web application into a cloud-native deployment.

---

# 🔄 Complete DevOps Workflow

The overall project workflow can be summarized as:

```text
                 ┌──────────────┐
                 │    GitHub    │
                 └──────┬───────┘
                        │
                  Webhook / Push
                        │
                        ▼
                 ┌──────────────┐
                 │   Jenkins    │
                 └──────┬───────┘
                        │
                  Build & Test
                        │
                        ▼
                 ┌──────────────┐
                 │    Docker    │
                 └──────┬───────┘
                        │
                   Push Images
                        │
                        ▼
                 ┌──────────────┐
                 │  Docker Hub  │
                 └──────┬───────┘
                        │
                        ▼
                 ┌──────────────┐
                 │    ArgoCD    │
                 │    GitOps    │
                 └──────┬───────┘
                        │
                        ▼
                 ┌──────────────┐
                 │ Kubernetes / │
                 │     EKS      │
                 └──────┬───────┘
                        │
            ┌───────────┼───────────┐
            ▼           ▼           ▼
        Frontend     Backend     Database
            │           │           │
            └───────────┼───────────┘
                        │
                        ▼
              AWS Production Layer
                        │
             ┌──────────┴──────────┐
             ▼                     ▼
         CloudFront             Route 53
             │                     │
             └──────────┬──────────┘
                        ▼
                       Users

Monitoring:
Prometheus → Grafana
CloudWatch → SNS → Email
```

---

# 🎯 Key DevOps Skills Demonstrated

This project demonstrates practical experience in:

* Linux
* Git & GitHub
* GitHub Webhooks
* Docker
* Docker Compose
* Jenkins
* CI/CD
* Kubernetes
* Kubernetes Networking
* Ingress
* Persistent Storage
* Helm
* ArgoCD
* GitOps
* Blue-Green Deployment
* ArgoCD Image Updater
* Terraform
* AWS VPC
* AWS EC2
* Amazon EKS
* Amazon RDS
* Amazon S3
* Amazon CloudFront
* Amazon Route 53
* AWS Certificate Manager
* AWS CloudWatch
* Amazon SNS
* Prometheus
* Grafana
* Infrastructure as Code
* Cloud Networking
* Monitoring & Observability

---

# 🔒 Security Considerations

Sensitive credentials should **never** be committed to the repository.

Use:

* Environment variables
* Kubernetes Secrets
* AWS IAM
* Security Groups
* Private subnets
* `.gitignore`
* Secure Terraform variables

Example:

```text
.env
*.pem
*.key
terraform.tfvars
```

should be excluded from Git when they contain secrets or private credentials.

> **Important:** Never commit real AWS private keys, passwords, API keys, database credentials, or other secrets to GitHub.

---

# 📚 Project Documentation

Additional project documentation is available inside the repository:

```text
TASK-17.md
TASK-22.md
TROUBLESHOOTING.md
CHANGES.md
```

These documents provide additional implementation details and troubleshooting information.

---

# 🎓 Internship Project

This project was developed as part of my **DevOps Internship at Mise Academy**.

Throughout the project, I gained hands-on experience in designing, automating, deploying, and monitoring a full-stack application using modern DevOps and cloud technologies.

The project helped me understand the complete application delivery lifecycle:

**Development → Containerization → CI/CD → Orchestration → GitOps → Cloud Infrastructure → Production Deployment → Monitoring**

---

# 👨‍💻 Author

**Mohamed Thabith**

Computer Systems & Network Engineering Undergraduate
SLIIT — Sri Lanka

### GitHub

https://github.com/thabith12

### Project Repository

https://github.com/thabith12/Food-Delivery-mytask

---

# ⭐ Acknowledgement

This project was completed as part of my **DevOps Internship at Mise Academy**, with a focus on gaining practical experience in **AWS, Kubernetes, Terraform, Docker, Jenkins, Helm, ArgoCD, CI/CD, GitOps, and cloud-native application deployment**.

---

## ⭐ If you find this project useful

Feel free to explore the repository, review the implementation, and follow the DevOps deployment journey.
