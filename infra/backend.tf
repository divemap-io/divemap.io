terraform {
  backend "s3" {
    bucket = "terraform-divemapio-remote-backend"
    key    = "state.tfstate"
    region = "eu-north-1"
  }
}