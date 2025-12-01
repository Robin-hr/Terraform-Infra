resource "aws_lb_target_group" "my-tg" {
  name     = "my-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.my-first-vpc.id
  target_type = "instance"

  health_check {
    path                = "/"

  }

    tags = {
    Name = "my-tg"
  }
}



resource "aws_lb_target_group_attachment" "tg_attach_private1" {
  target_group_arn = aws_lb_target_group.my-tg.arn
  target_id        = aws_instance.private_ec2_1.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "tg_attach_private2" {
  target_group_arn = aws_lb_target_group.my-tg.arn
  target_id        = aws_instance.private_ec2_2.id
  port             = 80
}
