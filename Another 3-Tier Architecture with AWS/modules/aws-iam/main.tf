# iam Role
resource "aws_iam_role" "ec2_s3_iam_role" {
  name = "iam_role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow"
    }
  ]
}
EOF
}

# iam Policy
resource "aws_iam_policy" "ec2_s3_iam_policy" {
  name = "ec2_s3_iam_policy"
  description = "EC2 S3 Full Access Policy"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
  {
    "Effect": "Allow",
    "Action": "s3:*",
    "Resource": "*"
    }
  ]
}
EOF
}

# iam Instance policy
resource "aws_iam_instance_profile" "ec2_s3_full_access" {
  name = "ec2_s3_full_access"
  role = aws_iam_role.ec2_s3_iam_role.name
}

#================ IAM Policy Attachment ================
resource "aws_iam_role_policy_attachment" "ec2_s3_policy_attach" {
  role = aws_iam_role.ec2_s3_iam_role.name
  policy_arn = aws_iam_policy.ec2_s3_iam_policy.arn
}