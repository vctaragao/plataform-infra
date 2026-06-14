resource "google_container_cluster" "this" {
  addons_config {
    cloudrun_config {
      disabled = true
    }

    config_connector_config {
      enabled = false
    }

    dns_cache_config {
      enabled = true
    }

    gce_persistent_disk_csi_driver_config {
      enabled = true
    }

    gcp_filestore_csi_driver_config {
      enabled = false
    }

    gcs_fuse_csi_driver_config {
      enabled = false
    }

    gke_backup_agent_config {
      enabled = false
    }

    http_load_balancing {
      disabled = false
    }

    network_policy_config {
      disabled = true
    }
  }

  binary_authorization {
    evaluation_mode = "DISABLED"
  }

  cluster_autoscaling {
    autoscaling_profile = "BALANCED"
  }

  control_plane_endpoints_config {
    ip_endpoints_config {
      enabled = true
    }
  }

  cost_management_config {
    enabled = false
  }

  database_encryption {
    state = "DECRYPTED"
  }

  datapath_provider         = "LEGACY_DATAPATH"
  default_max_pods_per_node = 110

  default_snat_status {
    disabled = false
  }

  dns_config {
    cluster_dns = "KUBE_DNS"
  }

  enable_shielded_nodes = true

  gateway_api_config {
    channel = "CHANNEL_STANDARD"
  }

  ip_allocation_policy {
    cluster_secondary_range_name = var.cluster_secondary_range_name

    pod_cidr_overprovision_config {
      disabled = false
    }

    stack_type = "IPV4"
  }

  location = var.location

  logging_config {
    enable_components = ["SYSTEM_COMPONENTS", "WORKLOADS"]
  }

  master_auth {
    client_certificate_config {
      issue_client_certificate = false
    }
  }

  monitoring_config {
    advanced_datapath_observability_config {
      enable_metrics = false
      enable_relay   = false
    }

    enable_components = ["SYSTEM_COMPONENTS", "STORAGE", "HPA", "POD", "DAEMONSET", "DEPLOYMENT", "STATEFULSET", "CADVISOR", "KUBELET", "DCGM", "JOBSET"]

    managed_prometheus {
      enabled = true

      auto_monitoring_config {
        scope = "NONE"
      }
    }
  }

  name    = var.name
  network = var.network

  network_policy {
    enabled  = false
    provider = "PROVIDER_UNSPECIFIED"
  }

  networking_mode = "VPC_NATIVE"

  node_config {
    advanced_machine_features {
      threads_per_core = 1
    }

    disk_size_gb = 20
    disk_type    = "pd-balanced"

    ephemeral_storage_local_ssd_config {
      local_ssd_count = 0
    }

    image_type      = "COS_CONTAINERD"
    logging_variant = "DEFAULT"
    machine_type    = "e2-small"

    metadata = {
      disable-legacy-endpoints = "true"
    }

    oauth_scopes = ["https://www.googleapis.com/auth/devstorage.read_only", "https://www.googleapis.com/auth/logging.write", "https://www.googleapis.com/auth/monitoring", "https://www.googleapis.com/auth/service.management.readonly", "https://www.googleapis.com/auth/servicecontrol", "https://www.googleapis.com/auth/trace.append"]

    resource_labels = {
      goog-gke-node-pool-provisioning-model = "spot"
    }

    service_account = "default"

    shielded_instance_config {
      enable_integrity_monitoring = true
    }

    spot = true
  }

  node_pool_defaults {
    node_config_defaults {
      gcfs_config {
        enabled = false
      }

      insecure_kubelet_readonly_port_enabled = "FALSE"
      logging_variant                        = "DEFAULT"
    }
  }

  node_version = "1.35.5-gke.1000000"

  notification_config {
    pubsub {
      enabled = false
    }
  }

  pod_autoscaling {
    hpa_profile = "PERFORMANCE"
  }

  private_cluster_config {
    master_global_access_config {
      enabled = false
    }
  }

  project = var.project_id

  release_channel {
    channel = "REGULAR"
  }

  security_posture_config {
    mode               = "BASIC"
    vulnerability_mode = "VULNERABILITY_DISABLED"
  }

  service_external_ips_config {
    enabled = false
  }

  subnetwork = var.subnetwork

  vertical_pod_autoscaling {
    enabled = false
  }

  workload_identity_config {
    workload_pool = "${var.project_id}.svc.id.goog"
  }
}
