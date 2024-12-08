terraform {
  backend "s3" {
    bucket = "terraform-divemapio-remote-backend"
    key    = "landing-page/state.tfstate"
    region = "eu-north-1"
  }
}