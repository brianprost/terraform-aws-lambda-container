module "bun_greeter_lambda" {
  source = "../../"
  depends_on = [module.bun_service_ecr]

  function_name = "bun-greeter"
  image_uri     = "${module.bun_service_ecr.repository_url}:${var.image_tag}"
  
  memory_size = 512
  timeout     = 30

  tags = {
    Function = "bun-greeter"
    Environment = "production"
  }
}

module "bun_service_ecr" {
    source = "terraform-aws-modules/ecr/aws"

    repository_name = "bun-service"

    repository_lifecycle_policy = jsonencode({
        rules = [
            {
                rulePriority = 1,
                description  = "Keep last 30 images",
                selection = {
                    tagStatus     = "tagged",
                    tagPrefixList = ["v"],
                    countType     = "imageCountMoreThan",
                    countNumber   = 30
                },
                action = {
                    type = "expire"
                }
            }
        ]
    })

    
    tags = {
        Environment = "production"
    }
}