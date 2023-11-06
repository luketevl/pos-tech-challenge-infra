locals {
  common_tags = {
    Project   = "Infraestructure with Terraform"
    CreatedAt = formatdate("YYYY-MM-DD", timestamp())
    ManagedBy = "Terraform"
    Owner     = "luketevl"
  }
  cluster_name = "restaurante-eks"
}
