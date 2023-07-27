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

### Logging

For the logging, I have implemented Filebeat in the nodes for collecting the Tendermint logs and I'm exporting those logs to Logzio.

### Useful commands

You can make some request to the nodes, f.e:

Get status of the node:
```
curl localhost:26657/status

{"jsonrpc":"2.0","id":-1,"result":{"node_info":{"protocol_version":{"p2p":"8","block":"11","app":"1"},"id":"1c11b508523a3ec2064886a6e4ab44956d3239a2","listen_addr":"tcp://0.0.0.0:26656","network":"chain-U3zsOF","version":"unreleased-main-35581cf54ec436b8c37fabb43fdaa3f48339a170","channels":"40202122233038606100","moniker":"node3","other":{"tx_index":"on","rpc_address":"tcp://127.0.0.1:26657"}},"sync_info":{"latest_block_hash":"BA07E51BB88A6B9D79BE79411CADA1E3159CBFF8B9030FAD02B2AB5BCB9310A9","latest_app_hash":"0000000000000000","latest_block_height":"3792","latest_block_time":"2023-07-28T02:28:26.58792789Z","earliest_block_hash":"026C92AF9C2730A34326AE3FFB4495D7EA5F2BDA5C6EDC71BAD971710EC9C3FF","earliest_app_hash":"","earliest_block_height":"1","earliest_block_time":"2023-07-27T15:24:04.908616Z","catching_up":false},"validator_info":{"address":"DB1673E29236527884FFEF8F446E32CFBA58BE47","pub_key":{"type":"tendermint/PubKeyEd25519","value":"z4foscurl -s 'localhost:26657/broadcast_tx_commit?tx="abcd"'":"1"}}}
```

Committing a transaction:
```
curl -s 'localhost:26657/broadcast_tx_commit?tx="abcd"'

{"jsonrpc":"2.0","id":-1,"result":{"check_tx":{"code":0,"data":null,"log":"","info":"","gas_wanted":"1","gas_used":"0","events":[],"codespace":"","sender":"","priority":"0","mempoolError":""},"deliver_tx":{"code":0,"data":null,"log":"","info":"","gas_wanted":"0","gas_used":"0","events":[{"type":"app","attributes":[{"key":"Y3JlYXRvcg==","value":"Q29zbW9zaGkgTmV0b3dva28=","index":true},{"key":"a2V5","value":"YWJjZA==","index":true},{"key":"aW5kZXhfa2V5","value":"aW5kZXggaXMgd29ya2luZw==","index":true},{"key":"bm9pbmRleF9rZXk=","value":"aW5kZXggaXMgd29ya2luZw==","index":false}]}],"codespace":""},"hash":"88D4266FD4E6338D13B845FCF289579D209C897823B9217DA3E161936F031589","height":"4491"}}
```

Checking the committed transaction:
```
curl -s 'localhost:26657/abci_query?data="abcd"'

{"jsonrpc":"2.0","id":-1,"result":{"response":{"code":0,"log":"exists","info":"","index":"0","key":"YWJjZA==","value":"YWJjZA==","proofOps":null,"height":"5484","codespace":""}}}
```