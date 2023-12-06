terraform {
  backend "s3" {
    bucket = ""
    key    = "infra/zero-downtime"
    region = "us-east-1"
  }
}
