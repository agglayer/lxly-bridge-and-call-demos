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
        address lxAGG = vm.envAddress("ADDRESS_LX_AGG");
        address lyAGGbw = vm.envAddress("ADDRESS_LY_AGG_BW");
        address lyKAGGbw = vm.envAddress("ADDRESS_LY_KAGG_BW");
        uint256 amount = vm.envUint("AMOUNT_IN_DECIMALS");
        address receiver = vm.envAddress("ADDRESS_DEPLOYER");

        // the multicall calldata - this happens in LY
        bytes memory multicallCalldata = abi.encodeWithSelector(
            bytes4(keccak256("multiCall(address[],bytes[])")),
            [
                // call lyAGGbw.approve(lyKAGGbw, amount)
                lyAGGbw,
                // call lyKAGGbw.mint(amount)
                lyKAGGbw,
                // call lyKAGGbw.transfer(receiver)
                lyKAGGbw
            ],
            [
                // calldata for allowing KEOM to transfer the AGGbw
                abi.encodeWithSelector(bytes4(keccak256("approve(address,uint256)")), lyKAGGbw, amount),
                // calldata for depositing into KEOM
                abi.encodeWithSelector(bytes4(keccak256("mint(uint256)")), amount),
                // calldata for transfering KAGGbw to the receiver
                abi.encodeWithSelector(bytes4(keccak256("transfer(address,uint256)")), receiver, amount)
            ]
        );

        // this executes in LX
        // allow bridge extension to spend the lxAGG for bridge and call
        IERC20(lxAGG).approve(address(bridgeExtension), amount);
        // do the bridge and call
        BridgeExtension(bridgeExtension).bridgeAndCall(
            lxAGG, // token to bridge
            amount, // amount to bridge
            "", // not using permit
            uint32(vm.envUint("LY_NETWORK_ID")), // destination network id
            vm.envAddress("ADDRESS_LY_MULTICALL"), // multicall
            receiver, // fallback address
            multicallCalldata, // calldata
            true
        );

        vm.stopBroadcast();
    }
}
