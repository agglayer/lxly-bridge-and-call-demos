// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import "forge-std/console.sol";
import {Script} from "forge-std/Script.sol";
import {IERC20} from "forge-std/interfaces/IERC20.sol";

import {BridgeExtension} from "@bridge-and-call/BridgeExtension.sol";

contract BridgeAndCallNativeConverter is Script {
    function run() public {
        address l1Usdc = vm.envAddress("ADDRESS_L1_USDC");
        address l2Usdc = vm.envAddress("ADDRESS_L2_USDC");
        address l2BridgeWrappedUsdc = vm.envAddress("ADDRESS_L2_WUSDC");
        address nativeConverter = vm.envAddress("ADDRESS_NATIVE_CONVERTER_PROXY");

        BridgeExtension beL1 = BridgeExtension(vm.envAddress("ADDRESS_L1_BRIDGE_EXTENSION"));

        uint256 alicePrivateKey = vm.envUint("DEPLOYER_PRIVATE_KEY");
        address alice = vm.addr(alicePrivateKey);
        vm.startBroadcast(alicePrivateKey);

        uint256 amount = 2 * 10 ** 6;
        IERC20(l1Usdc).approve(address(beL1), amount);

        beL1.bridgeAndCall(
            l1Usdc,
            amount,
            "", // no permit data
            uint32(vm.envUint("L2_NETWORK_ID")), // destination network
            nativeConverter, // call address
            abi.encodeWithSelector(bytes4(keccak256("convert(address,uint256,bytes)")), alice, amount, ""), // call data
            true
        );

        vm.stopBroadcast();
    }
}
