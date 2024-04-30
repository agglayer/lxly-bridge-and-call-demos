// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import "forge-std/console.sol";
import {Script} from "forge-std/Script.sol";
import {IERC20} from "forge-std/interfaces/IERC20.sol";

import {BridgeExtension} from "@bridge-and-call/BridgeExtension.sol";

contract BridgeAndSwap is Script {
    function run() public {
        vm.startBroadcast(vm.envUint("DEPLOYER_PRIVATE_KEY"));

        // the bridge extension that implements bridgeAndCall
        address bridgeExtension = vm.envAddress("ADDRESS_BRIDGE_EXTENSION");

        // the token we're bridging
        address lxToken = vm.envAddress("ADDRESS_LX_TOKEN");
        // the contract that gets called (swap helper)
        address lyTarget = vm.envAddress("ADDRESS_LY_TARGET");

        // arguments to the contract
        uint256 swapper = vm.envUint("ADDRESS_LY_SWAPPER"); // the swap router
        address tokenToSell = vm.envAddress("ADDRESS_LY_TOKEN_SELL");
        address tokenToBuy = vm.envAddress("ADDRESS_LY_TOKEN_BUY");
        uint256 amount = vm.envUint("AMOUNT_IN_DECIMALS"); // the amount
        address receiver = vm.envAddress("ADDRESS_DEPLOYER"); // the receiver of the kTokens

        // this happens in Lx
        // allow bridge extension to spend the lxToken for bridge and call
        IERC20(lxToken).approve(address(bridgeExtension), amount);
        // do the bridge and call
        BridgeExtension(bridgeExtension).bridgeAndCall(
            lxToken, // token to bridge (in Lx)
            amount, // amount to bridge
            "", // not using permit
            uint32(vm.envUint("LY_NETWORK_ID")), // destination network id
            lyTarget, // contract to call (in Ly)
            receiver, // fallback address
            abi.encodeWithSelector( // the call data
                bytes4(keccak256("swapAndTransfer(address,address,uint256,address,address)")),
                swapper,
                tokenToSell,
                amount,
                tokenToBuy,
                receiver
            ),
            true
        );

        vm.stopBroadcast();
    }
}
