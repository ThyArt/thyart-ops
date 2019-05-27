resource "datadog_monitor" "back-end_disk_usage" {
  name           = "Disk usage high"
  query          = "avg(last_5m):${var.back-end_disk_usage["query"]}{*} by ${var.back-end_trigger_by} * 100 > ${var.back-end_disk_usage["threshold"]}"
  type           = "metric alert"
  notify_no_data = true
  include_tags   = true

  message = <<EOM
Disk usage high: {{value}}
${var.datadog_alert_footer}
EOM
}

resource "datadog_monitor" "back-end_cpu_usage" {
  name           = "CPU usage high"
  query          = "avg(last_5m):${var.back-end_cpu_usage["query"]}{*} by ${var.back-end_trigger_by} > ${var.back-end_cpu_usage["threshold"]}"
  type           = "query alert"
  notify_no_data = true
  include_tags   = true

  message = <<EOM
CPU usage high: {{value}}
${var.datadog_alert_footer}
EOM
}

resource "datadog_timeboard" "back-end_host_metrics" {
  title       = "Host metrics"
  description = "Host level metrics: CPU, memory, disk, etc."
  read_only   = true

  graph {
    title     = "CPU usage"
    viz       = "timeseries"
    autoscale = true

    request {
      q          = "${var.back-end_cpu_usage["query"]}{*} by ${var.back-end_trigger_by}"
      aggregator = "avg"
      type       = "line"
    }

    marker {
      value = "y > ${var.back-end_cpu_usage["threshold"]}"
      type  = "error dashed"
    }
  }

  graph {
    title     = "Disk usage"
    viz       = "timeseries"
    autoscale = true

    request {
      q          = "${var.back-end_disk_usage["query"]}{*} by ${var.back-end_trigger_by}"
      aggregator = "avg"
      type       = "line"
    }

    marker {
      value = "y > ${var.back-end_disk_usage["threshold"]}"
      type  = "error dashed"
    }
  }
}