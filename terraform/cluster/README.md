## Cluster of Digital Ocean droplets (VMs)

##### NOTE: We will not be using a remote backend, so I will be pushing the lock file here too. Ignore this file or remove it before applying.

##### In order to apply these terraform files you should export the following variables.

```export SSH_KEY_FILE="$HOME/.ssh/id_rsa.pub"```

```export DO_API_TOKEN="YOUR_DO_API_TOKEN"```

##### After exporting those variables, you should be able to create a cluster of Droplets in Digital Ocean applying these resources.

##### The command to apply using the exported variables is:

```terraform apply -var DO_API_TOKEN="$DO_API_TOKEN" -var ssh_key="$SSH_KEY_FILE" -var-file=values.tfvars```

You should get an output like the following one:

```
Apply complete! Resources: 6 added, 0 changed, 0 destroyed.

Outputs:

instances = [
  [
    "123456789",
    "987654321",
    "012345678",
    "098765432",
  ],
]
name = "composablenet"
public_ips = [
  [
    "x.x.x.x",
    "x.x.x.x",
    "x.x.x.x",
    "x.x.x.x",
  ],
]
```
