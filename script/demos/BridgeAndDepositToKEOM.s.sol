// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import "forge-std/console.sol";
import {Script} from "forge-std/Script.sol";
import {IERC20} from "forge-std/interfaces/IERC20.sol";

import {BridgeExtension} from "@bridge-and-call/BridgeExtension.sol";

contract AGG is Script {
    function run() public {
        vm.startBroadcast(vm.envUint("DEPLOYER_PRIVATE_KEY"));

        address bridgeExtension = vm.envAddress("ADDRESS_BRIDGE_EXTENSION");
        address aggLayerToken = vm.envAddress("ADDRESS_LX_AGG");
        address kbwAGG = vm.envAddress("ADDRESS_LY_KBWAGG");
        uint256 amount = vm.envUint("AMOUNT_IN_DECIMALS");

        // the multicall calldata
        bytes memory multicallCalldata = abi.encodeWithSelector(
            bytes4(keccak256("multiCall(address[],bytes[])")),
            [
                // call agg.approve(kbwAGG, amount)
                aggLayerToken,
                // call kbwAGG.mint(amount)
                kbwAGG
                // TODO: add approval and transfer to me
            ],
            [
                // aggLayerToken approval calldata
                abi.encodeWithSelector(bytes4(keccak256("approve(address,uint256)")), kbwAGG, amount),
                // KEOM calldata
                abi.encodeWithSelector(
                    bytes4(keccak256("mint(uint256)")),
                    amount // amount
                )
                // TODO: transfer to me
            ]
        );

        // allow bridge extension to spend the aggLayerToken for bridge and call
        IERC20(aggLayerToken).approve(address(bridgeExtension), amount);
        BridgeExtension(bridgeExtension).bridgeAndCall(
            aggLayerToken, // token to bridge
            amount, // amount to bridge
            "", // not using permit
            uint32(vm.envUint("LY_NETWORK_ID")), // destination network id
            vm.envAddress("ADDRESS_LY_MULTICALL"), // multicall
            address(0), // fallback address
            multicallCalldata, // calldata
            true
        );

        vm.stopBroadcast();
    }
}
