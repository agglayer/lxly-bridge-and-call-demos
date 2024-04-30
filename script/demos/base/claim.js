const dotenv = require('dotenv')
const path = require('path');
dotenv.config({
    path: path.join(__dirname, '.env')
});

const { LxLyClient, use, setProofApi, service } = require('@maticnetwork/lxlyjs');
const { Web3ClientPlugin } = require('@maticnetwork/maticjs-web3');
const HDWalletProvider = require('@truffle/hdwallet-provider');

use(Web3ClientPlugin)

const getLxLyClient = async () => {
    const privateKey = process.env.DEPLOYER_PRIVATE_KEY;
    const deployer = process.env.ADDRESS_DEPLOYER;
    const bridge = process.env.ADDRESS_BRIDGE || "0x528e26b25a34a4A5d0dbDa1d57D318153d2ED582"; // testnet bridge

    const client = new LxLyClient();
    await client.init({
        log: true,
        network: "testnet",
        providers: {
            0: {
                provider: new HDWalletProvider([privateKey], "https://1rpc.io/sepolia"),
                configuration: {
                    bridgeAddress: bridge,
                    isEIP1559Supported: true
                },
                defaultConfig: {
                    from: deployer
                }
            },
            1: {
                provider: new HDWalletProvider([privateKey], "https://rpc.cardona.zkevm-rpc.com"),
                configuration: {
                    bridgeAddress: bridge,
                    isEIP1559Supported: false
                },
                defaultConfig: {
                    from: deployer
                }
            },
            2: {
                provider: new HDWalletProvider([privateKey], "https://rpc.startale.com/zkyoto"),
                configuration: {
                    bridgeAddress: bridge,
                    isEIP1559Supported: false
                },
                defaultConfig: {
                    from: deployer
                }
            }
        }
    });

    setProofApi("https://bridge-api-testnet-dev.polygon.technology/");

    return client;
}

const claimMessageHelper = async (client, transactionHash, sourceNetworkId, targetNetworkId, option) => {
    return client.bridgeUtil.buildPayloadForClaim(
        transactionHash, sourceNetworkId, option.isRefuel
    ).then((payload) => {
        return client.bridges[targetNetworkId].claimMessage(
            payload.smtProof,
            payload.smtProofRollup,
            payload.globalIndex,
            payload.mainnetExitRoot,
            payload.rollupExitRoot,
            payload.originNetwork,
            payload.originTokenAddress,
            payload.destinationNetwork,
            payload.destinationAddress,
            payload.amount,
            payload.metadata,
            option
        );
    });
}

const execute = async (SOURCE_NETWORK_ID, TARGET_NETWORK_ID, BRIDGED_ASSET_ADDR, BRIDGED_TX_HASH, claimAsset = true, claimMessage = true) => {
    console.log("gm!");
    const client = await getLxLyClient();
    console.log("lxly client initialized");

    if (claimAsset) {
        // CLAIM THE ASSET
        const asset = client.erc20(BRIDGED_ASSET_ADDR, TARGET_NETWORK_ID);
        console.log("got the token", asset);

        console.log("going to claimAsset...");
        const tx1 = await asset.claimAsset(BRIDGED_TX_HASH, SOURCE_NETWORK_ID, { isRefuel: false });
        console.log("claim asset tx sent", tx1);
        console.log("txHash", await tx1.getTransactionHash());
        console.log("receipt", await tx1.getReceipt());
    }

    if (claimMessage) {
        // CLAIM THE MESSAGE
        console.log("going to claimMessage...");
        const tx2 = await claimMessageHelper(client, BRIDGED_TX_HASH, SOURCE_NETWORK_ID, TARGET_NETWORK_ID, { isRefuel: true }); // set to true for lxly to get the 2nd msg
        console.log("claim message tx sent!", tx2);
        console.log("txHash", await tx2.getTransactionHash());
        console.log("receipt", await tx2.getReceipt());
    }
}

module.exports = { execute };