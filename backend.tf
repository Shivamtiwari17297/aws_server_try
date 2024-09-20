# backend.tf
terraform {
    backend "s3" {
        bucket = "sdsddd"
        key    =" prod-global/game-server"   ## Name change API or game.
        region = "ap-south-1"
    }
}
