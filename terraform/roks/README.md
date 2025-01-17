# IBM Red Hat OpenShift Managed Cluster Parameters and Installation

## Set up

If running using your local Terraform Client, copy the appropriate `terraform.tfvars.classic` or `terraform.tfvars.vpc` to `terraform.tfvars` and ensure your values are set properly.  
 
## Input Parameters

The Terraform script requires the following list of input variables. Here are some instructions to set their values for Terraform and how to get their values from IBM Cloud. Pay attention to the parameters required for **Classic** vs **VPC**.

| Name | Description  | Default | Required |
| - | - | - | - |
| `on_vpc`               | If `true` provision the cluster on IBM Cloud VPC Gen 2, otherwise provision on IBM Cloud Classic                                                                   | `true`           | No       |
| `enable`               | If set to `false` does not provision the Openshift cluster. Enabled by default  | `true`           | No       | | `on_vpc`               | If `true` provision the cluster on IBM Cloud VPC Gen 2, otherwise provision on IBM Cloud Classic                                                                   | `true`           | No       |
| `region`               | IBM Cloud region to host the cluster. List all available zones with: `ibmcloud is regions` | `us-south`           | No       | 
| `project_name`         | Used to name the cluster with the environment name, like this: `{project_name}-{environment}-cluster`<br />It's also used to label the cluster and other resources  |  | Yes      |
| `owner`                | User name or team name. Used to label the cluster and other resources   |  | Yes      |
| `environment`          | Used to name the cluster with the project name, like this: `{project_name}-{environment}-cluster` | `dev`            | No       |
| `entitlement`          | OCP entitlement. Enter `cloud_pak` if using a Cloud Pak entitlement.  Leave blank if OCP entitlement |              | No       |
| `resource_group`       | Resource Group used to host the cluster. List all available resource groups with: `ibmcloud resource groups`                                                                           | `default`        | No       |
| `roks_version`         | OpenShift version to install. List all available versions: `ibmcloud ks versions`. There is no need to include the suffix `_OpenShift`. The module will append it to install the specified version of OpenShift.  | `4.6`            | No       |
| `datacenter`           | **IBM Cloud Classic** only (`on_vpc` = `false`). This is the Datacenter or Zone in the Region to provision the cluster. List all available zones with: `ibmcloud ks zone ls --provider classic`    | `dal10`          | No       |
| `private_vlan_number`  | **IBM Cloud Classic** only. (`on_vpc` = `false`). Private VLAN assigned to your zone. Make it an empty string to select a private unnamed VLAN or to create new VLAN if there isn't one (i.e. this is the first cluster in the zone). To list available VLANs in the zone: `ibmcloud ks vlan ls --zone <datacenter>`. Make sure the the VLAN type is `private` and the router begins with `bc`. Use the `ID` or `Number` |                  | No       |
| `public_vlan_number`   | **IBM Cloud Classic** only (`on_vpc` = `false`). Public VLAN assigned to your zone. Set to an empty string to select a public unnamed VLAN or to create a new VLAN if there aren't any (i.e. this is the first cluster in the zone). List available VLANs in the zone: `ibmcloud ks vlan ls --zone <datacenter>`. Make sure the the VLAN type is `public` and the router begins with `fc`. Use the `ID` or `Number`    |                  | No       |
| `vpc_zone_names`       | **IBM Cloud VPC Gen 2** only (`on_vpc` = `true`). Array with the sub-zones in the region to create the workers groups. List all the zones with: `ibmcloud ks zone ls --provider vpc-gen2`. Example: `["us-south-1", "us-south-2", "us-south-3"]`   | `["us-south-1"]` | No       |
| `flavors`              | Array with the flavors or machine types of each of the workers.  List all flavors for each zone with: `ibmcloud ks flavors --zone us-south-1 --provider vpc-gen2` or `ibmcloud ks flavors --zone dal10 --provider classic`. On Classic it is only possible to have one worker group, so only list one flavor, i.e. `["b3c.16x64"]`. Example on VPC `["mx2.4x32", "mx2.8x64", "cx2.4x8"]` or `["mx2.4x32"]`  | `["mx2.4x32"]`   | No       |
| `workers_count`        | Array with the amount of workers on each workers group. On Classic it's only possible to have one workers group, so only the first number in the list is taken for the cluster size. Example: `[1, 3, 5]` or `[2]`   | `[2]`            | No       |
| `force_delete_storage` | If set to `true`, force the removal of persistent storage associated with the cluster during cluster deletion. Default value is `false`.                                                             | `false`          | No       |

## Output Parameters

The module returns the following output variables:

| Name       | Description                                             |
| ---------- | ------------------------------------------------------- |
| `endpoint` | The URL of the public service endpoint for your cluster |
| `id`       | The unique identifier of the cluster.                   |
| `name`     | The name of the cluster                                 |

## Validation

If you use the cluster from other terraform code there may be no need to download the kubeconfig file. However, if you plan to use the cluster from the CLI (i.e. `kubectl`) or other application then it's recommended to download it to some directory.

After execution has completed, access the cluster using `kubectl` or `oc`:

```bash
ibmcloud ks cluster config -cluster $(terraform output cluster_id)
kubectl cluster-info
```

## Clean up

When the cluster is no longer needed, run `terraform destroy` if this was created using your local Terraform client with `terraform apply`. 

If this cluster was created using `schematics`, just delete the schematics workspace and specify to delete all created resources.
