# AGGLAYER DEMOS

## Table of Contents

### Demos

- [L1 -> L2](#l1-to-l2)

  - [Bridge USDC from L1 and deposit into KEOM](#deposit-l1-token-to-l2-keom)
  - [Bridge USDC from L1 and swap for AggLayerToken](#swap-l1-usdc-for-l2-agglayertoken)
  - [Bridge USDC from L1 and convert to USDC.e (instead of Bridge-Wrapped USDC)](#bridge-l1-usdc-for-l2-usdc.e)

- [L2 -> L2](#l2-to-l2)

- [L1 -> L2 -> L1](#l1-to-l2-to-l2)

- [L1 -> L2 -> L2 -> L1](#l1-to-l2-to-l2-to-l1)

### RPCs

| Network         | RPC                               | Chain Id | Explorer                                 | Currency |
| --------------- | --------------------------------- | -------- | ---------------------------------------- | -------- |
| Sepolia         | https://1rpc.io/sepolia           | 11155111 | https://sepolia.etherscan.io             | ETH      |
| ZkEVM Cardona   | https://rpc.cardona.zkevm-rpc.com | 2442     | https://cardona-zkevm.polygonscan.com    | ETH      |
| Astar zKyoto    | https://rpc.startale.com/zkyoto   | 6038361  | https://zkyoto.explorer.startale.com/    | ETH      |
| X Layer testnet | https://testrpc.xlayer.tech       | 195      | https://www.okx.com/explorer/xlayer-test | OKB      |

### Contracts

| Contract              | Sepolia (network id 0)                     | Cardona (network id 1)                     | zKyoto (network id 2)                      | XLayer Testnet |
| --------------------- | ------------------------------------------ | ------------------------------------------ | ------------------------------------------ | -------------- |
| LxLy Bridge           | 0x528e26b25a34a4A5d0dbDa1d57D318153d2ED582 | 0x528e26b25a34a4A5d0dbDa1d57D318153d2ED582 | 0x528e26b25a34a4A5d0dbDa1d57D318153d2ED582 | TODO           |
| BridgeExtension       | 0x2311BFA86Ae27FC10E1ad3f805A2F9d22Fc8a6a1 | 0x2311BFA86Ae27FC10E1ad3f805A2F9d22Fc8a6a1 | 0x2311BFA86Ae27FC10E1ad3f805A2F9d22Fc8a6a1 | TODO           |
| MultiCall             |                                            | 0x9A383EE14F14128CE21E0cAB3023d27b739835b6 | 0xd189584dc079ce08DB854F17ab125ffda6128DfC |                |
|                       |                                            |                                            |                                            |                |
| USDC                  | 0x1c7D4B196Cb0C7B01d743Fbc6116a902379C7238 | 0xc1EF3FC60d6CfC83fe58Fd5f48aB75A20b2518C1 | TODO                                       | TODO           |
| FakeAggLayerToken     | n/a                                        | 0x88342beb50513c9994696c1dadeedad5e8b763df | 0xaf154A248d8C4061b728F49795065C0CD847BA3C | TODO           |
|                       |                                            |                                            |                                            |                |
| (bw)USDC              |                                            | 0x150aE9614A43361775D9D3A006f75CCc558B598F | 0x150aE9614A43361775D9D3A006f75CCc558B598F | TODO           |
| (bw)FakeAggLayerToken |                                            | TODO                                       | 0xA239f92e2d4356b26118A0Cfb1d515C5C5AC5f16 |                |
|                       |                                            |                                            |                                            |                |
| L1Escrow (Cardona)    | 0x7242023A8C682A1B67376C82B36Fb49e098199E4 | n/a                                        | n/a                                        | n/a            |
| L1Escrow (zKyoto)     |                                            | n/a                                        | n/a                                        | n/a            |
| L1Escrow (XLayer)     |                                            | n/a                                        | n/a                                        | n/a            |
| MinterBurner          | n/a                                        | 0x1fF8889219DdF5Fc867635716AEE2F4C9F21f980 | TODO                                       | TODO           |
| NativeConverter (old) | n/a                                        | 0x4D758bD4CE9F7ed1e03AdE50f1E2ef83c477113F | TODO                                       | TODO           |
|                       |                                            |                                            |                                            |                |
| FakeQuickSwap         | n/a                                        | 0x820bf8c6Afc30c7934071779C3e2b175a15C3419 | 0xf43Fc6ae7eed237aB6d58fa2F4fB45d84C2Ff483 | TODO           |
| Fake kUSDC            | n/a                                        | TODO                                       | TODO                                       | TODO           |
| Fake kbwAGG           | n/a                                        | TODO                                       | 0x082b1110e5A9068dBfC654C54A23C4C10F23E9b2 | TODO           |
|                       |                                            |                                            |                                            |                |

#### Values Used for Deployment / Configuration

| Role        | Address                                                                                                                                    |
| ----------- | ------------------------------------------------------------------------------------------------------------------------------------------ |
| deployer    | [0xb67826C2176682Fd3Ae3e31A561fc4b9fb012225](https://explorer-ui.cardona.zkevm-rpc.com/address/0xb67826C2176682Fd3Ae3e31A561fc4b9fb012225) |
| owner/admin | [0xf36aFDe6aE535D4445A17D2B63841FF34cF6C52b](https://explorer-ui.cardona.zkevm-rpc.com/address/0xf36aFDe6aE535D4445A17D2B63841FF34cF6C52b) |

### Helpers

- Mint AggLayerToken

```
export RPC=https://rpc.cardona.zkevm-rpc.com
cast send --rpc-url ${RPC} -i --legacy 0x88342beb50513c9994696c1dadeedad5e8b763df "mint(address,uint256)" 0xb67826C2176682Fd3Ae3e31A561fc4b9fb012225 1000000000000000000000000
```

- Call native converter

```
export RPC=https://rpc.cardona.zkevm-rpc.com

# convert (bwUSDC -> USDC)
cast send --rpc-url ${RPC} -i --legacy bwUSDC "approve(address,uint256)" 0x4D758bD4CE9F7ed1e03AdE50f1E2ef83c477113F 2000000
cast send --rpc-url ${RPC} -i --legacy 0x4D758bD4CE9F7ed1e03AdE50f1E2ef83c477113F "convert(address,uint256,bytes)" 0xb67826C2176682Fd3Ae3e31A561fc4b9fb012225 2000000 0x

# convert (USDC -> bwUSDC)
cast send --rpc-url ${RPC} -i --legacy 0xc1EF3FC60d6CfC83fe58Fd5f48aB75A20b2518C1 "approve(address,uint256)" 0x4D758bD4CE9F7ed1e03AdE50f1E2ef83c477113F 2000000
cast send --rpc-url ${RPC} -i --legacy 0x4D758bD4CE9F7ed1e03AdE50f1E2ef83c477113F "deconvert(address,uint256,bytes)" 0xb67826C2176682Fd3Ae3e31A561fc4b9fb012225 2000000 0x
```

- Find a Bridge Wrapped Address

```
export RPC=https://rpc.cardona.zkevm-rpc.com
cast call --rpc-url ${RPC} 0x528e26b25a34a4A5d0dbDa1d57D318153d2ED582 "precalculatedWrapperAddress(uint32,address,string,string,uint8)" 1 0x88342beb50513c9994696c1dadeedad5e8b763df "Aggregation Layer Token" "AGG" 18
```

## 0. SETUP

### CONTRACT DEPLOYMENT

```
export L1_RPC=
export L2_RPC=
```

#### USDC.e

1. Deploy USDC.e contracts to L2

```
forge script script/setup/USDCe.s.sol:DeployUSDCe --rpc-url ${L2_RPC} -vvvvv --legacy --broadcast
```

2. [Deploy and initialize USDC-LxLy](#usdc-lxly)

3. Initialize USDC.e

```
forge script script/setup/USDCe.s.sol:InitUSDCe --rpc-url ${L2_RPC} -vvvvv --legacy --broadcast
```

#### USDC-LxLy

1. Deploy L1Escrow to L1

```
forge script script/setup/USDCLxLy.s.sol:DeployL1 --rpc-url ${L1_RPC} -vvvv --legacy --broadcast
```

2. Deploy MinterBurner+NativeConverter to L2

```
forge script script/setup/USDCLxLy.s.sol:DeployL2 --rpc-url ${L2_RPC} -vvvv --legacy --broadcast
```

3. set values in `.env` for `ADDRESS_L1_ESCROW_PROXY`, `ADDRESS_ZK_MINTER_BURNER_PROXY`, `ADDRESS_NATIVE_CONVERTER_PROXY`

4. Initialize L1Escrow

```
forge script script/setup/USDCLxLy.s.sol:InitL1 --rpc-url ${L1_RPC} -vvvv --legacy --broadcast
```

5. Initialize MinterBurner+NativeConverter

```
forge script script/setup/USDCLxLy.s.sol:InitL2 --rpc-url ${L2_RPC} -vvvv --legacy --broadcast
```

#### Bridge And Call

Deploy and Initialize BridgeExtension in all chains

```
export RPC=
forge script script/DeployInitBridgeAndCall.s.sol:DeployInitBridgeAndCall --rpc-url ${RPC} -vvvvv --legacy --broadcast
```

#### Helpers

1. Deploy MultiCall

```
export RPC=
forge create ./src/MultiCall.sol:MultiCall --rpc-url ${RPC} --legacy --interactive
```

#### Mocks

1. Deploy a FakeQuickSwap to L2

```
export RPC=
forge create ./src/FakeQuickSwap.sol:FakeQuickSwap --rpc-url ${RPC} --legacy --interactive
```

2. Deploy a FakeKEOM to L2

```
export RPC=https://rpc.cardona.zkevm-rpc.com
forge create --rpc-url ${RPC} ./src/FakeKEOM.sol:FakeKEOM --constructor-args "KEOM USDC Market" "KUSDC" 0x150aE9614A43361775D9D3A006f75CCc558B598F --legacy --interactive

export RPC=https://rpc.startale.com/zkyoto
forge create --rpc-url ${RPC} ./src/FakeKEOM.sol:FakeKEOM --constructor-args "KEOM bwAggLayerToken Market" "KbwAGG" 0xA239f92e2d4356b26118A0Cfb1d515C5C5AC5f16 --legacy --interactive
```

## 1. DEMOS

TODO: excalidraw the demos

### L1 to L2

#### Deposit L1 Token to L2 KEOM

- run bridgeAndCall to L2 KEOM
- claim asset, claim message
- check balance

#### Swap L1 USDC for L2 AggLayerToken

- run bridgeAndCall to L2 QuickSwap for AggLayerToken
- claim asset, claim message
- check balance

#### Bridge L1 USDC for L2 USDC.e

- run bridgeAndCall to L2 Native Converter
- claim asset, claim message
- check balance

### L2 to L2

#### Deposit Lx AggLayerToken to Ly KEOM

```
// SETUP
export RPC=https://rpc.cardona.zkevm-rpc.com
export DEPLOYER_PRIVATE_KEY=
export ADDRESS_BRIDGE_EXTENSION=0x2311BFA86Ae27FC10E1ad3f805A2F9d22Fc8a6a1
export ADDRESS_LX_AGG=0x88342beb50513c9994696c1dadeedad5e8b763df
export ADDRESS_LY_AGG_BW=0xA239f92e2d4356b26118A0Cfb1d515C5C5AC5f16
export ADDRESS_LY_KAGG_BW=0x082b1110e5A9068dBfC654C54A23C4C10F23E9b2
export AMOUNT_IN_DECIMALS=8000000000000000000000
export ADDRESS_DEPLOYER=0xb67826C2176682Fd3Ae3e31A561fc4b9fb012225
export LY_NETWORK_ID=2
export ADDRESS_LY_MULTICALL=0xd189584dc079ce08DB854F17ab125ffda6128DfC

// Bridge Cardona AGG to zKyoto (bwAGG) and call deposit to corresponding KEOM market
forge script script/demos/BridgeAndDepositToKEOM.s.sol:AGG --rpc-url ${RPC} -vvvv --legacy
forge script script/demos/BridgeAndDepositToKEOM.s.sol:AGG --rpc-url ${RPC} -vvvv --legacy --broadcast

// Update the claim script with the token, tx hash, and networks
script/claim.js

// Claim the message
node script/claim.js
```

### L1 to L2 to L1

TODO:

### L1 to L2 to L2 to L1

TODO:
