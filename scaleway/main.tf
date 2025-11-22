resource "scaleway_vpc" "parca_demo" {
  name = "parca-demo"
}

resource "scaleway_vpc_private_network" "parca_demo" {
  name   = "parca-demo"
  vpc_id = scaleway_vpc.parca_demo.id
}

resource "scaleway_k8s_cluster" "parca_demo" {
  name                        = "parca-demo"
  type                        = "kapsule"
  description                 = ""
  version                     = "1.33"
  cni                         = "cilium"
  delete_additional_resources = false

  autoscaler_config {
    balance_similar_node_groups      = false
    disable_scale_down               = false
    estimator                        = "binpacking"
    expander                         = "random"
    expendable_pods_priority_cutoff  = -10
    ignore_daemonsets_utilization    = false
    max_graceful_termination_sec     = 600
    scale_down_delay_after_add       = "10m"
    scale_down_unneeded_time         = "10m"
    scale_down_utilization_threshold = 0.5
  }

  auto_upgrade {
    enable                        = true
    maintenance_window_day        = "any"
    maintenance_window_start_hour = "11"
  }

  feature_gates       = []
  admission_plugins   = []
  apiserver_cert_sans = []

  private_network_id = scaleway_vpc_private_network.parca_demo.id

  tags = []
}

resource "scaleway_k8s_pool" "parca_demo_pool_gp1_xs" {
  cluster_id = scaleway_k8s_cluster.parca_demo.id
  name       = "pool-gp1-xs"
  node_type  = "gp1_xs"
  size       = "2"
  min_size   = "2"
  max_size   = "2"

  autohealing       = true
  autoscaling       = false
  container_runtime = "containerd"

  kubelet_args = {}

  upgrade_policy {
    max_surge       = 0
    max_unavailable = 1
  }

  wait_for_pool_ready = false

  tags = []
}

resource "scaleway_object_bucket" "parca_analytics" {
  name = "parca-analytics"
}
