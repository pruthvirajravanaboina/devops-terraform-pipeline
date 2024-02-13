#!/bin/bash
#apt update && apt install -y unzip
for I in {1..10}; do
    echo $I
done

TFORM_VERSION='1.4.6'
PACKER_VERSION='1.8.1'
rm -rf *.zip && rm -rf /usr/local/bin/terraform && rm -rf /usr/local/bin/packer
mkdir /tmp/testfolder1
apt install -y unzip
wget https://releases.hashicorp.com/terraform/${TFORM_VERSION}/terraform_${TFORM_VERSION}_linux_amd64.zip
unzip terraform_${TFORM_VERSION}_linux_amd64.zip && chmod 777 terraform
mv terraform /usr/local/bin
terraform version
wget https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip
unzip packer_${PACKER_VERSION}_linux_amd64.zip && chmod 777 packer
mv packer /usr/local/bin
packer version
