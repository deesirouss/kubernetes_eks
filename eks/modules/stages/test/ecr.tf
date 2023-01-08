resource "aws_ecr_repository" "repository" {
  provider = aws.nvirginia
  name     = "vyaguta/test"
  image_scanning_configuration {
    scan_on_push = true
  }
  tags = local.tags
}

resource "aws_ecr_repository" "test1" {
  provider = aws.nvirginia
  name     = "vyaguta/test1"
  image_scanning_configuration {
    scan_on_push = true
  }
  tags = local.tags
}
