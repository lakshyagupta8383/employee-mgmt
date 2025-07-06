# Employee Management System - DevOps CI/CD Setup

This project demonstrates a full CI/CD pipeline with Jenkins, Maven, Docker, Ansible, Graphite, and Grafana using WSL.

## 🧰 Prerequisites (run inside WSL)

```bash
sudo apt update && sudo apt upgrade -y
sudo apt install git maven openjdk-17-jdk docker.io ansible terraform unzip -y
```

## 🧱 Project Structure

```
employee-mgmt/
├── Dockerfile
├── Jenkinsfile
├── README.md
├── pom.xml
├── src/
│   ├── main/java/com/example/employee/
│   │   ├── Application.java
│   │   └── controller/EmployeeController.java
│   └── test/java/com/example/employee/ApplicationTests.java
├── ansible/
│   ├── deploy.yml
│   └── hosts
└── monitoring/
    └── docker-compose.yml
```

## ⚙️ Setup Steps

### 1. Clone & Build App

```bash
cd employee-mgmt
mvn clean package
```

### 2. Run Locally with Docker

```bash
docker build -t employee-app .
docker run -p 8080:8080 employee-app
```

### 3. Start Jenkins

```bash
sudo service jenkins start
```

Visit [http://localhost:8080](http://localhost:8080)

### 4. Start Monitoring Stack

```bash
cd monitoring
docker-compose up -d
```

- Grafana: [http://localhost:3000](http://localhost:3000)
- Graphite: [http://localhost:80](http://localhost:80)

### 5. Run Ansible Deployment

```bash
ansible-playbook -i ansible/hosts ansible/deploy.yml
```

### 6. Jenkins Pipeline

Configure a Jenkins job with a pipeline script or point it to `Jenkinsfile`.

---

## ✅ Done! Your app is live, tested, containerized, deployed, and monitored.
