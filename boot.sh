#!/bin/sh

sudo yum install  -y java-1.8.0-openjdk-devel

curl --silent --location http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo | sudo tee /etc/yum.repos.d/jenkins.repo 

sudo rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key

sudo yum install -y jenkins

systemctl enable jenkins

sudo firewall-cmd --permanent --zone=public --add-port=8080/tcp

sudo firewall-cmd --reload

#docker
yum install -y yum-utils \
  device-mapper-persistent-data \
  lvm2

yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo

yum install -y docker-ce


#maven
wget -P /usr/local/src http://www-us.apache.org/dist/maven/maven-3/3.6.0/binaries/apache-maven-3.6.0-bin.tar.gz 
tar -xf /usr/local/src/apache-maven-3.6.0-bin.tar.gz.1
rm -f /usr/local/src/apache-maven-3.6.0-bin.tar.gz
mv /usr/local/src/apache-maven-3.6.0/ apache-maven/
echo "export M2_HOME=/usr/local/src/apache-maven" >> /etc/profile.d/maven.sh
echo "export PATH=\${M2_HOME}/bin:\${PATH}" >> /etc/profile.d/maven.sh

chmod +x /etc/profile.d/maven.sh
source /etc/profile.d/maven.sh

#git
yum install -y git

#npm 
curl -sL https://rpm.nodesource.com/setup_10.x | sudo bash -
sudo yum install -y nodejs

#angular
npm install -g @angular/cli

#start jenkins
sudo systemctl start jenkins