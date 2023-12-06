
resource "aws_security_group" "alb_allow_web_traffic" {
  name        = "${var.env}-${var.app_name}-web-traffic-alb"
  description = "allow http access "
  vpc_id      = var.vpc_id

  ingress {
    description      = "HTTS communication from everywhere"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]

  }

  ingress {
    description      = "HTTP communication from everywhere"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]

  }

  ingress {
    description = "Target group communication"
    from_port   = 8000
    to_port     = 8000
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/8"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.default_tags
}


resource "aws_security_group" "allow_trafic_from_alb" {
  name        = "${var.env}-${var.app_name}-traffic-from-alb"
  description = "Web trafic from  ${aws_security_group.alb_allow_web_traffic.name} "
  vpc_id      = var.vpc_id

  ingress {
    from_port       = 8000
    to_port         = 8000
    protocol        = "tcp"
    security_groups = [aws_security_group.alb_allow_web_traffic.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.default_tags
}

resource "aws_lb" "backend_alb" {
  name                       = "${var.env}-${var.app_name}"
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = [aws_security_group.alb_allow_web_traffic.id]
  subnets                    = var.public_subnets
  idle_timeout               = 900
  enable_deletion_protection = true
  access_logs {
    bucket  = "app-${var.env}-access-logs"
    enabled = true
  }

  tags = var.default_tags

}

resource "aws_lb_listener" "alb_https_listener" {
  load_balancer_arn = aws_lb.backend_alb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = data.aws_acm_certificate.main_certificate.arn

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = ""
      status_code  = "503"
    }
  }

  tags = var.default_tags

}

resource "aws_lb_listener" "front_end_http" {
  load_balancer_arn = aws_lb.backend_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }

  tags = var.default_tags
}


resource "aws_lb_target_group" "backend_target_group" {
  name        = "${var.env}-${var.app_name}"
  target_type = "ip"
  port        = 8000
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  tags        = var.default_tags

  health_check {
    matcher             = "200-302,405"
    path                = "/admin"
    healthy_threshold   = 2
    unhealthy_threshold = 10
    interval            = 300
    timeout             = 120
  }
}



