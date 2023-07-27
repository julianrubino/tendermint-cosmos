## Tendermint + Cosmos

In this example, we will be creating a cluster of VMs, to deploy a chain using Tendermint with a Cosmos SDK module running multiple validators.

##### Create the VMs where we will be running our blockchain

Go to the terraform folder and follow the README.md instructions to create VMs in Digital Ocean.

After creating the VMs we should have something like the following image:

![alt text](https://s12.gifyu.com/images/ScHwj.png "DO Droplets created")

##### Create the node files with Tendermint for the droplets configuration

```
tendermint testnet
```

This will create the node directories with the node files in a folder called mytestnet.

##### Configure the droplets with the node files

1. Create the Unit file, tendermint user and group, also give specific permission:

```
ansible-playbook -i inventory/digital_ocean.py -l composablenet install.yml
```

2. Configure the node files and install the binary in the droplets (you should generate the binary downloading the tendermint repo and running make build-linux):
```
ansible-playbook -i inventory/digital_ocean.py -l composablenet config.yml -e BINARY=<PATH_TO_TENDERMINT_BINARY> -e CONFIGDIR=<PATH_TO_NODE_FILES>
```
