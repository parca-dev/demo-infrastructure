#resource "civo_network" "demo" {
#  label = "demo"
#}
#
#resource "civo_firewall" "demo" {
#  name                 = "demo"
#  network_id           = civo_network.demo.id
#  create_default_rules = false
#
#  ingress_rule {
#    protocol   = "tcp"
#    port_range = "6443"
#    cidr       = ["0.0.0.0/0"]
#    label      = "kubernetes-api-server"
#    action     = "allow"
#  }
#}
#
#resource "civo_kubernetes_cluster" "demo" {
#  name               = "demo"
#  firewall_id        = civo_firewall.demo.id
#  network_id         = civo_network.demo.id
#  cluster_type       = "k3s"
#  cni                = "cilium"
#  kubernetes_version = "1.27.1-k3s1"
#
#  pools {
#    label      = "default"
#    size       = "g4p.kube.small"
#    node_count = 2
#  }
#}
#
#resource "civo_kubernetes_node_pool" "g4s_kube_medium" {
#  cluster_id = civo_kubernetes_cluster.demo.id
#  label      = "g4s-kube-medium"
#  node_count = 2
#  size       = "g4s.kube.medium"
#  region     = "FRA1"
#}
