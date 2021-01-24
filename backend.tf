terraform {
  backend "s3" {
    bucket = "sanji"
    key    = "app-state"
    region = "us-east-1"
  }
}

