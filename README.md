# aws_vault_terraform

This terraform script is to spin up a vault instance running on AWS in the default VPC and run the necessary binaries to run vault. 

To get started, first git clone this repo. 

Change the profile_name under the variables.tf to your own AWS profile which is found in ```~/.aws/credentials ```

Do

```
1) Terraform Init
2) terraform plan
3) terraform appy
```

Result: 

you should get a result as below

```

null_resource.example_provisioner (remote-exec): Created symlink from /etc/systemd/system/multi-user.target.wants/vault.service to /etc/systemd/system/vault.service.
null_resource.example_provisioner (remote-exec): ● vault.service - "HashiCorp Vault Service"
null_resource.example_provisioner (remote-exec):    Loaded: loaded (/etc/systemd/system/vault.service; enabled; vendor preset: disabled)
null_resource.example_provisioner (remote-exec):    Active: active (running) since Sun 2020-03-01 10:20:33 UTC; 89ms ago
null_resource.example_provisioner (remote-exec):  Main PID: 3583 (vault)
null_resource.example_provisioner (remote-exec):    CGroup: /system.slice/vault.service
null_resource.example_provisioner (remote-exec):            └─3583 /usr/bin/vault serv...

null_resource.example_provisioner (remote-exec): Mar 01 10:20:33 ip-172-31-20-41.ap-southeast-1.compute.internal systemd[1]: ...
null_resource.example_provisioner (remote-exec): Mar 01 10:20:33 ip-172-31-20-41.ap-southeast-1.compute.internal systemd[1]: ...
null_resource.example_provisioner (remote-exec): Hint: Some lines were ellipsized, use -l to show in full.
null_resource.example_provisioner: Creation complete after 8s (ID: 788706652703102945)

Apply complete! Resources: 2 added, 0 changed, 0 destroyed.

Outputs:

vault_url = 13.229.130.191:8200
```

Scroll over to the vault addess and you should hit the below page

![Image description](https://github.com/leeadh/aws_vault_terraform/blob/master/files/vault.png)

