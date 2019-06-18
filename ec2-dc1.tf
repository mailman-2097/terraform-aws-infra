data "aws_ami" "windowsdc1" {
  most_recent = true

  filter {
    name = "platform"
    values = ["windows"]
  }

  filter {
    name   = "name"
    values = ["Windows_Server-2019-English-Full-Base-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["self", "amazon"]
}

resource "aws_instance" "dc1" {
  ami               = "${data.aws_ami.windowsdc1.id}"
  instance_type     = "${var.dc_instance_type}"
  subnet_id         = "${aws_subnet.private.*.id[0]}"
  availability_zone = "${var.aws_availability_zones[0]}"
  security_groups   = ["${aws_security_group.domain_controller.id}"]
  key_name          = "${var.dc_instance_key}"
  iam_instance_profile = "${var.dc_instance_iam}"
  tags              = {
    Name = "dc1"
    Creator = "${var.dc_instance_creatortag}"
  }
  user_data         = <<-EOF
                        <powershell>
                        mkdir "c:\cwagent"
                        wget "https://s3.amazonaws.com/amazoncloudwatch-agent/windows/amd64/latest/AmazonCloudWatchAgent.zip" -OutFile "C:\cwagent\cwagent.zip"
                        Add-Type -AssemblyName System.IO.Compression.FileSystem
                        function Unzip
                        {
                            param([string]$zipfile, [string]$outpath)
                            [System.IO.Compression.ZipFile]::ExtractToDirectory($zipfile, $outpath)
                        }
                        Unzip "C:\cwagent\cwagent.zip" "C:\cwagent"
                        Set-Location "C:\cwagent"
                        .\install.ps1
                        wget https://s3.amazonaws.com/${var.s3_monitoring_bucket}/config/cloudwatchagent-windows-config.json -OutFile "C:\Program Files\Amazon\AmazonCloudWatchAgent\config.json"
                        Set-Location “C:\Program Files\Amazon\AmazonCloudWatchAgent”
                        .\amazon-cloudwatch-agent-ctl.ps1 -a fetch-config -m ec2 -c file:config.json -s
                        </powershell>
                    EOF
  depends_on = ["aws_s3_bucket.awsmonitoring"]
}