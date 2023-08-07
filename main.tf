provider "aws" {
  region = "ap-northeast-1"
}

module "vpc" {
  source = "./modules/vpc"
}

module "ecs" {
  source = "./modules/ecs"
}

module "rds" {
  source = "./modules/rds"
}

module "alb" {
  source = "./modules/alb"
}

module "route53" {
  source = "./modules/route53"
  domain_name = "example.com"
}

module "security_groups" {
  source = "./modules/security_groups"
}

module "iam" {
  source = "./modules/iam"
}

module "cloudwatch" {
  source = "./modules/cloudwatch"
}