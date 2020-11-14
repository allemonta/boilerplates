# SERN full stack application

## Requirements

- node.js & npm 
    - Windows: download installer from [this link](https://nodejs.org/it/download/)
    - MacOS: download installer from [this link](https://nodejs.org/it/download/)
    - Linux: launch command `curl -sL https://rpm.nodesource.com/setup_14.x | sudo -E bash -`
- Terraform
    - Windows: download windows binary from [this link](https://www.terraform.io/downloads.html) and move it in a location like `%USERPROFILE%/.terraform`. Add the location path in the Environment Variables (if you don't know how, follow the instructions in [this link](https://docs.alfresco.com/4.2/tasks/fot-addpath.html))
    - MacOS: download windows binary from [this link](https://www.terraform.io/downloads.html)
    - Linux: download windows binary from [this link](https://www.terraform.io/downloads.html)
- Docker
    - Windows: download installer from [this link](https://hub.docker.com/editions/community/docker-ce-desktop-windows/)
    - MacOS : download installer from [this link](https://hub.docker.com/editions/community/docker-ce-desktop-mac/)
    - EC2 AWS AMI: `sudo amazon-linux-extras install docker && sudo service docker start && sudo usermod -aG docker ec2-user`
    - Linux: `curl -fsSL https://get.docker.com | sudo sh && sudo service docker start && sudo usermod -aG docker your-user` (replace "your-user" with account username!)
- Docker-Compose
    - Windows: already installed with docker
    - MacOS: already installed with docker
    - Linux: launch commands `sudo curl -L https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose && sudo chmod +x /usr/local/bin/docker-compose`

## Setup
Run the following commands:
1. `cp sample.env .env`
2. `npm install`

## Start
Run the following command: `npm start`

Frontend: `http://127.0.0.1`
Backend: `http://127.0.0.1:3000`
PHPMyAdmin: `http://127.0.0.1:32000`