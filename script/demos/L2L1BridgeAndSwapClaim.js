const { execute } = require('./base/claim.js');

// export DEPLOYER_PRIVATE_KEY=
// export ADDRESS_DEPLOYER=
// export ADDRESS_BRIDGE=
// 
// node script/demos/L2L2BridgeAndDepositClaim.js
const SOURCE_NETWORK_ID = 2;
const TARGET_NETWORK_ID = 0;
const BRIDGED_ASSET_ADDR = 0xb89a7eb06f277c9105a91e523357972384c8a27d; // NOTE: TOKEN address in TARGET network
const BRIDGED_TX_HASH = "0xcee6319670772edd11962c9840e87b7ef8e168f764655b771a858e34927642ac";

execute(SOURCE_NETWORK_ID, TARGET_NETWORK_ID, BRIDGED_ASSET_ADDR, BRIDGED_TX_HASH).then(() => {
    // n/a
}).catch(err => {
    console.error("err", err);
}).finally(_ => {
    process.exit(0);
});
