// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import "lib/forge-std/src/console.sol";
import "lib/forge-std/src/Script.sol";

import {BridgeExtension} from "@bridge-and-call/BridgeExtension.sol";

contract DeployL1 is Script {
    function run() external {
        vm.startBroadcast(vm.envUint("DEPLOYER_PRIVATE_KEY"));

        // deploy l1 bridge extension
        address l1Owner = vm.envAddress("ADDRESS_L1_OWNER");
        address bridge = vm.envAddress("ADDRESS_LXLY_BRIDGE");
        uint32 l2NetworkId = uint32(vm.envUint("L2_NETWORK_ID"));

        BridgeExtension beL1 = new BridgeExtension(l1Owner, bridge, l2NetworkId);
        console.log("L1 BRIDGE EXTENSION", address(beL1));

        vm.stopBroadcast();
    }
}

contract DeployL2 is Script {
    function run() external {
        vm.startBroadcast(vm.envUint("DEPLOYER_PRIVATE_KEY"));

        // deploy l2 bridge extension
        address l2Owner = vm.envAddress("ADDRESS_L2_OWNER");
        address bridge = vm.envAddress("ADDRESS_LXLY_BRIDGE");
        uint32 l1NetworkId = uint32(vm.envUint("L1_NETWORK_ID"));

        BridgeExtension beL2 = new BridgeExtension(l2Owner, bridge, l1NetworkId);
        console.log("L2 BRIDGE EXTENSION", address(beL2));

        vm.stopBroadcast();
    }
}

contract InitL1 is Script {
    function run() external {
        vm.startBroadcast(vm.envUint("DEPLOYER_PRIVATE_KEY"));

        BridgeExtension beL1 = BridgeExtension(vm.envAddress("ADDRESS_L1_BRIDGE_EXTENSION"));
        beL1.setCounterpartyExtension(vm.envAddress("ADDRESS_L2_BRIDGE_EXTENSION"));

        vm.stopBroadcast();
    }
}

contract InitL2 is Script {
    function run() external {
        vm.startBroadcast(vm.envUint("DEPLOYER_PRIVATE_KEY"));

        BridgeExtension beL2 = BridgeExtension(vm.envAddress("ADDRESS_L2_BRIDGE_EXTENSION"));
        beL2.setCounterpartyExtension(vm.envAddress("ADDRESS_L1_BRIDGE_EXTENSION"));

        vm.stopBroadcast();
    }
}
