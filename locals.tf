locals {
  common_tags = {
    Project   = "Infraestructure with Terraform"
    CreatedAt = formatdate("YYYY-MM-DD", timestamp())
    ManagedBy = "Terraform"
    Owner     = "luketevl"
  }
  cluster_name = "restaurante-eks-${random_string.suffix.result}"

}


resource "random_string" "suffix" {
  length  = 8
  special = false
}