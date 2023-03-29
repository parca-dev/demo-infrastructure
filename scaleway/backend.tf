terraform {
  cloud {
    organization = "parca-dev"

    workspaces {
      name = "demo-infrastructure-scaleway"
    }
  }
}
