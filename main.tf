resource "ibm_compute_vm_instance" "edu" {
  domain                     = "inppyyoo.net"
  datacenter                 = "seo01"
  hostname                   = "edu-${count.index}"
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
  ssh_key_ids                = ["${ibm_compute_ssh_key.main_ssh_key.id}"]
}


resource "ibm_compute_ssh_key" "main_ssh_key" {
    label = "perf_ssh"
    notes = "perf_ssh"
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDawgux7227+hFO/j8I81J3QfUQI2qKCVSrvQ+z2Z2rouyAwUILknR0GNCxOg9nePSheBhlywkOJwVYHBvxFHoLDNcYJQONqYEevi/Pcoin52wmamGwLwozGpmA1O7yXRJPOovCiGHTuHNr7hKvlkOJLwIoGX9YdxirAdlpvIJ479u8hJtNebAehsRjqxrgpeGQFbksx7hLytY0GUORplR7V3RKT9VHJxeiJLypcOMqVKrOuqhxITJ/SQ9SaijnDscZRMVu5kJJzaT5mzw080imw8sGrDj1C9Sh7zV9c9Fedtc5RJEZSXu8ZRElQkZ1XDpZeviHTwlBaFSJm6A7MysEE4M7PNGAjjPUswo85mMWenI751k+1N6t+wqh6kCxkqbBLrRTjfpDLfUOYLPDrS3NwgsTuk3Ry0dVIGO2lgyfsfMjFAGZpMpMpO0lB8TVjtdzDKjbgkucP2LESfUyYiGaafCKxYzTeJQwTqEy2JnKfqKYpD2oSBlokxMVOlMT2Y7hOwdgdPovimbusJ9FABCRuAlVExRk4mzVDJAZZk5UNyYGITwS4ZO7nOOwrZ9uTBQquGWuc6V9LSROSSVAFK4pUM0ySIG31Tkvjd98hOCy9lWhLFetnxKkMvKb3DP9EuSDNLUk89oshyvSZB0hTq/iWIbouJnq37D0TIqAc4GV3w== honginpyo1@hanmail.net"
}