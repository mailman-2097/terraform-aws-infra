/*
    CloudWatch Alarms for Windows DC1
*/

#CPU Warning
resource "aws_cloudwatch_metric_alarm" "CPUAlarmWARNINGdc1" {
  alarm_name                = "CPUAlarmWARNING-${aws_instance.dc1.id}"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "1"
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  period                    = "900"
  statistic                 = "Average"
  threshold                 = "90"
  alarm_description         = "${aws_instance.dc1.id} - High CPU Usage 90%"
  alarm_actions             = ["${aws_sns_topic.warning-alarms.arn}"]
  ok_actions                = ["${aws_sns_topic.warning-alarms.arn}"]
  dimensions                = {
    InstanceId = "${aws_instance.dc1.id}"
  }
}

#CPU Critical
resource "aws_cloudwatch_metric_alarm" "CPUAlarmCRITICALdc1" {
  alarm_name                = "CPUAlarmCRITICAL-${aws_instance.dc1.id}"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "2"
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  period                    = "900"
  statistic                 = "Average"
  threshold                 = "95"
  alarm_description         = "${aws_instance.dc1.id} - High CPU Usage 90%"
  alarm_actions             = ["${aws_sns_topic.critical-alarms.arn}"]
  ok_actions                = ["${aws_sns_topic.critical-alarms.arn}"]
  dimensions                = {
    InstanceId = "${aws_instance.dc1.id}"
  }
}

#Memory Warning
resource "aws_cloudwatch_metric_alarm" "MemoryAlarmWARNINGdc1" {
  alarm_name                = "MemoryAlarmWARNING-${aws_instance.dc1.id}"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "1"
  metric_name               = "Memory % Committed Bytes In Use"
  namespace                 = "CWAgent"
  period                    = "900"
  statistic                 = "Average"
  threshold                 = "90"
  alarm_description         = "${aws_instance.dc1.id} - High Memory Usage 90%"
  alarm_actions             = ["${aws_sns_topic.warning-alarms.arn}"]
  ok_actions                = ["${aws_sns_topic.warning-alarms.arn}"]
  dimensions                = {
    InstanceId = "${aws_instance.dc1.id}"
    objectname = "Memory"
  }
}

#Memory Critical
resource "aws_cloudwatch_metric_alarm" "MemoryAlarmCRITICALdc1" {
  alarm_name                = "MemoryAlarmCRITICAL-${aws_instance.dc1.id}"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "2"
  metric_name               = "Memory % Committed Bytes In Use"
  namespace                 = "CWAgent"
  period                    = "900"
  statistic                 = "Average"
  threshold                 = "95"
  alarm_description         = "${aws_instance.dc1.id} - High Memory Usage 90%"
  alarm_actions             = ["${aws_sns_topic.critical-alarms.arn}"]
  ok_actions                = ["${aws_sns_topic.critical-alarms.arn}"]
  dimensions                = {
    InstanceId = "${aws_instance.dc1.id}"
    objectname = "Memory"
  }
}

#Disk Space Warning
resource "aws_cloudwatch_metric_alarm" "DiskSpaceWARNINGdc1" {
  alarm_name                = "DiskSpaceWARNING-${aws_instance.dc1.id}"
  comparison_operator       = "LessThanOrEqualToThreshold"
  evaluation_periods        = "1"
  metric_name               = "LogicalDisk % Free Space"
  namespace                 = "CWAgent"
  period                    = "300"
  statistic                 = "Average"
  threshold                 = "10"
  alarm_description         = "${aws_instance.dc1.id} - over 90% of C Drive space is in use"
  alarm_actions             = ["${aws_sns_topic.warning-alarms.arn}"]
  ok_actions                = ["${aws_sns_topic.warning-alarms.arn}"]
  dimensions                = {
    InstanceId = "${aws_instance.dc1.id}"
    instance = "C:"
    objectname = "LogicalDisk"
  }
}

#Disk Space Critical
resource "aws_cloudwatch_metric_alarm" "DiskSpaceCRITICALdc1" {
  alarm_name                = "DiskSpaceCRITICAL-${aws_instance.dc1.id}"
  comparison_operator       = "LessThanOrEqualToThreshold"
  evaluation_periods        = "1"
  metric_name               = "LogicalDisk % Free Space"
  namespace                 = "CWAgent"
  period                    = "300"
  statistic                 = "Average"
  threshold                 = "10"
  alarm_description         = "${aws_instance.dc1.id} - over 95% of C Drive space is in use"
  alarm_actions             = ["${aws_sns_topic.critical-alarms.arn}"]
  ok_actions                = ["${aws_sns_topic.critical-alarms.arn}"]
  dimensions                = {
    InstanceId = "${aws_instance.dc1.id}"
    instance = "C:"
    objectname = "LogicalDisk"
  }
}

#System Status Critical
resource "aws_cloudwatch_metric_alarm" "SystemStatusFailedAlarmCRITICALdc1" {
  alarm_name                = "SystemStatusFailedAlarmCRITICAL-${aws_instance.dc1.id}"
  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = "2"
  metric_name               = "StatusCheckFailed_System"
  namespace                 = "AWS/EC2"
  period                    = "60"
  statistic                 = "Minimum"
  threshold                 = "0"
  alarm_description         = "${aws_instance.dc1.id} - System Status Check Failed - please investigate."
  alarm_actions             = ["${aws_sns_topic.critical-alarms.arn}"]
  ok_actions                = ["${aws_sns_topic.critical-alarms.arn}"]
  dimensions                = {
    InstanceId = "${aws_instance.dc1.id}"
  }
}

#Instance Status Critical
resource "aws_cloudwatch_metric_alarm" "InstanceStatusFailedAlarmCRITICALdc1" {
  alarm_name                = "InstanceStatusFailedAlarmCRITICAL-${aws_instance.dc1.id}"
  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = "3"
  metric_name               = "StatusCheckFailed_System"
  namespace                 = "AWS/EC2"
  period                    = "60"
  statistic                 = "Minimum"
  threshold                 = "0"
  alarm_description         = "${aws_instance.dc1.id} - Instance Status Check Failed - please investigate. Troubleshooting: https://goo.gl/Ea27Gd"
  alarm_actions             = ["${aws_sns_topic.critical-alarms.arn}"]
  ok_actions                = ["${aws_sns_topic.critical-alarms.arn}"]
  dimensions                = {
    InstanceId = "${aws_instance.dc1.id}"
  }
}

/*
    CloudWatch Alarms for Windows DC2
*/

#CPU Warning
resource "aws_cloudwatch_metric_alarm" "CPUAlarmWARNINGdc2" {
  alarm_name                = "CPUAlarmWARNING-${aws_instance.dc2.id}"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "1"
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  period                    = "900"
  statistic                 = "Average"
  threshold                 = "90"
  alarm_description         = "${aws_instance.dc2.id} - High CPU Usage 90%"
  alarm_actions             = ["${aws_sns_topic.warning-alarms.arn}"]
  ok_actions                = ["${aws_sns_topic.warning-alarms.arn}"]
  dimensions                = {
    InstanceId = "${aws_instance.dc2.id}"
  }
}

#CPU Critical
resource "aws_cloudwatch_metric_alarm" "CPUAlarmCRITICALdc2" {
  alarm_name                = "CPUAlarmCRITICAL-${aws_instance.dc2.id}"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "2"
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  period                    = "900"
  statistic                 = "Average"
  threshold                 = "95"
  alarm_description         = "${aws_instance.dc2.id} - High CPU Usage 90%"
  alarm_actions             = ["${aws_sns_topic.critical-alarms.arn}"]
  ok_actions                = ["${aws_sns_topic.critical-alarms.arn}"]
  dimensions                = {
    InstanceId = "${aws_instance.dc2.id}"
  }
}

#Memory Warning
resource "aws_cloudwatch_metric_alarm" "MemoryAlarmWARNINGdc2" {
  alarm_name                = "MemoryAlarmWARNING-${aws_instance.dc2.id}"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "1"
  metric_name               = "Memory % Committed Bytes In Use"
  namespace                 = "CWAgent"
  period                    = "900"
  statistic                 = "Average"
  threshold                 = "90"
  alarm_description         = "${aws_instance.dc2.id} - High Memory Usage 90%"
  alarm_actions             = ["${aws_sns_topic.warning-alarms.arn}"]
  ok_actions                = ["${aws_sns_topic.warning-alarms.arn}"]
  dimensions                = {
    InstanceId = "${aws_instance.dc2.id}"
    objectname = "Memory"
  }
}

#Memory Critical
resource "aws_cloudwatch_metric_alarm" "MemoryAlarmCRITICALdc2" {
  alarm_name                = "MemoryAlarmCRITICAL-${aws_instance.dc2.id}"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "2"
  metric_name               = "Memory % Committed Bytes In Use"
  namespace                 = "CWAgent"
  period                    = "900"
  statistic                 = "Average"
  threshold                 = "95"
  alarm_description         = "${aws_instance.dc2.id} - High Memory Usage 90%"
  alarm_actions             = ["${aws_sns_topic.critical-alarms.arn}"]
  ok_actions                = ["${aws_sns_topic.critical-alarms.arn}"]
  dimensions                = {
    InstanceId = "${aws_instance.dc2.id}"
    objectname = "Memory"
  }
}

#Disk Space Warning
resource "aws_cloudwatch_metric_alarm" "DiskSpaceWARNINGdc2" {
  alarm_name                = "DiskSpaceWARNING-${aws_instance.dc2.id}"
  comparison_operator       = "LessThanOrEqualToThreshold"
  evaluation_periods        = "1"
  metric_name               = "LogicalDisk % Free Space"
  namespace                 = "CWAgent"
  period                    = "300"
  statistic                 = "Average"
  threshold                 = "10"
  alarm_description         = "${aws_instance.dc2.id} - over 90% of C Drive space is in use"
  alarm_actions             = ["${aws_sns_topic.warning-alarms.arn}"]
  ok_actions                = ["${aws_sns_topic.warning-alarms.arn}"]
  dimensions                = {
    InstanceId = "${aws_instance.dc2.id}"
    instance = "C:"
    objectname = "LogicalDisk"
  }
}

#Disk Space Critical
resource "aws_cloudwatch_metric_alarm" "DiskSpaceCRITICALdc2" {
  alarm_name                = "DiskSpaceCRITICAL-${aws_instance.dc2.id}"
  comparison_operator       = "LessThanOrEqualToThreshold"
  evaluation_periods        = "1"
  metric_name               = "LogicalDisk % Free Space"
  namespace                 = "CWAgent"
  period                    = "300"
  statistic                 = "Average"
  threshold                 = "10"
  alarm_description         = "${aws_instance.dc2.id} - over 95% of C Drive space is in use"
  alarm_actions             = ["${aws_sns_topic.critical-alarms.arn}"]
  ok_actions                = ["${aws_sns_topic.critical-alarms.arn}"]
  dimensions                = {
    InstanceId = "${aws_instance.dc2.id}"
    instance = "C:"
    objectname = "LogicalDisk"
  }
}

#System Status Critical
resource "aws_cloudwatch_metric_alarm" "SystemStatusFailedAlarmCRITICALdc2" {
  alarm_name                = "SystemStatusFailedAlarmCRITICAL-${aws_instance.dc2.id}"
  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = "2"
  metric_name               = "StatusCheckFailed_System"
  namespace                 = "AWS/EC2"
  period                    = "60"
  statistic                 = "Minimum"
  threshold                 = "0"
  alarm_description         = "${aws_instance.dc2.id} - System Status Check Failed - please investigate."
  alarm_actions             = ["${aws_sns_topic.critical-alarms.arn}"]
  ok_actions                = ["${aws_sns_topic.critical-alarms.arn}"]
  dimensions                = {
    InstanceId = "${aws_instance.dc2.id}"
  }
}

#Instance Status Critical
resource "aws_cloudwatch_metric_alarm" "InstanceStatusFailedAlarmCRITICALdc2" {
  alarm_name                = "InstanceStatusFailedAlarmCRITICAL-${aws_instance.dc2.id}"
  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = "3"
  metric_name               = "StatusCheckFailed_System"
  namespace                 = "AWS/EC2"
  period                    = "60"
  statistic                 = "Minimum"
  threshold                 = "0"
  alarm_description         = "${aws_instance.dc2.id} - Instance Status Check Failed - please investigate. Troubleshooting: https://goo.gl/Ea27Gd"
  alarm_actions             = ["${aws_sns_topic.critical-alarms.arn}"]
  ok_actions                = ["${aws_sns_topic.critical-alarms.arn}"]
  dimensions                = {
    InstanceId = "${aws_instance.dc2.id}"
  }
}