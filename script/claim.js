const dotenv = require('dotenv')
const path = require('path');
const env = dotenv.config({
    path: path.join(__dirname, '.env')
});

const { LxLyClient, use, setProofApi, service } = require('@maticnetwork/lxlyjs');
const { Web3ClientPlugin } = require('@maticnetwork/maticjs-web3');
const HDWalletProvider = require('@truffle/hdwallet-provider');

use(Web3ClientPlugin)

const getLxLyClient = async () => {
    const privateKey = process.env.DEPLOYER_PRIVATE_KEY;
    const deployer = process.env.ADDRESS_DEPLOYER;
    const bridge = "0x528e26b25a34a4A5d0dbDa1d57D318153d2ED582";

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
        // console.log("got the payload", payload);

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

const execute = async () => {
    const SOURCE_NETWORK_ID = 1;
    const TARGET_NETWORK_ID = 2;
    const BRIDGED_ASSET_ADDR = 0xA239f92e2d4356b26118A0Cfb1d515C5C5AC5f16; // NOTE: TOKEN address in TARGET network
    const BRIDGED_TX_HASH = "0xdd40391969de74dd9c09d2bbae3724a8b4608f67dfa2518d8789486bcff77981";

    console.log("gm!");
    const client = await getLxLyClient();
    console.log("lxly client initialized");

    // const user = "0xb67826C2176682Fd3Ae3e31A561fc4b9fb012225";
    // const cardonaAggTokenBalance = await client.erc20("0x88342beb50513c9994696c1dadeedad5e8b763df", 1).getBalance(user);
    // console.log("cardona agg token balance", cardonaAggTokenBalance);

    // -------------- DEBUG
    // const provider = client.client.providers["1"].provider;
    // const rx = await provider.getTransactionReceipt("0xb6046e1d5e2f16e9d159fcc61353e083e7148eb5a6220d28e553c0532ad29ada");
    // // console.log(rx);

    // const logs = rx.logs.filter(log => log.topics[0].toLowerCase() === "0x501781209a1f8899323b96b4ef08b168df93e0a90c673d1e4cce39366cb62f9b");
    // // console.log("logs", logs);

    // const data = logs[0].data; // or [1] ?
    // // console.log("data", data);

    // const decodedData = await client.bridgeUtil.decodedBridgeData_(data, 1);
    // console.log("decoded data", decodedData);

    // const proof = await client.bridgeUtil.getProof_(1, decodedData.depositCount);
    // console.log("proof", proof);

    // console.log(await service.network.getMerkleProof(1, 7279));
    // --------------

    // CLAIM THE ASSET
    const bwAggToken = client.erc20(BRIDGED_ASSET_ADDR, TARGET_NETWORK_ID);
    console.log("got the token", bwAggToken);

    console.log("going to claimAsset...");
    const tx1 = await bwAggToken.claimAsset(BRIDGED_TX_HASH, SOURCE_NETWORK_ID, { isRefuel: false });
    console.log("claim asset tx sent", tx1);
    console.log("txHash", await tx1.getTransactionHash());
    console.log("receipt", await tx1.getReceipt());

    // CLAIM THE MESSAGE
    console.log("going to claimMessage...");
    const tx2 = await claimMessageHelper(client, BRIDGED_TX_HASH, SOURCE_NETWORK_ID, TARGET_NETWORK_ID, { isRefuel: true }); // set to true for lxly to get the 2nd msg
    console.log("claim message tx sent!", tx2);
    console.log("txHash", await tx2.getTransactionHash());
    console.log("receipt", await tx2.getReceipt());

    // TODO: get keom balance
}

// export DEPLOYER_PRIVATE_KEY=
// export ADDRESS_DEPLOYER=
// export ADDRESS_BRIDGE=
// 
// node script/claim.js
execute().then(() => {
    // n/a
}).catch(err => {
    console.error("err", err);
}).finally(_ => {
    process.exit(0);
});
