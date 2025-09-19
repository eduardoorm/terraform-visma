resource "random_password" "db_password" {
  length  = 16
  special = true
}

resource "google_compute_global_address" "private_ip_address" {
  name          = "${var.project_name}-${var.environment}-private-ip"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = 16
  network       = var.vpc_network.id
}

resource "google_service_networking_connection" "private_vpc_connection" {
  network                 = var.vpc_network.id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_address.name]
}

resource "google_sql_database_instance" "main" {
  name             = "${var.project_name}-${var.environment}-mysql-${var.db_instance_name}"
  database_version = "MYSQL_8_4"
  region           = var.region

  deletion_protection = false

  settings {
    tier              = "db-n1-standard-1"  # Tier mínimo compatible con MySQL 8.4
    availability_type = "ZONAL"             # Zonal es más barato que Regional
    disk_size         = 10                  # Tamaño mínimo de disco (10GB)
    disk_type         = "PD_HDD"            # HDD es más barato que SSD para POCs
    disk_autoresize   = false               # Deshabilitado para controlar costos
    edition           = "ENTERPRISE"        # Edición mínima disponible para MySQL 8.4

    backup_configuration {
      enabled                        = false  # Deshabilitado para reducir costos en POC
      binary_log_enabled             = false  # Específico para MySQL
    }

    ip_configuration {
      ipv4_enabled                                  = false
      private_network                               = var.vpc_network.id
      enable_private_path_for_google_cloud_services = true
    }

    database_flags {
      name  = "general_log"
      value = "on"
    }

    database_flags {
      name  = "slow_query_log"
      value = "on"
    }

    database_flags {
      name  = "long_query_time"
      value = "1"
    }
  }

  depends_on = [google_service_networking_connection.private_vpc_connection]
}

resource "google_sql_database" "database" {
  name     = var.db_name
  instance = google_sql_database_instance.main.name
}

resource "google_sql_user" "user" {
  name     = var.db_user
  instance = google_sql_database_instance.main.name
  password = random_password.db_password.result
}

