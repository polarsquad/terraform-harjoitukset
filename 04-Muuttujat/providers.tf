# providers.tf

terraform {
    required_providers {
        local = {
            source  = "hashicorp/local"
            version = "2.2.3"
        }
        fakewebservices = {
            source = "hashicorp/fakewebservices"
            version = "0.2.3"
        }
    }
}

provider "fakewebservices" {
    token = "x3GTPBgZaeiWeg.atlasv1.p7YO15Ea7pV9IwzdFzz7FIDZfudIl87LU0z4nK3OZ19kfXhgQH3vevm6hGEuJqnbUUs"
}