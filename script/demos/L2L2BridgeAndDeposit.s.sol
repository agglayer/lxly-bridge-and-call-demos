// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import "forge-std/console.sol";
import {Script} from "forge-std/Script.sol";
import {IERC20} from "forge-std/interfaces/IERC20.sol";

import {BridgeExtension} from "@bridge-and-call/BridgeExtension.sol";

contract AGG is Script {
    function run() public {
        vm.startBroadcast(vm.envUint("DEPLOYER_PRIVATE_KEY"));

        // the bridge extension that implements bridgeAndCall
        address bridgeExtension = vm.envAddress("ADDRESS_BRIDGE_EXTENSION");

        // the token we're bridging
        address lxAGG = vm.envAddress("ADDRESS_LX_AGG");
        // the contract that gets called
        address lyKeomHelper = vm.envAddress("ADDRESS_LY_KEOM_HELPER");

        // arguments to KEOMHelper.depositAndTransfer(....) - these are values in Ly
        address lyAGGbw = vm.envAddress("ADDRESS_LY_AGG_BW"); // the token to deposit
        address lyKAGGbw = vm.envAddress("ADDRESS_LY_KAGG_BW"); // the keom market (specific for the token)
        uint256 amount = vm.envUint("AMOUNT_IN_DECIMALS"); // the amount
        address receiver = vm.envAddress("ADDRESS_DEPLOYER"); // the receiver of the kTokens

        // this happens in Lx
        // allow bridge extension to spend the lxAGG for bridge and call
        IERC20(lxAGG).approve(address(bridgeExtension), amount);
        // do the bridge and call
        BridgeExtension(bridgeExtension).bridgeAndCall(
            lxAGG, // token to bridge (in Lx)
            amount, // amount to bridge
            "", // not using permit
            uint32(vm.envUint("LY_NETWORK_ID")), // destination network id
            lyKeomHelper, // contract to call (in Ly)
            receiver, // fallback address
            abi.encodeWithSelector( // the call data
                bytes4(keccak256("depositAndTransfer(address,uint256,address,address)")),
                lyAGGbw,
                amount,
                lyKAGGbw,
                receiver
            ),
            true
        );

        vm.stopBroadcast();
    }
}
