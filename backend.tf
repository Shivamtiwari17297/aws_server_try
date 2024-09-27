# backend.tf
terraform {
    backend "s3" {
        bucket = "sswsa"
        key    =" prod-global/game-server"   ## Name change API or game.
        region = "us-east-1"
    }
}
