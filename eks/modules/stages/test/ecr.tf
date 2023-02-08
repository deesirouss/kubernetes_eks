resource "aws_ecr_repository" "repository" {
  provider = aws.nvirginia
  name     = "vyaguta"
  image_scanning_configuration {
    scan_on_push = true
  }
  tags = local.tags
}
