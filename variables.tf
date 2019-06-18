variable "aws_access_key" {
    default = ""
}

variable "aws_secret_key" {
    default = ""
}

variable "aws_region" {
    description = "EC2 Region for the VPC"
    default = "ap-southeast-2"
}

variable "vpc_cidr" {
    description = "SMS-PROD-VPC"
    default = "10.0.0.0/16"
}

variable "aws_subnet_cidrs_public" {
    type = "list"

    default = ["10.0.128.0/20", "10.0.144.0/20", "10.0.160.0/20"]
}

variable "aws_subnet_cidrs_private" {
    type = "list"

    default = ["10.0.0.0/19", "10.0.32.0/19", "10.0.64.0/19"]
}

variable "aws_availability_zones" {
    default = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

#Alerting/Monitoring
variable "s3_monitoring_bucket" {
    default = "sms.awsmonitoring.052019"
}

#CloudTrail
variable "s3_cloudtrail_bucket" {
    default = "sms.cloudtrail.052019"
}

variable "private_subnets_cidr" {
    default = ["10.0.0.0/17"]
}

#EC2 DomainController Properties
variable "dc_instance_type" {
    default = "t2.micro"
}

variable "dc_instance_key" {
    default = ""
}

variable "dc_instance_iam" {
    default = "CloudWatchAgentRole"
}

variable "dc_instance_creatortag" {
    default = "Name Surename"
}