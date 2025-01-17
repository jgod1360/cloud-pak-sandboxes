// IAF Module Variables
variable "entitled_registry_key" {
  default     = ""
  description = "Required: Cloud Pak Entitlement Key. Get the entitlement key from: https://myibm.ibm.com/products-services/containerlibrary, copy and paste the key to this variable"
}
variable "entitled_registry_user_email" {
  description = "Required: Email address of the user owner of the Entitled Registry Key"
}

// IBM Cloud API Key
variable "ic_api_key" {
  description = "IBM Cloud API Key"
}

// Cluster Variables
variable "region" {
  default     = "us-south"
  description = "Region to provision the Openshift cluster. List all available regions with: ibmcloud regions"
}

variable "resource_group" {
  default     = "Default"
  description = "Resource Group in your account to host the cluster. List all available resource groups with: ibmcloud resource groups"
}

variable "cluster_id" {
  default     = ""
  description = "Optional: if you have an existing cluster to install the Cloud Pak, use the cluster ID or name. If left blank, a new Openshift cluster will be provisioned"
}

// if set to false, cluster is on Classic Infrastructure
variable "on_vpc" {
  default     = false
  description = "Required: Cluster type to be installed on, 'true' = VPC, 'false' = Classic"
}

// Only required if cluster id is not specified
variable "project_name" {
  description = "Only required if cluster_id is not specified. The project_name is combined with environment to name the cluster. The cluster name will be '{project_name}-{environment}-cluster' and all the resources will be tagged with 'project:{project_name}'"
}

// Only required if cluster id is not specified
variable "environment" {
  default     = "dev"
  description = "Only required if cluster_id is not specified. The environment is combined with project_name to name the cluster. The cluster name will be '{project_name}-{environment}-cluster' and all the resources will be tagged with 'env:{environment}'"
}

// Only required if cluster id is not specified
variable "owner" {
  description = "Only required if cluster_id is not specified. Use your user name or team name. The owner is used to label the cluster and other resources with the tag 'owner:{owner}'"
}

// Only required if cluster id is not specified. Flavor will depend on whether classic or vpc
variable "flavors" {
  type        = list(string)
  default     = ["b3c.16x64"]
  description = "Only required if cluster_id is not specified. Array with the flavors or machine types of each the workers group. Classic only takes the first flavor of the list. List all flavors for each zone with: 'ibmcloud ks flavors --zone us-south-1 --provider <classic | vpc-gen2>'. Example: [\"bx2.16x64\", \"mx2.8x64\", \"cx2.4x8\"]"
}

variable "force_delete_storage" {
  default     = true
  description = "If set to true, storage will be deleted with cluster is destroyed"
}

// Only required if cluster id is not specified and 'on_vpc=false'
variable "datacenter" {
  default     = ""
  description = "Classic Only: Only required if cluster_id is not specified. Datacenter or Zone in the region to provision the cluster. List all available zones with: 'ibmcloud ks zone ls --provider classic'. Only required if cluster id not specified and on_vpc=false."
}

// VLAN's numbers variables on the datacenter, they are here until the
// permissions issues is fixed on Humio account
// Only required if cluster id is not specified and 'on_vpc=false'
variable "private_vlan_number" {
  default     = ""
  description = "Classic Only: Only required if cluster_id is not specified. Private VLAN assigned to your zone. List available VLANs in the zone: 'ibmcloud ks vlan ls --zone <datacenter>', make sure the the VLAN type is private and the router begins with bc. Use the ID or Number. Only required if cluster id not specified and on_vpc=false."
}
variable "public_vlan_number" {
  default     = ""
  description = "Classic Only: Only required if cluster_id is not specified. Public VLAN assigned to your zone. List available VLANs in the zone: 'ibmcloud ks vlan ls --zone <datacenter>', make sure the the VLAN type is public and the router begins with fc. Use the ID or Number. Only required if cluster id not specified and on_vpc=false."
}

// Only required if cluster id is not specified and 'on_vpc=true'
variable "vpc_zone_names" {
  type        = list(string)
  default     = ["us-south-1"]
  description = "VPC Only: Only required if cluster_id is not specified. Zones in the IBM Cloud VPC region to provision the cluster. List all available zones with: 'ibmcloud ks zone ls --provider vpc-gen2'. Only required if cluster id not specified and on_vpc=true."
}

// ROKS Module : Local Variables and constants
locals {
  workers_count              = [4]
  roks_version               = "4.6"
  kubeconfig_dir             = "./.kube/config"
  entitled_registry_key_file = "./entitlement.key"
}
