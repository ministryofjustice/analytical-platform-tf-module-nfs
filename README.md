# Analytical-Platform-tf-module-NFS
Terraform Module to provide storage solution (NFS)

Provisions a NetApp Cloud Manager instance and network configuration

Once a cloud manager instance is present you can then create [Working Environments](https://docs.netapp.com/us-en/occm/task_adding_ontap_cloud.html), add [Kubernetes](https://docs.netapp.com/us-en/occm/task_connecting_kubernetes.html) clusters and setup [TLS](https://docs.netapp.com/us-en/occm/task_installing_https_cert.html) from
the frontend.

### Usage

##### Create a `tfvars` file and ensure values are present

```hcl-terraform
#################
# Vars
#################
vpc_id                  = "vpc-ab65ef21"                         # Existing vpc id to deploy cloud manager into
subnet_name             = "dmz-eu-west-1a"                       # Existing public subnet to deploy cloud manager on to
instance_type           = "t3.medium"                            # Instance type
key_pair                = "key-pair:c8:e2"                       # Name of your key-pair in aws
ansible_provision_file  = "./occm_setup.yaml"                    # Path to ansible playbook file
refresh_token           = ""                                     # Get it from: https://services.cloud.netapp.com/refresh-token
client_id               = "Mu0V1ywgYteI6w1MbD15fKfVIUrNXGWC"     # Application/Client ID in the NetApp Auth0 tenant
portal_user_name        = "your-email@justice.gov.uk"            # Email address of the first admin user.  Note you need to have signed up here first: https://cloud.netapp.com
auth0_domain            = "netapp-cloud-account.auth0.com"       # NetApp's auth0 domain
region                  = "eu-west-1"
profile                 = "production"                           # Name of local aws credentials profile
eip_allocation_id       = "eipalloc-87654321"                    # Elastic IP's allocation ID
cidr_blocks             = [
  "0.0.0.0/0",
]                                                                # CIDR blocks you want to allow to connect to your Cloud Manager
zone_id                 = "ABC123DEF456GH"                       # Route 53 Hosted Zone ID
```

##### Invoke module

```hcl-terraform
module "nfs" {
  source = "github.com/ministryofjustice/analytical-platform-tf-module-nfs"

  vpc_id             = "vpc-zy98vu54"
  refresh_token      = "BrhP45epayjL3Fp1Wa0-5CtLKJ0RvSrPMu6xM2QsaRcEASY"
  cidr               = [
  "10.228.9.1",
  "10.229.8.4",
  ]
}
```

Browse to the Cloud Manager frontend __i.e.__ `occm.mojanalytics.xyz`

```bash
Apply complete! Resources: 17 added, 0 changed, 0 destroyed.

Outputs:

ids = i-0Cd03821c55awq0987
internal_url = nfs-server.mojanalytics.xyz
ip = 39.259.139.29
url = occm.mojanalytics.xyz
```

### Tests

```bash
terraform plan -out tfplan
```

```bash
terraform show -json tfplan | jq . > ./tfjson.json
```
