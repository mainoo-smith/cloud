# create iam role policy and iam role
resource "aws_iam_role_policy" "iam_policy_for_lambda" {
  name = "iam_policy_for_lambda"
  role = "${aws_iam_role.lambda_role.id}"
  policy = "${file("iam/lambda-policy.json")}"
}

resource "aws_iam_role" "lambda_role" {
  name = "lambda_role"
  assume_role_policy = jsonencode({
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}) 
}