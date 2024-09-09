# Usage:
# packer init config.pkr.hcl

packer {
    required_version = ">= 1.8.5"
    required_plugins {
        vagrant = {
            version = "~> 1"
            source = "github.com/hashicorp/vagrant"
        }
        qemu = {
            version = "~> 1"
            source  = "github.com/hashicorp/qemu"
        }
        virtualbox = {
            version = "~> 1"
            source = "github.com/hashicorp/virtualbox"
        }
    }
}

