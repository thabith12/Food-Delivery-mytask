# Task 17 – Blue-Green Deployment

## 1. Terraform Infrastructure

Terraform scripts were used to provision the AWS infrastructure.

- VPC: 10.0.0.0/16
- Public subnet: 10.0.1.0/24
- Private subnet: 10.0.2.0/24
- Bastion/Public EC2: 10.0.1.x
- Private EC2: 10.0.2.72
- Internet Gateway
- NAT Gateway
- Route tables and associations

The private EC2 was used to run the Kind Kubernetes cluster.

---

## 2. Kubernetes Setup

A Kind Kubernetes cluster was configured on the private EC2 instance.

The Food Delivery application was deployed using Kubernetes manifests.

The application components include:

- Frontend
- Backend
- MongoDB

---

## 3. Blue Deployment

The first version of the application was deployed in the `blue` namespace.

Blue pods were verified as healthy:

- Backend: 2/2 Running
- Frontend: 2/2 Running
- MongoDB: 1/1 Running

Blue services were exposed using Kubernetes ClusterIP services.

---

## 4. Green Deployment

The second version of the application was deployed in the `green` namespace.

Green pods were verified as healthy before traffic switching.

Green included:

- Backend
- Frontend
- MongoDB

---

## 5. Blue → Green Traffic Switching

The NGINX Ingress was initially configured for the Blue environment.

Blue traffic was verified using:

    curl -I http://127.0.0.1

Result:

    HTTP/1.1 200 OK

The Blue Ingress was backed up and removed.

The Green Ingress was then created:

    kubectl create -f green/ingress.yaml

The active ingress was verified:

    kubectl get ingress -A

Green became the active environment and returned:

    HTTP/1.1 200 OK

---

## 6. Failure Simulation

A controlled failure was introduced in the Green environment by scaling the Green frontend deployment to zero replicas:

    kubectl scale deployment food-frontend --replicas=0 -n green

The Green frontend pods were no longer available.

Traffic was tested:

    curl -I http://127.0.0.1

Result:

    HTTP/1.1 503 Service Temporarily Unavailable

This demonstrated the impact of a faulty Green deployment.

---

## 7. Rollback

Because Green was unavailable, traffic was switched back to Blue.

Green Ingress was removed:

    kubectl delete ingress food-ingress -n green

The previously backed-up Blue Ingress was restored:

    kubectl create -f blue-ingress-backup.yaml

The active ingress was verified:

    kubectl get ingress -A

Blue became the active environment.

---

## 8. Rollback Verification

Traffic was tested again:

    curl -I http://127.0.0.1

Result:

    HTTP/1.1 200 OK

Blue pods were also verified:

- Backend: 2/2 Running
- Frontend: 2/2 Running
- MongoDB: 1/1 Running

Therefore, rollback was successful and the previous stable version was serving traffic correctly.

---

## 9. Troubleshooting

### Private EC2 had no direct public IP

The application was running on a private EC2 instance with address 10.0.2.72.

A Bastion/Public EC2 was used for SSH access to the private instance.

### SSH key authentication

The same EC2 key pair private key was configured on the required instances to allow SSH authentication.

### Blue/Green Ingress switching

The Blue Ingress configuration was backed up before switching traffic.

This allowed the previous configuration to be restored during rollback.

### Green Ingress manifest path issue

The Green Ingress manifest could not be found when the command was executed outside the project directory.

The command was successfully executed after moving to:

    ~/Food-Delivery-mytask

### Green deployment failure

The Green frontend was intentionally scaled to zero replicas to simulate a deployment failure.

The Ingress returned HTTP 503, confirming the failure.

---

## 10. Final Result

The Blue-Green deployment process was successfully demonstrated:

    Blue Deployment
          ↓
    Green Deployment
          ↓
    Traffic Switch
          ↓
    Green Failure
          ↓
    HTTP 503
          ↓
    Rollback to Blue
          ↓
    HTTP 200

The stable Blue environment was successfully restored and verified.

---

## 11. Final Status

- Terraform infrastructure: Completed
- Kubernetes Kind cluster: Completed
- Blue deployment: Completed
- Green deployment: Completed
- Traffic switching: Completed
- Failure simulation: Completed
- Rollback: Completed
- Application health verification: Completed

