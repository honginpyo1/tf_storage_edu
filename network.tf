# network.tf

# Setup of network related parameters for virtual machines

#########################################################
# This file creates the security group used by the VSIs. The security group rules 
# allow internet access for install of open source packages
#########################################################

#########################################################
# Create Public Security Group 
#########################################################

resource "ibm_security_group" "sg_public_edu" {
  name        = "sg_public_edu"
  description = "Public access for RDP"
}

resource "ibm_security_group" "sg_public_perf" {
  name        = "sg_public_perf"
  description = "Public access for ssh"
}

#########################################################
# Create policies for security group
# 1. allow tcp on 80 for HTTP access to repo's
# 2. allow tcp on 443 for HTTPS access to repo's
# Inbound http access is via private network through load balancer
#########################################################

resource "ibm_security_group_rule" "rdp-pub" {
  direction         = "egress"
  ether_type        = "IPv4"
  port_range_min    = 3389
  port_range_max    = 3389
  protocol          = "tcp"
  security_group_id = "${ibm_security_group.sg_public_edu.id}"
}

resource "ibm_security_group_rule" "win-https-pub" {
  direction         = "egress"
  ether_type        = "IPv4"
  port_range_min    = 443
  port_range_max    = 443
  protocol          = "tcp"
  security_group_id = "${ibm_security_group.sg_public_edu.id}"
}

resource "ibm_security_group_rule" "win-http-pub" {
  direction         = "egress"
  ether_type        = "IPv4"
  port_range_min    = 80
  port_range_max    = 80
  protocol          = "tcp"
  security_group_id = "${ibm_security_group.sg_public_edu.id}"
}

resource "ibm_security_group_rule" "rdp-pub_in" {
  direction         = "ingress"
  ether_type        = "IPv4"
  port_range_min    = 3389
  port_range_max    = 3389
  protocol          = "tcp"
  security_group_id = "${ibm_security_group.sg_public_edu.id}"
}

#########################################################
# Create policies for security group Linux
#########################################################

resource "ibm_security_group_rule" "ssh-pub-in" {
  direction         = "ingress"
  ether_type        = "IPv4"
  port_range_min    = 22
  port_range_max    = 22
  protocol          = "tcp"
  security_group_id = "${ibm_security_group.sg_public_perf.id}"
}

resource "ibm_security_group_rule" "ssh-pub-out" {
  direction         = "egress"
  ether_type        = "IPv4"
  port_range_min    = 22
  port_range_max    = 22
  protocol          = "tcp"
  security_group_id = "${ibm_security_group.sg_public_perf.id}"
}

resource "ibm_security_group_rule" "lin-https-pub" {
  direction         = "egress"
  ether_type        = "IPv4"
  port_range_min    = 443
  port_range_max    = 443
  protocol          = "tcp"
  security_group_id = "${ibm_security_group.sg_public_perf.id}"
}

resource "ibm_security_group_rule" "lin-http-pub" {
  direction         = "egress"
  ether_type        = "IPv4"
  port_range_min    = 80
  port_range_max    = 80
  protocol          = "tcp"
  security_group_id = "${ibm_security_group.sg_public_perf.id}"
}