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
export L1_RPC=https://eth-sepolia.g.alchemy.com/v2/6nteJ3OMAU94CraTospqlHGy0wqz2Eu2
export L2_RPC=https://rpc.cardona.zkevm-rpc.com
export L1_FORK=http://localhost:8001
export L2_FORK=http://localhost:8101
```

- anvil fork commands
```
anvil --fork-url $L1_RPC --chain-id 11155111 --port 8001
anvil --fork-url $L2_RPC --chain-id 2442 --port 8101
```

## 1. BRIDGE/CLAIM ASSET

### run on fork
- bridge asset
```
forge script script/BridgeClaimScript.s.sol:BridgeAsset --evm-version shanghai --fork-url $L1_FORK --broadcast -vvvv
```

- claim asset
```
forge script script/BridgeClaimScript.s.sol:ClaimAsset --evm-version shanghai --fork-url $L2_FORK --broadcast -vvvv
```

### run on testnet
- bridge asset
```
forge script script/BridgeClaimScript.s.sol:BridgeAsset --evm-version shanghai --rpc-url $L1_RPC --broadcast -vvvv
```
> https://sepolia.etherscan.io/tx/0x6a566c598db629994df34d6133eaa27635c0535bd484ffc8837e62ea97bf0646
> https://proof-generator.polygon.technology/api/zkevm/cardona/bridge?net_id=0&deposit_cnt=5806
> https://proof-generator.polygon.technology/api/zkevm/cardona/merkle-proof?deposit_cnt=5806&net_id=0

- claim asset
```
forge script script/BridgeClaimScript.s.sol:ClaimAsset --evm-version shanghai --rpc-url $L2_RPC --broadcast -vvvv
```
> https://explorer-ui.cardona.zkevm-rpc.com/tx/0x4e615190ad7c23400bc7ef9a5f546852a3047d5651f2111c9cbd8d18c1feab32


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

- [Sepolia USDC](https://sepolia.etherscan.io/address/0x1c7D4B196Cb0C7B01d743Fbc6116a902379C7238)
- [Sepolia USDC Faucet](https://faucet.circle.com/)
- [Sepolia LxLy Bridge](https://sepolia.etherscan.io/address/0x528e26b25a34a4A5d0dbDa1d57D318153d2ED582)
- Sepolia L1Escrow - TODO: deploy

- [Cardona LxLy Bridge](https://explorer-ui.cardona.zkevm-rpc.com/address/0x528e26b25a34a4A5d0dbDa1d57D318153d2ED582)
- [Cardona bwUSDC](https://explorer-ui.cardona.zkevm-rpc.com/address/0x150aE9614A43361775D9D3A006f75CCc558B598F)
- Cardona USDC.e - TODO: deploy
- Cardona ZkMinterBurner - TODO: deploy
- Cardona NativeConverter - TODO: deploy
- Cardona BridgeAndCall - TODO: deploy

- demo script

### instructions

0. 0xb67826C2176682Fd3Ae3e31A561fc4b9fb012225 (deployer), 0xf36aFDe6aE535D4445A17D2B63841FF34cF6C52b (admin)

1. deploy usdce to cardona
```
forge script script/DeployUSDCe.s.sol:DeployUSDCe --fork-url ${L2_FORK} -vvvvv --legacy --broadcast
```

```
forge script script/DeployUSDCe.s.sol:DeployUSDCe --fork-url ${L2_RPC} -vvvvv --legacy --broadcast
```

2. deploy lxly to sepolia+cardona

3. initialize cardona usdce 

4. initialize lxly in sepolia+cardona

5. deploy bridge and call
