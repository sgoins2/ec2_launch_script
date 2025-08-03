# ☁️ EC2 Apache Deployment on AWS – Level-Up Bank Project

## 📌 Project Overview

This project simulates a real-world use case for a bank migrating its web application from an on-premises server to the cloud using AWS EC2. The objective is to launch, configure, and scale a cloud-based web server using the AWS CLI.
---

## 🔧 Technologies Used

- **AWS EC2 (t2.micro)**
- **Amazon Linux 2023**
- **Apache Web Server (httpd)**
- **AWS CLI**
- **Bash Scripting**
- **User Data Scripting**
- **GitHub for Documentation**
- **VS Code** (Local Development)
- **KodeKloud Playground** (AWS Cloud Environment)

---

## 🧱 Project Steps  ###################################################################################################


### 🟩 1. Configure AWS CLI

    a. Log into AWS
    b. Navigate to IAM
    c. Access Management > Users > 'create access key'
    d. Navigate to the VS Code terminal and type: aws configure
    e. Input the access key, secret key and region
        

### 🟩 2. Create an EC2 instance script for the user-data section
        
    a. In the terminal, type: vim <bash_script_name>.sh
    b. Refer to user-data.sh in the project directory for script details
    c. Make the script executable: chmod +x user-data.sh
      

### 🟩 3. Create a security group
        
    a.  #create security group 
        aws ec2 create-security-group --group-name <security_group_name_here> --description "Port 80 and 22 access"  

    b. #inbound access SSH (Port 22)
        aws ec2 authorize-security-group-ingress --group-name <security_group_name_here> --protocol tcp --port 22 --cidr 0.0.0.0/0  
    
    c.  #inbound access HTTP (Port 80)
        aws ec2 authorize-security-group-ingress --group-name <security_group_name_here> --protocol tcp --port 80 --cidr 0.0.0.0/0   
  

  ### 🟩 4. Create a Keypair (Skip Step 4 if KeyPair already obtained)

    a. Create a keypair and save the key to a .pem file

        aws ec2 create-key-pair \
        --key-name <keypair_name_here> \
        --query 'KeyMaterial' \
        --output text > <keypair_name_here>.pem


    b. Secure the .pem file

        chmod 400 <keypair_name_here>.pem


    c. Verify the keypair was created:

        aws ec2 describe-key-pairs --key-name <keypair_name_here>

    d. Delete the keypair (optional):

        aws ec2 delete-key-pair --key-name <keypair_name_here>


### 🟩 5. Fetch Amazon Linux 2023 AMI ID
        
    a. In AWS, search for: EC2 
    b. Click tab Instances > Instances > Launch Instances
    c. Select your preferred image
    d. Copy the 'ami id' to use later in step 6a for the image-id                            


### 🟩 6. Launch EC2 from CLI
        
    a. # Configure an EC2 instance
    
        aws ec2 run-instances \
        --image-id ami-xxxxxxxxxxxx \
        --count 1 \
        --instance-type t2.micro \
        --key-name <keypair_name_here> \
        --security-groups <security_group_name_here> \
        --user-data file://user-data.sh
        --tag-specifications 'ResourceType=instance,Tags=[{Key=Name,Value=instance_name_here}]' # name ec2 instance 

### 🟩 7. Fetch Public IP & visit webpage

    a. # Outputs public IP address of instance

        aws ec2 describe-instances \
        --filters "Name=instance-state-name,Values=running" \
        --query "Reservations[*].Instances[*].PublicIpAddress" \
        --output text

    b. Test ip address for webpage

        http:// <ip_address>


### 🟩 8. Terminate Instance

    a. Delete instance

        aws ec2 terminate-instances --instance-ids <instance_id_here>

      