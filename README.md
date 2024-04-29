# AGGLAYER DEMOS

## List of Demos

- [L1 -> L2](#l1-to-l2)

  - [TODO: Bridge and Convert](#bridge-l1-usdc-for-l2-usdce)
  - [TODO: Bridge and Deposit](#deposit-l1-token-to-l2-keom)
  - [TODO: Bridge and Swap](#swap-l1-usdc-for-l2-agglayertoken)

- [L2 -> L2](#l2-to-l2)

  - [Bridge and Deposit](#deposit-lx-agglayertoken-to-ly-keom)
  - [TODO: Bridge, Swap, and Return Change](#bridge-swap-and-return-unused)
  - [TODO: Bridge, Swap, Bridge, and Deposit](#bridge-swap-bridge-and-deposit)

- [L1 -> L2 -> L1](#l1-to-l2-to-l2)

  - [TODO: ]()

- [L1 -> L2 -> L2 -> L1](#l1-to-l2-to-l2-to-l1)
  - [TODO: ]()

## Relevant Information

You'll most likely need this info for testing things.

### RPCs

| Network         | RPC                               | Chain Id | Explorer                                 | Currency |
| --------------- | --------------------------------- | -------- | ---------------------------------------- | -------- |
| Sepolia         | https://1rpc.io/sepolia           | 11155111 | https://sepolia.etherscan.io             | ETH      |
| ZkEVM Cardona   | https://rpc.cardona.zkevm-rpc.com | 2442     | https://cardona-zkevm.polygonscan.com    | ETH      |
| Astar zKyoto    | https://rpc.startale.com/zkyoto   | 6038361  | https://zkyoto.explorer.startale.com/    | ETH      |
| X Layer testnet | https://testrpc.xlayer.tech       | 195      | https://www.okx.com/explorer/xlayer-test | OKB      |

### Contracts

| Contract              | Sepolia (network id 0)                     | Cardona (network id 1)                     | zKyoto (network id 2)                              | XLayer Testnet (network id 3) |
| --------------------- | ------------------------------------------ | ------------------------------------------ | -------------------------------------------------- | ----------------------------- |
| LxLy Bridge           | 0x528e26b25a34a4A5d0dbDa1d57D318153d2ED582 | 0x528e26b25a34a4A5d0dbDa1d57D318153d2ED582 | 0x528e26b25a34a4A5d0dbDa1d57D318153d2ED582         | TODO                          |
| BridgeExtension       | 0x2311BFA86Ae27FC10E1ad3f805A2F9d22Fc8a6a1 | 0x2311BFA86Ae27FC10E1ad3f805A2F9d22Fc8a6a1 | 0x2311BFA86Ae27FC10E1ad3f805A2F9d22Fc8a6a1         | TODO                          |
| MultiCall             | TODO                                       | 0x188A500BAdb18E1EBe7ced5D685d5808f13366f7 | 0x2bF80055C826899911690C30489930F7573fF037         | TODO                          |
|                       |                                            |                                            |                                                    |                               |
| USDC                  | 0x1c7D4B196Cb0C7B01d743Fbc6116a902379C7238 | 0xc1EF3FC60d6CfC83fe58Fd5f48aB75A20b2518C1 | TODO                                               | TODO                          |
| FakeAggLayerToken     | 0x2170cc348ae3cfb77cde9c3ca6b279863df7e0bf | 0x88342beb50513c9994696c1dadeedad5e8b763df | 0xaf154A248d8C4061b728F49795065C0CD847BA3C         | TODO                          |
|                       |                                            |                                            |                                                    |                               |
| (bw)USDC              | TODO                                       | 0x150aE9614A43361775D9D3A006f75CCc558B598F | 0x150aE9614A43361775D9D3A006f75CCc558B598F         | TODO                          |
| (bw)FakeAggLayerToken | TODO                                       | TODO                                       | sepolia:0x757413d0ae85d44e2aa8adf09b00c19be27346c7 | TODO                          |
|                       | TODO                                       | TODO                                       | cardona:0xA239f92e2d4356b26118A0Cfb1d515C5C5AC5f16 | TODO                          |
|                       |                                            |                                            |                                                    |                               |
| L1Escrow (Cardona)    | 0x7242023A8C682A1B67376C82B36Fb49e098199E4 | n/a                                        | n/a                                                | n/a                           |
| L1Escrow (zKyoto)     |                                            | n/a                                        | n/a                                                | n/a                           |
| L1Escrow (XLayer)     |                                            | n/a                                        | n/a                                                | n/a                           |
| MinterBurner          | n/a                                        | 0x1fF8889219DdF5Fc867635716AEE2F4C9F21f980 | TODO                                               | TODO                          |
| NativeConverter (old) | n/a                                        | 0x4D758bD4CE9F7ed1e03AdE50f1E2ef83c477113F | TODO                                               | TODO                          |
|                       |                                            |                                            |                                                    |                               |
| FakeQuickSwap         | 0xcc1d701a479979673715285c1ad768fa37b04856 | 0x820bf8c6Afc30c7934071779C3e2b175a15C3419 | 0xf43Fc6ae7eed237aB6d58fa2F4fB45d84C2Ff483         | TODO                          |
| Fake kUSDC            | n/a                                        | TODO                                       | TODO                                               | TODO                          |
| Fake kbwAGG           | n/a                                        | TODO                                       | sepolia:0x37715A4B43Abee5407d2D516a065c38d5A3C3A0E | TODO                          |
|                       | n/a                                        | TODO                                       | cardona:0x082b1110e5A9068dBfC654C54A23C4C10F23E9b2 | TODO                          |
| KEOM Helper           | TODO                                       | 0xDE978991D6756d0980B3435c3d6EB3CF7a4fE3cf | 0x330bEaDD49c8E599442d2B51f02B23a087bf56cc         | TODO                          |
|                       |                                            |                                            |                                                    |                               |

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

- Call USDC Native Converter

```
export RPC=https://rpc.cardona.zkevm-rpc.com

# convert (bwUSDC -> USDC)
cast send --rpc-url ${RPC} -i --legacy bwUSDC "approve(address,uint256)" 0x4D758bD4CE9F7ed1e03AdE50f1E2ef83c477113F 2000000
cast send --rpc-url ${RPC} -i --legacy 0x4D758bD4CE9F7ed1e03AdE50f1E2ef83c477113F "convert(address,uint256,bytes)" 0xb67826C2176682Fd3Ae3e31A561fc4b9fb012225 2000000 0x

# convert (USDC -> bwUSDC)
cast send --rpc-url ${RPC} -i --legacy 0xc1EF3FC60d6CfC83fe58Fd5f48aB75A20b2518C1 "approve(address,uint256)" 0x4D758bD4CE9F7ed1e03AdE50f1E2ef83c477113F 2000000
cast send --rpc-url ${RPC} -i --legacy 0x4D758bD4CE9F7ed1e03AdE50f1E2ef83c477113F "deconvert(address,uint256,bytes)" 0xb67826C2176682Fd3Ae3e31A561fc4b9fb012225 2000000 0x
```

- Find a Bridge Wrapped Address (without bridging)

```
export RPC=https://rpc.cardona.zkevm-rpc.com
cast call --rpc-url ${RPC} 0x528e26b25a34a4A5d0dbDa1d57D318153d2ED582 "precalculatedWrapperAddress(uint32,address,string,string,uint8)" 0 0x2170cc348ae3cfb77cde9c3ca6b279863df7e0bf "Aggregation Layer Token" "AGG" 18
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

1. Deploy a FakeQuickSwap

```
export RPC=https://1rpc.io/sepolia
forge create ./src/FakeQuickSwap.sol:FakeQuickSwap --rpc-url ${RPC} --legacy --interactive
```

2. Deploy a FakeKEOM

```
export RPC=https://rpc.cardona.zkevm-rpc.com
forge create --rpc-url ${RPC} ./src/FakeKEOM.sol:FakeKEOM --constructor-args "KEOM USDC Market" "KUSDC" 0x150aE9614A43361775D9D3A006f75CCc558B598F --legacy --interactive

export RPC=https://rpc.startale.com/zkyoto
forge create --rpc-url ${RPC} ./src/FakeKEOM.sol:FakeKEOM --constructor-args "KEOM bwAggLayerToken Market" "KbwAGG" 0x757413d0ae85d44e2aa8adf09b00c19be27346c7 --legacy --interactive
```

3. Deploy a KEOMHelper

```
export RPC=https://rpc.cardona.zkevm-rpc.com
forge create --rpc-url ${RPC} ./src/KEOMHelper.sol:KEOMHelper --legacy --interactive

export RPC=https://rpc.startale.com/zkyoto
forge create --rpc-url ${RPC} ./src/KEOMHelper.sol:KEOMHelper --legacy --interactive
```

## 1. DEMOS

TODO: excalidraw the demos

### L1 to L2

#### Bridge L1 USDC for L2 USDCe

- run bridgeAndCall to L2 Native Converter
- claim asset, claim message
- check balance

#### Deposit L1 Token to L2 KEOM

- Setup required env vars (examples for Sepolia -> zKyoto)

```
export RPC=https://1rpc.io/sepolia
export DEPLOYER_PRIVATE_KEY=
export ADDRESS_BRIDGE_EXTENSION=0x2311BFA86Ae27FC10E1ad3f805A2F9d22Fc8a6a1
export ADDRESS_LX_TOKEN=0x2170cc348ae3cfb77cde9c3ca6b279863df7e0bf

export ADDRESS_LY_KEOM_HELPER=0x330bEaDD49c8E599442d2B51f02B23a087bf56cc
export ADDRESS_LY_TOKEN_BW=0x757413d0ae85d44e2aa8adf09b00c19be27346c7
export ADDRESS_LY_KTOKEN=0x37715A4B43Abee5407d2D516a065c38d5A3C3A0E
export AMOUNT_IN_DECIMALS=1000000000000000000000
export ADDRESS_DEPLOYER=0xb67826C2176682Fd3Ae3e31A561fc4b9fb012225
export LY_NETWORK_ID=2
```

- Send the bridgeAndCall tx: this bridges $AGG from Cardona to zKyoto ($bwAGG) and calls deposit to the corresponding KEOM market

```
forge script script/demos/L1L2BridgeAndDeposit.s.sol:KEOM --rpc-url ${RPC} -vvvv --legacy --broadcast
```

- Update the claim script with the token, tx hash, and networks

```
EDIT script/demos/L1L2BridgeAndDepositClaim.js
```

- Claim the message

```
node script/demos/L1L2BridgeAndDepositClaim.js
```

Note: You'll need to run `npm install` before using the script for the first time.

#### Swap L1 USDC for L2 AggLayerToken

- run bridgeAndCall to L2 QuickSwap for AggLayerToken
- claim asset, claim message
- check balance

### L2 to L2

#### Deposit Lx AggLayerToken to Ly KEOM

- Setup required env vars (examples for Cardona -> zKyoto)

```
export RPC=https://rpc.cardona.zkevm-rpc.com
export DEPLOYER_PRIVATE_KEY=
export ADDRESS_BRIDGE_EXTENSION=0x2311BFA86Ae27FC10E1ad3f805A2F9d22Fc8a6a1
export ADDRESS_LX_AGG=0x88342beb50513c9994696c1dadeedad5e8b763df
export ADDRESS_LY_KEOM_HELPER=0x330bEaDD49c8E599442d2B51f02B23a087bf56cc
export ADDRESS_LY_AGG_BW=0xA239f92e2d4356b26118A0Cfb1d515C5C5AC5f16
export ADDRESS_LY_KAGG_BW=0x082b1110e5A9068dBfC654C54A23C4C10F23E9b2
export AMOUNT_IN_DECIMALS=8000000000000000000000
export ADDRESS_DEPLOYER=0xb67826C2176682Fd3Ae3e31A561fc4b9fb012225
export LY_NETWORK_ID=2
```

- Send the bridgeAndCall tx: this bridges $AGG from Cardona to zKyoto ($bwAGG) and calls deposit to the corresponding KEOM market

```
forge script script/demos/L2L2BridgeAndDeposit.s.sol:AGG --rpc-url ${RPC} -vvvv --legacy --broadcast
```

- Update the claim script with the token, tx hash, and networks

```
EDIT script/demos/L2L2BridgeAndDepositClaim.js
```

- Claim the message

```
node script/demos/L2L2BridgeAndDepositClaim.js
```

Note: You'll need to run `npm install` before using the script for the first time.

#### Bridge, Swap, and Return Unused

- send the bridge and call tx (for swaping)
- claim the tx 1 (does the swap for new token and sends a bridge tx)
- claim the tx 2

#### Bridge, Swap, Bridge, and Deposit

- TODO

### L1 to L2 to L1

TODO:

### L1 to L2 to L2 to L1

TODO:
