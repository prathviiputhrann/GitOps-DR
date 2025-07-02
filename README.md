

📘 GitOps-Based Disaster Recovery Pipeline
Automated disaster recovery using GitOps principles powered by GitHub Actions and AWS. This project launches a replacement EC2 instance and registers it with an Application Load Balancer (ALB) whenever code is pushed to the repository.

🚀 What This Project Does
Launches a new EC2 instance from a pre-configured AMI

Automatically installs and starts Apache (if needed)

Adds the instance to an ALB Target Group

Verifies application recovery via HTTP

Uses GitHub Actions to automate and version the entire process

🧱 Project Structure
markdown
Copy
Edit
aws-disaster-recovery/
├── disaster-recovery/
│   └── recovery-scripts/
│       └── restore.sh
└── .github/
    └── workflows/
        └── recovery-pipeline.yml
⚙️ How It Works
On push to main branch, GitHub Actions triggers the pipeline.

AWS CLI is installed on the GitHub runner.

restore.sh is executed, which:

Launches a new EC2 instance using a prebuilt AMI

Waits for the instance to be ready

Registers the new instance with a pre-configured ALB Target Group

🛠️ Technologies Used
AWS EC2 — virtual server hosting the application

AWS ALB & Target Groups — load balancing traffic to healthy instances

AWS IAM — to manage scoped permissions for automation

GitHub Actions — CI/CD engine triggering recovery via GitOps

Bash scripting — defines the recovery logic

Amazon Linux 2023 — base OS image for AMI


git add .
git commit -m "Trigger disaster recovery"
git push origin main
Watch the GitHub Actions tab to see the full recovery in real time.

⚠️ Issues Faced During Implementation
Issue	Solution
PermissionDenied when launching EC2	Attached AmazonEC2FullAccess to IAM user
RegisterTargets access error	Attached ElasticLoadBalancingFullAccess
Apache not starting in new EC2	Enabled Apache via systemctl enable httpd and/or baked it into AMI
Workflow not running on push	Changed on: workflow_dispatch to on: push
awscli installation failed	Installed using pip instead of apt

✅ Improvements & Next Steps
Add cleanup workflow to terminate old recovery instances

Notify team via Slack or Email after recovery

Integrate with Hund.io or other status pages

Encrypt credentials with OIDC + GitHub Actions instead of secrets

