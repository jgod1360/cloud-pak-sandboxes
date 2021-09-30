
variable "ibmcloud_api_key" {
  description = "IBM Cloud API key (https://cloud.ibm.com/docs/account?topic=account-userapikey#create_user_key)"
}

variable "cluster_name_id" {
  default     = ""
  description = "Enter your cluster id or name to install the Cloud Pak. Leave blank to provision a new Openshift cluster."
}

variable "entitled_registry_user_email" {
  type = string
  description = "Email address of the user owner of the Entitled Registry Key"
//  validation {
//    condition = can(regrex("^No resources found+$", var.entitled_registry_user_email))
//    error_message = "At least one user must be available in order to proceed. Please refer to the README for the requirements and instructions. The script will now exit!"
//  }
}

variable "iaas_classic_api_key" {}
variable "iaas_classic_username" {}
//variable "ssh_public_key_file" {}
//variable "ssh_private_key_file" {}
variable "classic_datacenter" {}

variable "config_dir" {
  default     = "./.kube/config"
  description = "directory to store the kubeconfig file"
}

variable "region" {
  description = "Region where the cluster is created"
}

variable "resource_group" {
//  name       = "cloud-pak-sandbox-ibm"
  description = "Resource group name where the cluster will be hosted."
}

variable "openshift_version" {
  default     = "4.6"
  type        = string
  description = "Openshift version installed in the cluster"
}
//
//variable "hasEntitlementKey" {
//  type        = string
//  description = "Do you have a Cloud Pak for Business Automation Entitlement Registry key (Yes/No, default: No):"
//}

variable "local_registry_server" {
  description = "Enter the public image registry or route (e.g., default-route-openshift-image-registry.apps.<hostname>).\nThis is required for docker/podman login validation:"
}

variable "portworx_is_ready" {
  type    = any
  default = null
}

variable "entitled_registry_key" {
  type        = string
//  sensitive = true
  description = "Do you have a Cloud Pak for Business Automation Entitlement Registry key? If not, Get the entitlement key from https://myibm.ibm.com/products-services/containerlibrary"
}

variable "namespace" {
  type        = string
  description = "namespace for cp4ba"
}

variable "project_name" {
  description = "Enter a valid project name. Project name should not be 'openshift' or 'kube' or start with 'openshift' or 'kube'."
  type = string
//  validation {
//    condition = can(regex("^kube+$", var.project_name))
//    error_message = "Please enter a valid project name that should not be 'openshift' or 'kube' or start with 'openshift' or 'kube'."
//  }
}

variable "platform_options" {
  type        = number
  description = "Select the cloud platform to deploy. Enter a valid option [1 - 3]: \n 1. RedHat OpenShift Kubernetes Service (ROKS) - Public Cloud \n 2. Openshift Container Platform (OCP) - Private Cloud \n 3. Other ( Certified Kubernetes Cloud Platform / CNCF)"
}

variable "deployment_type" {
  type        = number
  description = "What type of deployment is being performed? Enter a valid option [1 to 2]: \n 1. Demo \n 2. Enterprise"
}

variable "platform_version" {
  description = "Enter the platform version"
}

variable "environment" {
  default     = "dev"
  description = "Ignored if `cluster_id` is specified. The environment is combined with `project_name` to name the cluster. The cluster name will be '{project_name}-{environment}-cluster' and all the resources will be tagged with 'env:{environment}'"
}

variable "use_entitlement" {
  type = string
  default = "yes"
}

//variable "public_image_registry" {
//  description = "Have you pushed the images to the local registry using 'loadimages.sh' (CP4BA images)? If not, Please pull the images to the local images to proceed."
//}
//
//variable "local_public_registry_server" {
//  description = "public image registry or route for docker/podman login validation: \n (e.g., default-route-openshift-image-registry.apps.<hostname>). This is required for docker/podman login validation: "
//}
//
//variable "local_registry_user" {
//  description = "Enter the user name for your docker registry: "
//}
//
//variable "local_registry_password" {
//  description = "Enter the password for your docker registry: "
//}
//
////1
//
//// Flavor will depend on whether classic or vpc
//variable "flavors" {
//  type        = list(string)
//  default     = ["b3c.16x64"]
//  description = "Ignored if `cluster_id` is specified. Array with the flavors or machine types of each the workers group. Classic only takes the first flavor of the list. List all flavors for each zone with: `ibmcloud ks flavors --zone us-south-1 --provider <classic | vpc-gen2>`. Classic: `[\"b3c.16x64\"]`, VPC: `[\"bx2.16x64\"]`"
//}
//
variable "workers_count" {
  type    = list(number)
  default = [5]
  description = "Ignored if `cluster_id` is specified. Array with the amount of workers on each workers group. Classic only takes the first number of the list. Example: [1, 3, 5]. Note: number of elements must equal number of elements in flavors array"
}

variable "data_center" {
  default     = "dal10"
  description = "**Classic Only**. Ignored if `cluster_id` is specified. Datacenter or Zone in the IBM Cloud Classic region to provision the cluster. List all available zones with: `ibmcloud ks zone ls --provider classic`"
}

variable "vpc_zone_names" {
  type        = list(string)
  default     = ["us-south-1"]
  description = "**VPC Only**: Ignored if `cluster_id` is specified. Zones in the IBM Cloud VPC region to provision the cluster. List all available zones with: `ibmcloud ks zone ls --provider vpc-gen2`."
}

variable "private_vlan_number" {
  default     = ""
  description = "**Classic Only**. Ignored if `cluster_id` is specified. Private VLAN assigned to your zone. List available VLANs in the zone: `ibmcloud ks vlan ls --zone <zone>`, make sure the the VLAN type is private and the router begins with bc. Use the ID or Number. Leave blank if Private VLAN does not exist, one will be created"
}

variable "public_vlan_number" {
  default     = ""
  description = "**Classic Only**. Ignored if `cluster_id` is specified. Public VLAN assigned to your zone. List available VLANs in the zone: `ibmcloud ks vlan ls --zone <zone>`, make sure the the VLAN type is public and the router begins with fc. Use the ID or Number. Leave blank if Public VLAN does not exist, one will be created"
}

//variable "storage_capacity"{
//    type = number
//    default = 200
//    description = "Ignored if Portworx is not enabled: Storage capacity in GBs"
//}
//
//variable "storage_db2" {
//    type = number
//    default = 10
//    description = "Ignored if Portworx is not enabled. Optional, Used only if a user provides a custom storage_profile"
//}
//
//variable "storage_profile" {
//    type = string
//    default = "10iops-tier"
//    description = "Ignored if Portworx is not enabled. Optional, Storage profile used for creating storage"
//}
//
//variable "create_external_etcd" {
//    type = bool
//    default = false
//    description = "Ignored if Portworx is not enabled: Do you want to create an external etcd database? `true` or `false`"
//}
//
//# These credentials have been hard-coded because the 'Databases for etcd' service instance is not configured to have a publicly accessible endpoint by default.
//# You may override these for additional security.
//variable "etcd_username" {
//  default = ""
//  description = "Ignored if Portworx is not enabled: This has been hard-coded because the 'Databases for etcd' service instance is not configured to have a publicly accessible endpoint by default.  Override these for additional security."
//}
//
//variable "etcd_password" {
//  default = ""
//  description = "Ignored if Portworx is not enabled: This has been hard-coded because the 'Databases for etcd' service instance is not configured to have a publicly accessible endpoint by default.  Override these for additional security."
//}

variable "cluster_config_path" {
  default     = "./.kube/config"
  description = "directory to store the kubeconfig file"
}

variable "registry_server" {
  description = "Enter the public image registry or route (e.g., default-route-openshift-image-registry.apps.<hostname>).\nThis is required for docker/podman login validation:"
}

variable "entitlement_key" {
  type        = string
  description = "Do you have a Cloud Pak for Business Automation Entitlement Registry key? If not, Get the entitlement key from https://myibm.ibm.com/products-services/containerlibrary"
}

variable "registry_user" {
  description = "Enter the user name for your docker registry: "
}

variable "docker_password" {
  description = "Enter the password for your docker registry: "
}

variable "docker_username" {
  description = "Docker username for creating the secret."
}

variable "docker_secret_name" {
  description = "Enter the name of the docker registry's image."
}

variable "cluster_name_or_id" {
  default     = ""
  description = "Enter your cluster id or name to install the Cloud Pak. Leave blank to provision a new Openshift cluster."
}

variable "cp4ba_project_name" {
  default = "cp4ba"
  description = "Project name or namespace where Cloud Pak for Business Automation will be installed."
}

variable "install_portworx" {
  type        = bool
  default     = false
  description = "Install Portworx on the ROKS cluster. `true` or `false`"
}

variable "storage_capacity"{
    type = number
    default = 200
    description = "Ignored if Portworx is not enabled: Storage capacityin GBs"
}

variable "storage_profile" {
    type = string
    default = "10iops-tier"
    description = "Ignored if Portworx is not enabled. Optional, Storage profile used for creating storage"
}

variable "storage_iops" {
    type = number
    default = 10
    description = "Ignored if Portworx is not enabled. Optional, Used only if a user provides a custom storage_profile"
}

variable "create_external_etcd" {
    type = bool
    default = false
    description = "Ignored if Portworx is not enabled: Do you want to create an external etcd database? `true` or `false`"
}

# These credentials have been hard-coded because the 'Databases for etcd' service instance is not configured to have a publicly accessible endpoint by default.
# You may override these for additional security.
variable "etcd_username" {
  default = ""
  description = "Ignored if Portworx is not enabled: This has been hard-coded because the 'Databases for etcd' service instance is not configured to have a publicly accessible endpoint by default.  Override these for additional security."
}

variable "etcd_password" {
  default = ""
  description = "Ignored if Portworx is not enabled: This has been hard-coded because the 'Databases for etcd' service instance is not configured to have a publicly accessible endpoint by default.  Override these for additional security."
}

// OpenShift cluster specific input parameters and default values:
variable "flavors" {
  type    = list(string)
  default = ["b3c.16x64"]
  description = "Ignored if `cluster_id` is specified. Array with the flavors or machine types of each of the workers. List all flavors for each zone with: `ibmcloud ks flavors --zone us-south-1 --provider vpc-gen2` or `ibmcloud ks flavors --zone dal10 --provider classic`. On Classic only list one flavor, i.e. `[\"b3c.16x64\"]`. On VPC can list multiple flavors `[\"mx2.4x32\", \"mx2.8x64\", \"cx2.4x8\"] or [\"bx2.16x64\"]`"
}

# Password for LDAP Admin User (ldapAdminName name see below), for example passw0rd - use the password that you specified when setting up LDAP
variable "ldap_admin_password" {}

# LDAP instance access information - hostname or IP
variable "ldap_server" {}

# --------- DB2 SETTINGS ----------
locals {
  # CP4BA Database Name information
  db2_ums_db_name   = "UMSDB"
  db2_icn_db_name   = "ICNDB"
  db2_devos_1_name  = "DEVOS1"
  db2_aeos_name     = "AEOS"
  db2_baw_docs_name = "BAWDOCS"
  db2_baw_tos_name  = "BAWTOS"
  db2_baw_dos_name  = "BAWDOS"
  db2_baw_Db_name   = "BAWDB"
  db2_app_db_name   = "APPDB"
  db2_ae_db_name    = "AEDB"
  db2_bas_db_name   = "BASDB"
  db2_gcd_db_name   = "GCDDB"
  db2_admin_user_password  = "passw0rd"
  db2_standard_license_key = "W0xpY2Vuc2VDZXJ0aWZpY2F0ZV0KQ2hlY2tTdW09Q0FBODlCOTA0QzU3RTY2OTU1RjJDQTY4MzlCRTZCOTMKVGltZVN0YW1wPTE1NjU3MjM5MDIKUGFzc3dvcmRWZXJzaW9uPTQKVmVuZG9yTmFtZT1JQk0gVG9yb250byBMYWIKVmVuZG9yUGFzc3dvcmQ9N3Y4cDRmcTJkdGZwYwpWZW5kb3JJRD01ZmJlZTBlZTZmZWIuMDIuMDkuMTUuMGYuNDguMDAuMDAuMDAKUHJvZHVjdE5hbWU9REIyIFN0YW5kYXJkIEVkaXRpb24KUHJvZHVjdElEPTE0MDUKUHJvZHVjdFZlcnNpb249MTEuNQpQcm9kdWN0UGFzc3dvcmQ9MzR2cnc1MmQyYmQyNGd0NWFmNHU4Y2M0ClByb2R1Y3RBbm5vdGF0aW9uPTEyNyAxNDMgMjU1IDI1NSA5NCAyNTUgMSAwIDAgMC0yNzsjMCAxMjggMTYgMCAwCkFkZGl0aW9uYWxMaWNlbnNlRGF0YT0KTGljZW5zZVN0eWxlPW5vZGVsb2NrZWQKTGljZW5zZVN0YXJ0RGF0ZT0wOC8xMy8yMDE5CkxpY2Vuc2VEdXJhdGlvbj02NzE2CkxpY2Vuc2VFbmREYXRlPTEyLzMxLzIwMzcKTGljZW5zZUNvdW50PTEKTXVsdGlVc2VSdWxlcz0KUmVnaXN0cmF0aW9uTGV2ZWw9MwpUcnlBbmRCdXk9Tm8KU29mdFN0b3A9Tm8KQnVuZGxlPU5vCkN1c3RvbUF0dHJpYnV0ZTE9Tm8KQ3VzdG9tQXR0cmlidXRlMj1ObwpDdXN0b21BdHRyaWJ1dGUzPU5vClN1YkNhcGFjaXR5RWxpZ2libGVQcm9kdWN0PU5vClRhcmdldFR5cGU9QU5ZClRhcmdldFR5cGVOYW1lPU9wZW4gVGFyZ2V0ClRhcmdldElEPUFOWQpFeHRlbmRlZFRhcmdldFR5cGU9CkV4dGVuZGVkVGFyZ2V0SUQ9ClNlcmlhbE51bWJlcj0KVXBncmFkZT1ObwpJbnN0YWxsUHJvZ3JhbT0KQ2FwYWNpdHlUeXBlPQpNYXhPZmZsaW5lUGVyaW9kPQpEZXJpdmVkTGljZW5zZVN0eWxlPQpEZXJpdmVkTGljZW5zZVN0YXJ0RGF0ZT0KRGVyaXZlZExpY2Vuc2VFbmREYXRlPQpEZXJpdmVkTGljZW5zZUFnZ3JlZ2F0ZUR1cmF0aW9uPQo="
  db2_cpu    = 4
  db2_memory = "16Gi"
  db2_instance_version = "11.5.6.0"
  db2_host_name   = "REQUIRED"
  db2_host_ip     = "REQUIRED"
  db2_port_number = "REQUIRED"
  db2_use_on_ocp  = true
  db2_admin_user_name           = "db2inst1"
//  cp4ba_deployment_platform     = local.platform_options
  db2_on_ocp_storage_class_name = local.sc_fast_file_storage_classname
  db2_storage_size              = "150Gi"
  db2_project_name              = "ibm-db2"
}

// Portworx Module Variables
//variable "install_portworx" {
//  type        = bool
//  default     = false
//  description = "Install Portworx on the ROKS cluster. `true` or `false`"
//}

locals {
//  cp4ba_namespace              = "cp4ba"

  docker_secret_name           = "docker-registry"
  docker_server                = "cp.icr.io"
  docker_username              = "cp"
  docker_password              = chomp(var.entitlement_key)
  docker_email                 = var.entitled_registry_user_email

  enable_cluster               = var.cluster_name_or_id == "" || var.cluster_name_or_id == null
  use_entitlement              = "yes"
  project_name                 = "cp4ba"
  platform_options             = 1 // 1: roks - 2: ocp - 3: private cloud
  deployment_type              = 2 // 1: demo - 2: enterprise
  platform_version             = "4.6" // roks version

//  entitled_registry_key        = chomp(var.entitlement_key)
  ibmcloud_api_key             = chomp(var.ibmcloud_api_key)
 }

locals {
  storage_class_name               = "cp4a-file-retain-gold-gid"
  sc_slow_file_storage_classname   = "cp4a-file-retain-bronze-gid"
  sc_medium_file_storage_classname = "cp4a-file-retain-silver-gid"
  sc_fast_file_storage_classname   = "cp4a-file-retain-gold-gid"
}


# -------- DB2 Variables ---------
variable "db2_admin_user_password" {
  default = "passw0rd"
}

variable "db2_admin_username" {
  default = "db2inst1"
}

variable "db2_host_name" {}

variable "db2_host_ip" {}

variable "db2_port_number" {}

locals {
  //  cp4ba_namespace              = "cp4ba"
  entitled_registry_key_secret_name  = "ibm-entitlement-key"
  docker_server                = "cp.icr.io"
  docker_username              = "cp"
  docker_email                 = var.entitled_registry_user_email
  enable_cluster               = var.cluster_name_or_id == "" || var.cluster_name_or_id == null
  use_entitlement              = "yes"
  ibmcloud_api_key             = chomp(var.ibmcloud_api_key)
}

# --- CP4BA SETTINGS ---
locals {
  cp4ba_admin_name = "cp4badmin"
  cp4ba_admin_group = "cp4badmins"
  cp4ba_users_group = "cp4bausers"
  cp4ba_ums_admin_name = "umsadmin"
  cp4ba_ums_admin_group = "cn=cp4badmins,dc=example,dc=com"
}

# --- LDAP SETTINGS ---
locals {
  # LDAP name - don't use dashes (-), only use underscores
  ldap_name = "ldap_custom"
  ldap_admin_name = "cn=root"
  ldap_type = "IBM Security Directory Server"
  ldap_port = "389"
  ldap_server = "150.238.92.26"
  ldap_base_dn = "dc=example,dc=com"
  ldap_user_name_attribute = "*:cn"
  ldap_user_display_name_attr = "cn"
  ldap_group_base_dn = "dc=example,dc=com"
  ldap_group_name_attribute = "*:cn"
  ldap_group_display_name_attr = "cn"
  ldap_group_membership_search_filter = "('\\|(\\&(objectclass=groupOfNames)(member={0}))(\\&(objectclass=groupOfUniqueNames)(uniqueMember={0})))"
  ldap_group_member_id_map = "groupofnames:member"
  ldap_ad_gc_host = ""
  ldap_ad_gc_port = ""
  ldap_ad_user_filter = "(\\&(samAccountName=%v)(objectClass=user))"
  ldap_ad_group_filter = "(\\&(samAccountName=%v)(objectclass=group))"
  ldap_tds_user_filter = "(\\&(cn=%v)(objectclass=person))"
  ldap_tds_group_filter = "(\\&(cn=%v)(\\|(objectclass=groupofnames)(objectclass=groupofuniquenames)(objectclass=groupofurls)))"
}

# --- HA Settings ---
locals {
  cp4ba_replica_count = 1
  cp4ba_bai_job_parallelism = 1
}