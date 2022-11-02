# create a local file to save outputs and diff updated files
locals {
  lambda_zip_location = "outputs/hello-python.zip"
}

data "archive_file" "zip_the_python_code" {
  type = "zip"
  source_file = "./Handlers/index.py"
  output_path = "${local.lambda_zip_location}"
}

resource "aws_lambda_function" "terraform_lambda_func" {
  filename = "${local.lambda_zip_location}"
  function_name = "Update_Profile_Lambda_Funtion"
  role = "${aws_iam_role.lambda_role.arn}"
  handler = "index.lambda_handler"
  source_code_hash = "${filebase64sha256(local.lambda_zip_location)}"
  runtime = "python3.8"
  
}