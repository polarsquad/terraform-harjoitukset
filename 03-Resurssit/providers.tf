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
    token = "[token]"
}