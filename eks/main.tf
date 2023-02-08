resource "tls_private_key" "bipin_private_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "bipin_pair" {
  key_name   = "bipin_key" # Create a "myKey" to AWS!!
  public_key = tls_private_key.bipin_private_key.public_key_openssh
}

resource "local_file" "ssh_key" {
  filename = "${aws_key_pair.bipin_pair.key_name}.pem"
  content  = tls_private_key.bipin_private_key.private_key_pem
}

module "test" {
  source = "./modules/stages/test"
  providers = {
    aws.nvirginia   = aws.nvirginia
    aws.california  = aws.california
  }
  private_key_pem = aws_key_pair.bipin_pair.key_name
   key_name = aws_key_pair.bipin_pair.key_name
}
