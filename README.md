# AGGLAYER DEMOS

- L1 -> L2 EXAMPLE

  - Bridge USDC from L1 into L2 and call NativeConverter
  - Bridge MATIC from L1 and deposit into KEOM
  - Bridge USDC from L1 and swap to

- L2 -> L2 EXAMPLE

- L1 -> L2 -> L1 EXAMPLE

- L1 -> L2 -> L2 -> L1 EXAMPLE

## 0. SETUP

#### RPCs
```
export L1_RPC=http://localhost:8001
export L2_RPC=http://localhost:8101
export L1_RPC=https://eth-sepolia.g.alchemy.com/v2/<SNIP>
export L2_RPC=https://rpc.cardona.zkevm-rpc.com
```

#### Anvil fork commands
```
anvil --fork-url $L1_RPC --chain-id 11155111 --port 8001
anvil --fork-url $L2_RPC --chain-id 2442 --port 8101
```

#### Sepolia Addresses
- [Sepolia USDC](https://sepolia.etherscan.io/address/0x1c7D4B196Cb0C7B01d743Fbc6116a902379C7238)
- [Sepolia LxLy Bridge](https://sepolia.etherscan.io/address/0x528e26b25a34a4A5d0dbDa1d57D318153d2ED582)
- [Sepolia L1Escrow](https://sepolia.etherscan.io/address/0x7242023A8C682A1B67376C82B36Fb49e098199E4)
- [Sepolia BridgeExtension](https://sepolia.etherscan.io/address/0x549Dd117fD893131C613c23597995f74B5993f05)

#### Cardona Addresses
- [Cardona LxLy Bridge](https://explorer-ui.cardona.zkevm-rpc.com/address/0x528e26b25a34a4A5d0dbDa1d57D318153d2ED582)
- [Cardona bwUSDC](https://explorer-ui.cardona.zkevm-rpc.com/address/0x150aE9614A43361775D9D3A006f75CCc558B598F)
- [Cardona USDC.e](https://explorer-ui.cardona.zkevm-rpc.com/address/0xc1EF3FC60d6CfC83fe58Fd5f48aB75A20b2518C1)
- [Cardona ZkMinterBurner](https://explorer-ui.cardona.zkevm-rpc.com/address/0x1fF8889219DdF5Fc867635716AEE2F4C9F21f980)
- [Cardona NativeConverter](https://explorer-ui.cardona.zkevm-rpc.com/address/0x4D758bD4CE9F7ed1e03AdE50f1E2ef83c477113F)
- [Cardona BridgeExtension](https://explorer-ui.cardona.zkevm-rpc.com/address/0x9BD74Ddb858E3bb98ED951d5cfe0B3e6Fe8DC240)

### Deploy+Init Contracts
- [deployer](https://explorer-ui.cardona.zkevm-rpc.com/address/0xb67826C2176682Fd3Ae3e31A561fc4b9fb012225)
- [owner/admin](https://explorer-ui.cardona.zkevm-rpc.com/address/0xf36aFDe6aE535D4445A17D2B63841FF34cF6C52b)

#### USDCe

- deploy usdce to cardona
```
forge script script/USDCe.s.sol:DeployUSDCe --rpc-url ${L2_RPC} -vvvvv --legacy --broadcast
```

> https://explorer-ui.cardona.zkevm-rpc.com/tx/0xea14c7ffdb4764dee761d5116d823caa0a245bce93faa1a43d0bef235b62c991 # (implementation contract)

> https://explorer-ui.cardona.zkevm-rpc.com/tx/0x5885f55c1322dad4a242b15cb8a9baaf73b2a2fa5e9a9c570605274b9ece4297 # (proxy contract)

- run lxly deployment 👇

> ⏭️ goto next sub-section

- initialize cardona usdce 
```
forge script script/USDCe.s.sol:InitUSDCe --rpc-url ${L2_RPC} -vvvvv --legacy --broadcast
```

> https://explorer-ui.cardona.zkevm-rpc.com/tx/0xd8893190279a6c8148bac3ba5cb947045a8f967bdcf13e04b2d1237065f7cdcf

> https://explorer-ui.cardona.zkevm-rpc.com/tx/0xa6b1246121254a559834ebaf79e845254bf69296408ecade3538c7d15292568e

> https://explorer-ui.cardona.zkevm-rpc.com/tx/0x9a30a5c882e617ace61e9617df473be41b6880ffba617b950848fd2098247639

> https://explorer-ui.cardona.zkevm-rpc.com/tx/0x6ab70d75f02f258a1b51c15b2e51942717aed73c0126df3de30b16b2fdcb046b

> https://explorer-ui.cardona.zkevm-rpc.com/tx/0x7771e2db029927f5c4829edb21b9accd9e1b7306c9fec8a08386a81ff777147b

> https://explorer-ui.cardona.zkevm-rpc.com/tx/0x6649b890294089e2b0be93ad7f1350026a3f7be44903fa5176f33eed69a7ae52


#### LxLy
- deploy L1Escrow to sepolia
```
forge script script/USDCLxLy.s.sol:DeployL1 --rpc-url ${L1_RPC} -vvvv --legacy --broadcast
```

> https://sepolia.etherscan.io/tx/0xc4ff52389832cbbdd621bb12165764280cfed95954ad850a11aa3ecd04d73e17 (implementation contract)

> https://sepolia.etherscan.io/tx/0xe719ab941dfe6c8a12ca4c1e4e5adedec3dcb98b172ee2136c91b096ebfb275a (proxy contract)

- deploy MinterBurner+NativeConverter to cardona
```
forge script script/USDCLxLy.s.sol:DeployL2 --rpc-url ${L2_RPC} -vvvv --legacy --broadcast
```

> https://explorer-ui.cardona.zkevm-rpc.com/tx/0xd5a757633d204a5c700ffab0d302ebfa64b95fdcebfac38f6e4bcbfc05bc920d (implementation contract)

> https://explorer-ui.cardona.zkevm-rpc.com/tx/0x4a2940a7e18c78c6f1ed81b2fabf768199e97e3d78615727525be2cc89e919b0 (proxy contract)

> https://explorer-ui.cardona.zkevm-rpc.com/tx/0x9e4683e50148155ce1fe2475f61e2221313baf3968981adbbfdc26a938697d96 (implementation contract)

> https://explorer-ui.cardona.zkevm-rpc.com/tx/0x245c3525ac8d4b9b6c7435e20673d26acf792877404ea28160c6d3a248e68e0c (proxy contract)

- set values in `.env` for `ADDRESS_L1_ESCROW_PROXY`, `ADDRESS_ZK_MINTER_BURNER_PROXY`, `ADDRESS_NATIVE_CONVERTER_PROXY`

- Init L1Escrow
```
forge script script/USDCLxLy.s.sol:InitL1 --rpc-url ${L1_RPC} -vvvv --legacy --broadcast
```

> https://sepolia.etherscan.io/tx/0x872f634a0e625e3498960bf42551c760db27e9ae900a1db3475b6788b9850530

- Init MinterBurner+NativeConverter
```
forge script script/USDCLxLy.s.sol:InitL2 --rpc-url ${L2_RPC} -vvvv --legacy --broadcast
```

> https://explorer-ui.cardona.zkevm-rpc.com/tx/0x40fa0fbe6f98a667549ac6c7d8eda2f2066d764da5099536659575840eba5e07

> https://explorer-ui.cardona.zkevm-rpc.com/tx/0x0a49c27dd29de2cc946d5fe7409de62614bf859c3c09eebf626899a741d2c995

- go back to USDCe ☝️

#### Bridge and Call

- deploy bridge extension to sepolia
```
forge script script/BridgeAndCall.s.sol:DeployL1 --rpc-url ${L1_RPC} -vvvv --legacy --broadcast
```

> https://sepolia.etherscan.io/tx/0x67ad7f2402a86e9c34891e56f8fb1aa205d9265720a9bf840b08d2acbb8fa15e

- deploy bridge extension to cardona
```
forge script script/BridgeAndCall.s.sol:DeployL2 --rpc-url ${L2_RPC} -vvvv --legacy --broadcast
```

> https://explorer-ui.cardona.zkevm-rpc.com/tx/0x6801328c6936b2afa8dcc93df4591e9dfd6a678de1011113a25446ae42b8e808

- set values in `.env` for `ADDRESS_L1_BRIDGE_EXTENSION`, `ADDRESS_L2_BRIDGE_EXTENSION`

- init l1 bridge extension
```
forge script script/BridgeAndCall.s.sol:InitL1 --rpc-url ${L1_RPC} -vvvv --legacy --broadcast
```

> https://sepolia.etherscan.io/tx/0x8b99e6d0d4ef7076e34de1f9dfe368a4d6bbb073f8e414a026384c7aec350189

- init l2 bridge extension
```
forge script script/BridgeAndCall.s.sol:InitL2 --rpc-url ${L2_RPC} -vvvv --legacy --broadcast
```

> https://explorer-ui.cardona.zkevm-rpc.com/tx/0x2c28b83380f216f832887fe94ea726470bfd6699131360a811cd116639b02924


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

- run bridge and call
```
forge script script/demos/BridgeAndCallNativeConverter.s.sol:BridgeAndCallNativeConverter --evm-version shanghai --rpc-url $L1_RPC -vvvv --broadcast
```

> https://sepolia.etherscan.io/tx/0xa695dfa32d1cc256c624efa4d1afd4a9bb68ae969e5e69b76fec31c0a80c714b

- ~~run asset claimer~~ not needed - autoclaimer will process this bridge
```
forge script script/BridgeClaimScript.s.sol:ClaimAsset --evm-version shanghai --rpc-url $L2_RPC -vvvv --broadcast
```

> https://explorer-ui.cardona.zkevm-rpc.com/tx/0xbe0f1970f0a5f4fc7f15ae67bdd415f3c79df80fe65975a85e48b566a36b5b8b

- run message claimer
```
forge script script/BridgeClaimScript.s.sol:ClaimMessage --evm-version shanghai --legacy --rpc-url $L2_RPC -vvvv --broadcast
```

> https://explorer-ui.cardona.zkevm-rpc.com/tx/0x2ae94baa6317e517b9b2f585fde1e0a9c31f718eed3f7cbb8e276800f9d4efde
