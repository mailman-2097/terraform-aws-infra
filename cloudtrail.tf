resource "aws_cloudtrail" "sms_cloudtrail" {
  name                          = "sms-cloudtrail"
  s3_bucket_name                = "${aws_s3_bucket.cloudtrail.id}"
  s3_key_prefix                 = "prefix"
  include_global_service_events = true
  depends_on = ["aws_s3_bucket.cloudtrail"]
}