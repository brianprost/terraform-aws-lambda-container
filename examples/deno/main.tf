module "dino_greeter_lambda" {
  source = "../../"
  depends_on = [module.dino_service_ecr]

  function_name = "dino-greeter"
  image_uri     = "${module.dino_service_ecr.repository_url}:${var.image_tag}"
  
  memory_size = 512
  timeout     = 30

  tags = {
    Function = "dino-greeter"
    Environment = "production"
  }
}

module "dino_service_ecr" {
    source = "terraform-aws-modules/ecr/aws"

    repository_name = "dino-service"

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