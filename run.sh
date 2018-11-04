echo "================================================="
echo ""
echo "Ansible INSTALLING!"
echo ""
echo "================================================="



# Install package to allow for repositories
sudo apt install software-properties-common

# Add ppa:ansible/ansible to system’s Software Source
sudo apt-add-repository ppa:ansible/ansible -y

# Update All Applications
sudo apt update -y 
# Install Ansible
sudo apt install ansible -y

# Install pip
sudo apt install python-pip -y
# Pip install botocore boto boto3
pip install botocore boto boto3

# Configuring BOTO
# Configure AWS credentials/API keys
mkdir -pv ~/.aws/

# Input and processing for Access Key
echo "======== Please enter your access key ========"
read accessKey
echo "
[default]
aws_access_key_id = $accessKey"> ~/.aws/credentials

# Input and processing for Secret Access Key
echo "====== Please enter your secret access key ======="
read secretAccessKey
echo "Your input is $secretAccessKey"
echo "
aws_secret_access_key = $secretAccessKey">> ~/.aws/credentials
echo "====== Successfully loaded keys ======"
sudo chmod 666 ~/.aws/credentials

# Configure AWS's Default Server Cluster Region
echo "
[default]
region = us-west-2"> ~/.aws/config

sudo chmod 666 ~/.aws/config

# Change some settings for the ansible.cfg
echo "
[defaults]
host_key_checking = False
"> ~/ansible.cfg

# Install awscli - AWS Command Line
sudo apt install awscli -y

# Creating a New Keypair Automatically
ssh-keygen -t rsa -N "" -f ~/.ssh/id_rsa
aws ec2 import-key-pair --public-key-material "$(cat ~/.ssh/id_rsa.pub | tr -d '\n')"  --key-name main-instance

echo "====================================================================================="
echo ""
echo "Ansible Installed and a new key pair generated! The Playbook will now download and run automatically!"
echo ""
echo "======================================================================================"
