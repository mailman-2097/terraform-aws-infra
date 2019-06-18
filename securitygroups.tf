#Domain Controller Security Groups
resource "aws_security_group" "domain_controller" {
  name        = "domain_controller"
  description = "Domain Controller Security Groups"
  vpc_id      = "${aws_vpc.default.id}"

  ingress {
    #LDAP
    from_port   = 389
    to_port     = 389
    protocol    = "tcp"
    cidr_blocks = "${var.private_subnets_cidr}"
  }
  ingress {
    #LDAP
    from_port   = 389
    to_port     = 389
    protocol    = "udp"
    cidr_blocks = "${var.private_subnets_cidr}"
  }
  ingress {
    #LDAP SSL
    from_port   = 636
    to_port     = 636
    protocol    = "TCP"
    cidr_blocks = "${var.private_subnets_cidr}"
  }
  ingress {
    #LDAP GC, GC SSL
    from_port   = 3268
    to_port     = 3269
    protocol    = "tcp"
    cidr_blocks = "${var.private_subnets_cidr}"
  }
  ingress {
    #Kerberos
    from_port   = 88
    to_port     = 88
    protocol    = "tcp"
    cidr_blocks = "${var.private_subnets_cidr}"
  }
  ingress {
    #Kerberos
    from_port   = 88
    to_port     = 88
    protocol    = "udp"
    cidr_blocks = "${var.private_subnets_cidr}"
  }
  ingress {
    #DNS
    from_port   = 53
    to_port     = 53
    protocol    = "tcp"
    cidr_blocks = "${var.private_subnets_cidr}"
  }
  ingress {
    #DNS
    from_port   = 53
    to_port     = 53
    protocol    = "udp"
    cidr_blocks = "${var.private_subnets_cidr}"
  }
  ingress {
    #SMB,CIFS,SMB2, DFSN, LSARPC, NbtSS, NetLogonR, SamR, SrvSvc
    from_port   = 445
    to_port     = 445
    protocol    = "tcp"
    cidr_blocks = "${var.private_subnets_cidr}"
  }
  ingress {
    #SMB,CIFS,SMB2, DFSN, LSARPC, NbtSS, NetLogonR, SamR, SrvSvc
    from_port   = 445
    to_port     = 445
    protocol    = "udp"
    cidr_blocks = "${var.private_subnets_cidr}"
  }
  ingress {
    #SMTP
    from_port   = 25
    to_port     = 25
    protocol    = "tcp"
    cidr_blocks = "${var.private_subnets_cidr}"
  }
  ingress {
    #RPC, EPM
    from_port   = 135
    to_port     = 135
    protocol    = "tcp"
    cidr_blocks = "${var.private_subnets_cidr}"
  }
  ingress {
    #RPC, DCOM, EPM, DRSUAPI, NetLogonR, SamR, FRS
    from_port   = 49152
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = "${var.private_subnets_cidr}"
  }
  ingress {
    #RPC, DFSR (SYSVOL)
    from_port   = 5722
    to_port     = 5722
    protocol    = "tcp"
    cidr_blocks = "${var.private_subnets_cidr}"
  }
  ingress {
    #Windows Time
    from_port   = 123
    to_port     = 123
    protocol    = "udp"
    cidr_blocks = "${var.private_subnets_cidr}"
  }
  ingress {
    #Kerberos change/set password
    from_port   = 464
    to_port     = 464
    protocol    = "tcp"
    cidr_blocks = "${var.private_subnets_cidr}"
  }
  ingress {
    #Kerberos change/set password
    from_port   = 464
    to_port     = 464
    protocol    = "udp"
    cidr_blocks = "${var.private_subnets_cidr}"
  }
  ingress {
    #DCOM, RPC, EPM
    from_port   = 49152
    to_port     = 65535
    protocol    = "udp"
    cidr_blocks = "${var.private_subnets_cidr}"
  }
  ingress {
    #DFSN, NetLogon, NetBIOS Datagram Service
    from_port   = 138
    to_port     = 138
    protocol    = "udp"
    cidr_blocks = "${var.private_subnets_cidr}"
  }
  ingress {
    #SOAP
    from_port   = 9389
    to_port     = 9389
    protocol    = "tcp"
    cidr_blocks = "${var.private_subnets_cidr}"
  }
  ingress {
    #DHCP, MADCAP
    from_port   = 67
    to_port     = 67
    protocol    = "udp"
    cidr_blocks = "${var.private_subnets_cidr}"
  }
  ingress {
    #DHCP, MADCAP
    from_port   = 2535
    to_port     = 2535
    protocol    = "udp"
    cidr_blocks = "${var.private_subnets_cidr}"
  }
  ingress {
    #NetLogon, NetBIOS Name Resolution
    from_port   = 137
    to_port     = 137
    protocol    = "udp"
    cidr_blocks = "${var.private_subnets_cidr}"
  }
  ingress {
    #DFSN, NetBIOS Session Service, NetLogon
    from_port   = 139
    to_port     = 139
    protocol    = "tcp"
    cidr_blocks = "${var.private_subnets_cidr}"
  }
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}