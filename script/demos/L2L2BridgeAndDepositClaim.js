const { execute } = require('./claim.js');


// export DEPLOYER_PRIVATE_KEY=
// export ADDRESS_DEPLOYER=
// export ADDRESS_BRIDGE=
// 
// node script/demos/L2L2BridgeAndDepositClaim.js
const SOURCE_NETWORK_ID = 1;
const TARGET_NETWORK_ID = 2;
const BRIDGED_ASSET_ADDR = 0xA239f92e2d4356b26118A0Cfb1d515C5C5AC5f16; // NOTE: TOKEN address in TARGET network
const BRIDGED_TX_HASH = "0xdd40391969de74dd9c09d2bbae3724a8b4608f67dfa2518d8789486bcff77981";

execute(SOURCE_NETWORK_ID, TARGET_NETWORK_ID, BRIDGED_ASSET_ADDR, BRIDGED_TX_HASH).then(() => {
    // n/a
}).catch(err => {
    console.error("err", err);
}).finally(_ => {
    process.exit(0);
});
