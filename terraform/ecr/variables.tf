variable aws_region {
  type        = string
  default     = "eu-west-1"
  description = "The region for the aws provider"
}

variable image {
  type        = string
  default     = "go-lambda-docker"
  description = "The docker image name"
}






