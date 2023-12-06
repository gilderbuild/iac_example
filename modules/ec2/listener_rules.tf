resource "aws_lb_listener_rule" "path_pattern_host_partner" {
  count = var.env == "prod" ? 1 : 0

  listener_arn = aws_lb_listener.alb_https_listener.arn
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.backend_target_group.arn
  }

  condition {
    path_pattern {
      values = ["/pentest*", "/partner*", "pentest", "partner"]
    }
  }

  condition {
    host_header {
      values = ["partner.be.com"]
    }
  }
}

resource "aws_lb_listener_rule" "host_api" {
  listener_arn = aws_lb_listener.alb_https_listener.arn
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.backend_target_group.arn
  }

  condition {
    host_header {
      values = ["api${var.env_suffix_non_prod}.be.com"]
    }
  }

}


resource "aws_lb_listener_rule" "path_pattern_host_api" {
  listener_arn = aws_lb_listener.alb_https_listener.arn
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.backend_target_group.arn
  }

  condition {
    host_header {
      values = ["api${var.env_suffix_non_prod}.be.com"]
    }
  }

  condition {
    path_pattern {
      values = ["/report/*", "/link/*", "/integration/*", "/integration/*/callback/"]
    }
  }

}


resource "aws_lb_listener_rule" "http_method_host_api" {
  listener_arn = aws_lb_listener.alb_https_listener.arn
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.backend_target_group.arn
  }

  condition {
    host_header {
      values = ["api${var.env_suffix_non_prod}.be.com"]
    }
  }

  condition {
    http_request_method {
      values = ["OPTIONS"]
    }
  }

}

resource "aws_lb_listener_rule" "path_pattern_host_admin" {
  listener_arn = aws_lb_listener.alb_https_listener.arn
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.backend_target_group.arn
  }

  condition {
    host_header {
      values = ["admin-${var.env}.be.com"]
    }
  }

  condition {
    path_pattern {
      values = ["/admin"]
    }
  }

}


resource "aws_lb_listener_rule" "host_bck_1" {
  listener_arn = aws_lb_listener.alb_https_listener.arn
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.backend_target_group.arn
  }

  condition {
    host_header {
      values = ["bck-${var.env_full_name}.be.com"]
    }
  }

}


resource "aws_lb_listener_rule" "host_bck_2" {
  listener_arn = aws_lb_listener.alb_https_listener.arn
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.backend_target_group.arn
  }

  condition {
    host_header {
      values = ["bck-${var.env}.be.com"]
    }
  }
}


resource "aws_lb_listener_rule" "header_host_bck" {
  count = var.env == "prod" ? 1 : 0

  listener_arn = aws_lb_listener.alb_https_listener.arn
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.backend_target_group.arn
  }

  condition {
    host_header {
      values = ["bck-${var.env_full_name}.be.com"]
    }
  }

  condition {
    http_header {
      http_header_name = "X-Impersonate-Username"
      values           = ["*"]
    }
  }
}

resource "aws_lb_listener_rule" "header_host_api" {
  count = var.env == "prod" ? 1 : 0

  listener_arn = aws_lb_listener.alb_https_listener.arn
  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.backend_target_group.arn
  }

  condition {
    host_header {
      values = ["api${var.env_suffix_non_prod}.be.com"]
    }
  }

  condition {
    http_header {
      http_header_name = "Authorization"
      values           = ["*"]
    }
  }

}
