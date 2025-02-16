# Terraform AWS Lambda Container Module

This Terraform module creates an AWS Lambda function configured to run a container image.

## Features

- Container-based Lambda function deployment
- Configurable memory and timeout settings
- Optional VPC support
- X-Ray tracing support
- CloudWatch Logs configuration
- Automatic error alerting via CloudWatch Alarms
- Customizable environment variables
- Automatic IAM role and policy management

## Usage

```hcl
module "deno_lambda" {
  source = "wherever/this/module/is"

  function_name = "fossil-examiner"
  image_uri     = "123456789012.dkr.ecr.us-east-1.amazonaws.com/fossil-examiner:latest"
  
  memory_size = 256
  timeout     = 60
  
  environment_variables = {
    ENVIRONMENT = "production"
    DEBUG       = "false"
  }
  
  # Optional VPC configuration
  vpc_config = {
    subnet_ids         = ["subnet-1234567890"]
    security_group_ids = ["sg-1234567890"]
  }
  
  tags = {
    Environment = "production"
    Project     = "fossil-examiner"
  }
}
```

## Requirements

| Name | Version |
|------|---------|
| [OpenTofu](https://opentofu.org/) / [Terraform](https://www.terraform.io/) | >= 1.9.0 |
| aws | >= 5.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| function_name | Name of the Lambda function | `string` | n/a | yes |
| image_uri | Full URI of the container image | `string` | n/a | yes |
| memory_size | Amount of memory in MB for the function | `number` | `128` | no |
| timeout | Timeout in seconds | `number` | `30` | no |
| environment_variables | Environment variables for the Lambda function | `map(string)` | `{}` | no |
| vpc_config | VPC configuration for Lambda function | `object` | `null` | no |
| enable_xray | Enable X-Ray tracing | `bool` | `true` | no |
| retention_days | CloudWatch Logs retention in days | `number` | `90` | no |
| tags | Tags to apply to all resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| function_arn | ARN of the Lambda function |
| function_name | Name of the Lambda function |
| cloudwatch_log_group_name | Name of the CloudWatch Logs log group |
| lambda_role_arn | ARN of the Lambda IAM role |

## License

MIT Licensed. See LICENSE for full details.
