#!/bin/bash
set -e

echo "🚨 Starting Disaster Recovery"

AMI_ID="ami-0e7a08c2102b25caf"  # Replace
INSTANCE_TYPE="t2.micro"
KEY_NAME="GitOps-Practice"
SECURITY_GROUP_ID="sg-023554b5a9434b817"  # Replace
SUBNET_ID="subnet-04ccefd3db78c8c5b"     # Replace
TARGET_GROUP_ARN="arn:aws:elasticloadbalancing:us-west-2:923344751778:targetgroup/Instance-target-group/b5fa52c003d66049"  # Replace
REGION="us-west-2"

echo "🟡 Launching new EC2 instance..."
INSTANCE_ID=$(aws ec2 run-instances \
  --image-id $AMI_ID \
  --instance-type $INSTANCE_TYPE \
  --key-name $KEY_NAME \
  --security-group-ids $SECURITY_GROUP_ID \
  --subnet-id $SUBNET_ID \
  --region $REGION \
  --count 1 \
  --query 'Instances[0].InstanceId' \
  --output text)

echo "✅ Instance launched: $INSTANCE_ID"

aws ec2 wait instance-running --instance-ids $INSTANCE_ID --region $REGION

echo "🟢 Registering instance to ALB target group..."
aws elbv2 register-targets --target-group-arn $TARGET_GROUP_ARN \
  --targets Id=$INSTANCE_ID --region $REGION

echo "✅ Recovery complete. Instance registered."
