resource "ibm_compute_vm_instance" "edu" {
  domain                     = "inppyyoo.net"
  datacenter                 = "seo01"
  hostname                   = "edu.${count.index}"
  count                      = "${var.vm_count}"
  os_reference_code          = "WIN_LATEST_64"
  flavor_key_name            = "BL2_2X4X100"
  local_disk                 = true
  public_security_group_ids  = ["${ibm_security_group.sg_public_edu.id}"]
  private_network_only       = false
  tags                       = ["group:winvm"]
}

resource "ibm_compute_vm_instance" "perf" {
  domain                     = "inppyyoo.net"
  datacenter                 = "seo01"
  hostname                   = "perf"
  os_reference_code          = "CENTOS_LATEST_64"
  flavor_key_name            = "BL2_2X4X100"
  local_disk                 = true
  public_security_group_ids  = ["${ibm_security_group.sg_public_perf.id}"]
  private_network_only       = false
  tags                       = ["group:linuxvm"]
}
