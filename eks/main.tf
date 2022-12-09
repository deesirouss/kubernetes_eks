module "test" {
  source = "./modules/stages/test"
  providers = {
    aws.nvirginia = aws.nvirginia
    aws.california = aws.california
  }
}