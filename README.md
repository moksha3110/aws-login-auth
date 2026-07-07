# 🔐 AWS Serverless Login Authentication System

A secure, cloud-native Login Authentication System built using AWS services and Infrastructure as Code (Terraform). The application provides user registration and login with encrypted passwords, JWT authentication, and a highly available cloud architecture.

---

## 🚀 Features

- User Signup
- User Login
- Password hashing using bcrypt
- JWT Authentication
- MySQL (Amazon RDS)
- AWS Lambda Backend
- API Gateway REST API
- React Frontend
- Nginx Web Server
- Application Load Balancer
- Secrets stored securely using AWS Secrets Manager
- Infrastructure provisioned using Terraform

---

## 🏗️ Architecture

```
                Internet
                    │
                    ▼
        Application Load Balancer
                    │
                    ▼
          EC2 (React + Nginx)
                    │
                    ▼
             API Gateway (REST)
              /login   /signup
                    │
                    ▼
             AWS Lambda Functions
                    │
        ┌───────────┴───────────┐
        ▼                       ▼
 AWS Secrets Manager       Amazon RDS
 (Database Credentials)     MySQL Database
```

---

## 🛠️ Tech Stack

### Frontend
- React
- React Router
- Axios
- CSS3

### Backend
- Node.js
- AWS Lambda
- API Gateway
- bcryptjs
- JSON Web Tokens (JWT)
- mysql2

### Cloud Services
- Amazon EC2
- Amazon RDS (MySQL)
- AWS Lambda
- API Gateway
- AWS Secrets Manager
- Amazon CloudWatch
- Application Load Balancer
- IAM
- VPC
- Security Groups

### Infrastructure
- Terraform

---

## 📁 Project Structure

```
aws-login-auth/
│
├── backend/
│   ├── handlers/
│   │   ├── login.js
│   │   └── signup.js
│   │
│   ├── database/
│   │   └── db.js
│   │
│   ├── utils/
│   │   └── secrets.js
│   │
│   └── package.json
│
├── frontend/
│   ├── src/
│   │   ├── pages/
│   │   ├── api/
│   │   └── App.jsx
│   │
│   └── package.json
│
├── terraform/
│   ├── vpc.tf
│   ├── ec2.tf
│   ├── rds.tf
│   ├── lambda.tf
│   ├── api_gateway.tf
│   ├── iam.tf
│   ├── alb.tf
│   └── ...
│
└── README.md
```

---

## 🔒 Authentication Flow

1. User signs up from the React frontend.
2. API Gateway invokes the Signup Lambda.
3. Lambda retrieves database credentials from AWS Secrets Manager.
4. Password is hashed using bcrypt.
5. User details are stored in Amazon RDS.
6. During login, Lambda validates credentials.
7. A JWT token is generated.
8. Token is stored in the browser for authenticated access.

---

## ☁️ AWS Services Used

| Service | Purpose |
|----------|----------|
| EC2 | Hosts React application with Nginx |
| Application Load Balancer | Routes incoming traffic |
| API Gateway | REST API endpoints |
| AWS Lambda | Backend business logic |
| Amazon RDS | MySQL database |
| AWS Secrets Manager | Secure database credentials |
| CloudWatch | Logging and monitoring |
| IAM | Access management |
| VPC | Network isolation |
| Security Groups | Firewall rules |

---

## 🔐 Security Features

- Password hashing with bcrypt
- JWT authentication
- Secrets stored in AWS Secrets Manager
- Private RDS deployment
- IAM least privilege permissions
- VPC isolation
- Security Groups for controlled access

---

## 🚀 Deployment

Infrastructure is deployed using Terraform.

```bash
terraform init
terraform plan
terraform apply
```

Frontend deployment:

```bash
cd frontend

npm install
npm run build

sudo rm -rf /var/www/html/*
sudo cp -r dist/* /var/www/html/
sudo systemctl restart nginx
```

---

## 📸 Screenshots

<img width="2874" height="1524" alt="image" src="https://github.com/user-attachments/assets/393d0c36-9529-4af6-bef7-ab41f5852f07" />
<img width="2878" height="1530" alt="image" src="https://github.com/user-attachments/assets/27feed65-b158-47bc-b4cb-3b5f7461b81e" />
<img width="2844" height="1530" alt="image" src="https://github.com/user-attachments/assets/85b50c9e-7d0e-424a-8a15-ef87ac00ecaf" />
<img width="800" height="409" alt="image" src="https://github.com/user-attachments/assets/7beff1d3-2aee-4af9-874c-48b5763028da" />
<img width="2220" height="892" alt="image" src="https://github.com/user-attachments/assets/1ed2f3dc-acb5-4c7a-937f-1f4334606c4f" />
---

## 👨‍💻 Author

**Rudraraju Surya Moksha**

B.Tech Computer Science

Built as part of a Cloud Computing Internship using AWS and Terraform.

---

## 📜 License

This project is developed for educational and internship purposes.
