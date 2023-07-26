### In order to apply these terraform files you should export the following variables.

```export SSH_KEY_FILE="$HOME/.ssh/id_rsa.pub"```

```export DO_API_TOKEN="YOUR_DO_API_TOKEN"```

##### After exporting those variables, you should be able to create a cluster of Droplets in Digital Ocean applying these resources.

##### The command to apply using the exported variables is:

```terraform apply -var DO_API_TOKEN="$DO_API_TOKEN" -var ssh_key="$SSH_KEY_FILE" -var-file=values.tfvars```