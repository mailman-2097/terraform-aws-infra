
resource "aws_sns_topic" "critical-alarms" {
  name = "critical-alarms"
}

resource "aws_sns_topic" "warning-alarms" {
  name = "warning-alarms"
}