#!/bin/bash

# Set variables
AMI_ID="ami-0abcdef1234567890"       # Replace with your AMI ID
INSTANCE_TYPE="t2.micro"
KEY_NAME="your-key-pair-name"        # Replace with your key pair
SECURITY_GROUP="sg-0123456789abcdef" # Replace with your security group ID
TAG_NAME="MyAutomatedInstance"

# Launch EC2 instance
echo "Launching EC2 instance..."
INSTANCE_ID=$(aws ec2 run-instances \
  --image-id $AMI_ID \
  --instance-type $INSTANCE_TYPE \
  --key-name $KEY_NAME \
  --security-group-ids $SECURITY_GROUP \
  --query 'Instances[0].InstanceId' \
  --output text)

echo "Instance launched with ID: $INSTANCE_ID"

# Add a tag to the instance
echo "Tagging the instance..."
aws ec2 create-tags \
  --resources $INSTANCE_ID \
  --tags Key=Name,Value=$TAG_NAME

echo "Instance tagged as $TAG_NAME"