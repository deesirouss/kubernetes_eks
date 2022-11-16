terraform {
  cloud {
    organization = "lf-tf-demo"

    workspaces {
      name = "kubernetes-2022-11-12"
    }
  }
}
