output "out_iam_instance_profile_name" {
  value = "${aws_iam_instance_profile.ec2_s3_full_access.name}"
}