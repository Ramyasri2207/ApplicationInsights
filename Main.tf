resource "aws_iam_role" "ec2_role" {
  name               = "ec2-application-insights-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      }
    }
  ]
}
EOF
}

resource "aws_iam_policy_attachment" "ec2_policy_attachment" {
  name       = "ec2-policy-attachment"
  roles      = [aws_iam_role.ec2_role.name]
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "ec2-instance-profile"
  role = aws_iam_role.ec2_role.name
}


resource "aws_instance" "windows_sql" {
  ami           = "ami-0ebce1b69f52dbdf2" # Replace with the correct AMI ID
  instance_type = "m5.large"              # Use m5.large or other supported types
  key_name      = "keypair"
  iam_instance_profile = aws_iam_instance_profile.ec2_instance_profile.name
  security_groups = [aws_security_group.ec2_sg.name]

  tags = {
    Name = "Windows-SQL-EC2"
  }
}
