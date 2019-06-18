#S3 Bucket to hold monitoring scripts and config files
resource "aws_s3_bucket" "awsmonitoring" {
  bucket = "${var.s3_monitoring_bucket}"
  acl    = "public-read"
}

#Upload CWAgent config files to S3
resource "aws_s3_bucket_object" "cloudwatchagent_windows_config" {
  bucket = "${var.s3_monitoring_bucket}"
  key    = "config/cloudwatchagent-windows-config.json"
  source = "cwagent/config/cloudwatchagent-windows-config.json"
  etag   = "${filemd5("cwagent/config/cloudwatchagent-linux-config.json")}"
  acl    = "public-read"
  depends_on = ["aws_s3_bucket.awsmonitoring"]
}
resource "aws_s3_bucket_object" "cloudwatchagent_linux_config" {
  bucket = "${var.s3_monitoring_bucket}"
  key    = "config/cloudwatchagent-linux-config.json"
  source = "cwagent/config/cloudwatchagent-linux-config.json"
  etag   = "${filemd5("cwagent/config/cloudwatchagent-linux-config.json")}"
  acl    = "public-read"
  depends_on = ["aws_s3_bucket.awsmonitoring"]
}

#S3 Bucket for CloudTrail
resource "aws_s3_bucket" "cloudtrail" {
  bucket        = "${var.s3_cloudtrail_bucket}"
  force_destroy = true

  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "AWSCloudTrailAclCheck",
            "Effect": "Allow",
            "Principal": {
              "Service": "cloudtrail.amazonaws.com"
            },
            "Action": "s3:GetBucketAcl",
            "Resource": "arn:aws:s3:::${var.s3_cloudtrail_bucket}"
        },
        {
            "Sid": "AWSCloudTrailWrite",
            "Effect": "Allow",
            "Principal": {
              "Service": "cloudtrail.amazonaws.com"
            },
            "Action": "s3:PutObject",
            "Resource": "arn:aws:s3:::${var.s3_cloudtrail_bucket}/*",
            "Condition": {
                "StringEquals": {
                    "s3:x-amz-acl": "bucket-owner-full-control"
                }
            }
        }
    ]
}
POLICY
}