provider "aws" {
access_key = var.aws_access_key
secret_key = var.aws_secret_key
region = "us-east-1"

}
data "aws_ebs_volume" "ebs-id" {
  filter {
    name   = "volume-type"
    values = ["gp2"]
  }

  filter {
    name   = "tag:Name"
    values = ["terraform-root"]
  }
}
resource "aws_ebs_snapshot" "snap" {
  volume_id = data.aws_ebs_volume.ebs-id.volume_id

  tags = {
    Name = "HelloWorld_snap"
  }
}

resource "aws_ami" "new" {
  name                = "amifromsnap"
  virtualization_type = "hvm"
  root_device_name    = "/dev/sda1"

  ebs_block_device {
    device_name = "/dev/sda1"
    snapshot_id = aws_ebs_snapshot.snap.id
    volume_size = 8
  }
}

