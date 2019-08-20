data "ibm_dns_domain" "main" {
    name = "inppyyoo.net"
}

resource "ibm_dns_record" "win_cname" {
    data = "${element(ibm_compute_vm_instance.edu.*.ipv4_address, count.index)}"
    domain_id = "${data.ibm_dns_domain.main.id}"
    host = "${element(ibm_compute_vm_instance.edu.*.hostname, count.index)}"
    ttl = 300
    type = "cname"
    count = "${var.vm_count}"
}

resource "ibm_dns_record" "linux_cname" {
    data = "${ibm_compute_vm_instance.perf.ipv4_address}"
    domain_id = "${data.ibm_dns_domain.main.id}"
    host = "${ibm_compute_vm_instance.perf.hostname}"
    ttl = 300
    type = "cname"
}