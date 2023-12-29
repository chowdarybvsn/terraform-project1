module "VPC_project2024" {
  source              = "./modules/VPC_project2024"
  project2024_vpc     = "30.0.0.0/16"
  project2024_pubsub  = "30.0.1.0/24"
  project2024_privsub = "30.0.2.0/24"
}

module "S3_project2024" {
  source         = "./modules/S3_project2024"
  s3_bucket_name = "project2024-s3bucketz"
}

resource "aws_iam_role" "jenkins_role" {
  name = "jenkins_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_policy" "jenkins_s3_policy" {
  name        = "jenkins_s3_policy"
  description = "Policy for Jenkins to access S3 bucket"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:GetObject",
        "s3:ListBucket"
      ],
      "Resource": [
        "arn:aws:s3:::${module.S3_project2024.bucket_project}",
        "arn:aws:s3:::${module.S3_project2024.bucket_project}/*"
      ]
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "jenkins_s3_access" {
  policy_arn = aws_iam_policy.jenkins_s3_policy.arn
  role       = aws_iam_role.jenkins_role.name
}

resource "aws_iam_instance_profile" "jenkins_instance_profile" {
  name = "jenkins_instance_profile"
  role = aws_iam_role.jenkins_role.name
}

resource "aws_instance" "jenkins" {
  ami                    = var.ami_image[0]
  instance_type          = var.inst_type[0]
  vpc_security_group_ids = [module.VPC_project2024.op-sg]
  key_name               = "alticheck"
  subnet_id              = module.VPC_project2024.op-subnet # this comes from o/p block in module
  tags = {
    Name = "jenkins"
  }

  iam_instance_profile = aws_iam_instance_profile.jenkins_instance_profile.name
}
