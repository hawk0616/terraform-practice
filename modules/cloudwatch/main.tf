resource "aws_cloudwatch_log_group" "ecs_logs" {
  name = "ecs-logs"
}

resource "aws_cloudwatch_metric_alarm" "high_cpu" {
  alarm_name          = "High CPU Usage"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "300"
  statistic           = "Average"
  threshold           = "80"
  alarm_description   = "This metric checks for high CPU usage"
  alarm_actions       = [aws_sns_topic.cpu_alerts.arn]
}

resource "aws_sns_topic" "cpu_alerts" {
  name = "cpu-alerts"
}