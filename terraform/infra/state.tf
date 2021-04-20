terraform {
  backend "s3" {
    bucket = "terraform.dreddick.home2"
    key    = "go-lambda-docker/infra/terraform.tfstate"
    region = "eu-west-1"
  }
}




