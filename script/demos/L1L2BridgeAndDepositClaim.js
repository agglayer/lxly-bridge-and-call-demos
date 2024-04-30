const { execute } = require('./base/claim.js');

// export DEPLOYER_PRIVATE_KEY=
// export ADDRESS_DEPLOYER=
// export ADDRESS_BRIDGE=
// 
// node script/demos/L1L2BridgeAndDepositClaim.js
const SOURCE_NETWORK_ID = 0;
const TARGET_NETWORK_ID = 2;
const BRIDGED_ASSET_ADDR = 0x757413d0ae85d44e2aa8adf09b00c19be27346c7; // NOTE: TOKEN address in TARGET network
const BRIDGED_TX_HASH = "0xb4aec7fd524370ba3819e66e2f893a097a277c9a085ea1033de84ad3ba2501a0";

execute(SOURCE_NETWORK_ID, TARGET_NETWORK_ID, BRIDGED_ASSET_ADDR, BRIDGED_TX_HASH, claimAsset = false).then(() => {
    // n/a
}).catch(err => {
    console.error("err", err);
}).finally(_ => {
    process.exit(0);
});
