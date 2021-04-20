terraform {
  backend "s3" {
    bucket = "terraform.dreddick.home2"
    key    = "go-lambda-docker/ecr/terraform.tfstate"
    region = "eu-west-1"
  }
}
