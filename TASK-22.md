# Task 22 — DNS, CloudFront, SSL/TLS and Secure Web Deployment

## 1. Objective

Deploy static and dynamic websites using AWS S3 and EC2, configure CloudFront CDN, secure S3 using CloudFront OAC, configure Nginx reverse proxy and PM2, and automate infrastructure verification using Terraform.

## 2. Static Website Architecture

User
→ CloudFront
→ OAC
→ Private S3
→ index.html

### Static resources

- S3 bucket: task22-static-thabith12-643603452212
- CloudFront distribution: E3PU3GRJ409WQJ
- CloudFront domain: dz1wqfr6olpep.cloudfront.net
- Default root object: index.html
- S3 public access: Blocked
- CloudFront OAC: Enabled

## 3. Dynamic Website Architecture

User
→ CloudFront
→ EC2
→ Nginx
→ Node.js
→ PM2

### Dynamic resources

- EC2 instance: i-0f23212b6b89cfd70
- EC2 public IP: 13.63.131.154
- EC2 public DNS: ec2-13-63-131-154.eu-north-1.compute.amazonaws.com
- Nginx: Port 80
- Node.js: Port 4000
- Node.js binding: 127.0.0.1:4000
- PM2 application: task22-app
- CloudFront distribution: E2M2BLLLSRI2E3
- CloudFront domain: d3lkds2qsvkibr.cloudfront.net

## 4. Security

- S3 Block Public Access enabled
- S3 accessed through CloudFront OAC
- Node.js port 4000 is not publicly exposed
- SSH restricted to administrator IP
- HTTP exposed through port 80
- CloudFront WAF enabled
- PM2 configured for startup
- Nginx used as reverse proxy

## 5. CloudFront Cache Invalidation

Updated S3 website content and created invalidation:

Path: /*

Status: Completed

Invalidation ID: IBVFTNLVYPHKGT5AIHNM82NUCV

## 6. Terraform

Terraform version: 1.15.8

Terraform was used to reference and verify existing infrastructure without recreating resources.

Result:

Resources: 0 added, 0 changed, 0 destroyed.

## 7. Validation Commands

aws s3 ls s3://task22-static-thabith12-643603452212/

curl http://localhost

curl http://localhost/health

terraform validate

terraform plan

terraform apply

terraform output

terraform state list

## 8. Problems and Solutions

### CloudFront DNS error

Problem:
DNS_PROBE_FINISHED_NXDOMAIN

Solution:
Waited for CloudFront deployment to complete.

### S3 AccessDenied

Problem:
CloudFront returned AccessDenied.

Solution:
Verified CloudFront OAC and S3 bucket policy.

### CloudFront 504

Problem:
CloudFront could not contact EC2 origin.

Solution:
Corrected EC2 public DNS origin from the incorrect hostname to:
ec2-13-63-131-154.eu-north-1.compute.amazonaws.com

### PM2 script not found

Problem:
PM2 could not find server.js.

Solution:
Moved to ~/task22-app before starting PM2.

## 9. Current Status

Static Website: Completed

Dynamic Website: Completed

CloudFront CDN: Completed

Nginx Reverse Proxy: Completed

PM2: Completed

Cache Invalidation: Completed

Terraform Verification: Completed

ACM Custom Domain: Pending domain registration

Route 53 Custom Domain: Pending domain registration
