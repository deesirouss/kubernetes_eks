resource "aws_ecr_repository" "repository" {
  provider = aws.nvirginia
  name     = "vyaguta/test"
  image_scanning_configuration {
    scan_on_push = true
  }
  tags = local.tags
}

resource "aws_ecr_repository" "test2" {
  provider = aws.nvirginia
  name     = "vyaguta/test2"
  image_scanning_configuration {
    scan_on_push = true
  }
  tags = local.tags
}
