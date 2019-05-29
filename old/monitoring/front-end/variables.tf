variable "datadog_api_key" {}
variable "datadog_app_key" {}

variable "front-end_trigger_by" {
  default = "{host,env}"
}

variable "front-end_disk_usage" {
  type = "map"

  default = {
    query     = "max:system.disk.in_use"
    threshold = "85"
  }
}

variable "front-end_cpu_usage" {
  type = "map"

  default = {
    query     = "avg:aws.ec2.cpuutilization"
    threshold = "85"
  }
}

variable "datadog_alert_footer" {
  default = <<EOF
{{#is_no_data}}Not receiving data{{/is_no_data}}
{{#is_alert}}@pagerduty{{/is_alert}}
{{#is_recovery}}@pagerduty-resolve{{/is_recovery}}
@slack-alerts
EOF
}