# AGGLAYER DEMOS

- L1 -> L2 EXAMPLE

  - Bridge USDC from L1 into L2 and call NativeConverter
  - Bridge MATIC from L1 and deposit into KEOM
  - Bridge USDC from L1 and swap to

- L2 -> L2 EXAMPLE

- L1 -> L2 -> L1 EXAMPLE

- L1 -> L2 -> L2 -> L1 EXAMPLE

## 0. SETUP

- rpcs
```
export L1_RPC=http://localhost:8001
export L2_RPC=http://localhost:8101
export L1_RPC=https://eth-sepolia.g.alchemy.com/v2/6nteJ3OMAU94CraTospqlHGy0wqz2Eu2
export L2_RPC=https://rpc.cardona.zkevm-rpc.com
```

- anvil fork commands
```
anvil --fork-url $L1_RPC --chain-id 11155111 --port 8001
anvil --fork-url $L2_RPC --chain-id 2442 --port 8101
```

- [Sepolia USDC Faucet](https://faucet.circle.com/)
- [Sepolia USDC](https://sepolia.etherscan.io/address/0x1c7D4B196Cb0C7B01d743Fbc6116a902379C7238)
- [Sepolia LxLy Bridge](https://sepolia.etherscan.io/address/0x528e26b25a34a4A5d0dbDa1d57D318153d2ED582)
- [Sepolia L1Escrow](TODO: deploy)

- [Cardona LxLy Bridge](https://explorer-ui.cardona.zkevm-rpc.com/address/0x528e26b25a34a4A5d0dbDa1d57D318153d2ED582)
- [Cardona bwUSDC](https://explorer-ui.cardona.zkevm-rpc.com/address/0x150aE9614A43361775D9D3A006f75CCc558B598F)
- [Cardona USDC.e](https://explorer-ui.cardona.zkevm-rpc.com/address/)
- [Cardona ZkMinterBurner](TODO: deploy)
- [Cardona NativeConverter](TODO: deploy)
- [Cardona BridgeAndCall](TODO: deploy)

### Deploy+Init Contracts
- [deployer](https://explorer-ui.cardona.zkevm-rpc.com/address/0xb67826C2176682Fd3Ae3e31A561fc4b9fb012225)
- [owner/admin](https://explorer-ui.cardona.zkevm-rpc.com/address/0xf36aFDe6aE535D4445A17D2B63841FF34cF6C52b)

#### USDCe

- deploy usdce to cardona
```
forge script script/USDCe.s.sol:DeployUSDCe --rpc-url ${L2_RPC} -vvvvv --legacy --broadcast
```

> https://explorer-ui.cardona.zkevm-rpc.com/tx/0xbd937682fcfac96249c4d921c547a313ab81d56e6c94aacf77a3d750c33b5232 # (implementation contract)

> https://explorer-ui.cardona.zkevm-rpc.com/tx/0x7652440e10819830b1ed0c8fb6b78b4852e2c1064a5b92e1e8d448cf703417da # (proxy contract)

- run lxly deployment 👇

> ⏭️ goto next sub-section

- initialize cardona usdce 
```
forge script script/USDCe.s.sol:InitUSDCe --rpc-url ${L2_RPC} -vvvvv --legacy --broadcast
```

> TODO

#### LxLy
- deploy L1Escrow to sepolia
```
forge script script/USDCLxLy.s.sol:DeployL1 --rpc-url ${L1_RPC} -vvvv --legacy --broadcast
```

- deploy MinterBurner+NativeConverter to cardona
```
forge script script/USDCLxLy.s.sol:DeployL2 --rpc-url ${L2_RPC} -vvvv --legacy --broadcast
```

- Init L1Escrow
```
forge script script/USDCLxLy.s.sol:InitL1 --rpc-url ${L1_RPC} -vvvv --legacy --broadcast
```

- Init MinterBurner+NativeConverter
```
forge script script/USDCLxLy.s.sol:InitL2 --rpc-url ${L2_RPC} -vvvv --legacy --broadcast
```


#### Bridge and Call

- deploy bridge and call



## 1. BRIDGE/CLAIM ASSET

### run on fork
- bridge asset
```
forge script script/BridgeClaimScript.s.sol:BridgeAsset --evm-version shanghai --rpc-url $L1_RPC --broadcast -vvvv
```

- claim asset
```
forge script script/BridgeClaimScript.s.sol:ClaimAsset --evm-version shanghai --rpc-url $L2_RPC --broadcast -vvvv
```

### run on testnet
- bridge asset
```
forge script script/BridgeClaimScript.s.sol:BridgeAsset --evm-version shanghai --rpc-url $L1_RPC --broadcast -vvvv
```

> https://sepolia.etherscan.io/tx/0x6a566c598db629994df34d6133eaa27635c0535bd484ffc8837e62ea97bf0646 # bridge tx

> https://proof-generator.polygon.technology/api/zkevm/cardona/bridge?net_id=0&deposit_cnt=5806

> https://proof-generator.polygon.technology/api/zkevm/cardona/merkle-proof?deposit_cnt=5806&net_id=0

- claim asset # TODO: to be fixed
```
forge script script/BridgeClaimScript.s.sol:ClaimAsset --evm-version shanghai --rpc-url $L2_RPC --broadcast -vvvv
```
> https://explorer-ui.cardona.zkevm-rpc.com/tx/0x4e615190ad7c23400bc7ef9a5f546852a3047d5651f2111c9cbd8d18c1feab32 # claim tx


### misc
generate the metadata for a bridgeAsset
```
forge script script/BridgeClaimScript.s.sol:EncodeMetadata --evm-version shanghai --rpc-url $L1_RPC
```

decode the bridgeAsset metadata
```
forge script script/BridgeClaimScript.s.sol:DecodeMetadata
```


## L1 -> L2: Bridge USDC from L1 into L2 and call NativeConverter

- demo script

