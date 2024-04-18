// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "lib/forge-std/src/console.sol";
import "lib/forge-std/src/Script.sol";

import {LibDeployInit} from "@usdc-lxly/../scripts/DeployInitHelpers.sol";

contract DeployL1 is Script {
    function run() external {
        vm.startBroadcast(vm.envUint("DEPLOYER_PRIVATE_KEY"));
        address l1EscrowProxy = LibDeployInit.deployL1Contracts();
        console.log("DEPLOYED L1ESCROW", l1EscrowProxy);
        vm.stopBroadcast();
    }
}

contract DeployL2 is Script {
    function run() external {
        vm.startBroadcast(vm.envUint("DEPLOYER_PRIVATE_KEY"));
        (address minterBurnerProxy, address nativeConverterProxy) = LibDeployInit.deployL2Contracts();
        console.log("DEPLOYED MINTERBURNER", minterBurnerProxy);
        console.log("DEPLOYED NATIVECONVERTER", nativeConverterProxy);
    }
}

contract InitL1 is Script {
    function run() external {
        address l1Owner = vm.envAddress("ADDRESS_L1_OWNER");
        address l1Admin = vm.envAddress("ADDRESS_L1_PROXY_ADMIN");
        uint32 l2NetworkId = uint32(vm.envUint("L2_NETWORK_ID"));
        address bridge = vm.envAddress("ADDRESS_LXLY_BRIDGE");
        address l1EscrowProxy = vm.envAddress("ADDRESS_L1_ESCROW_PROXY");
        address minterBurnerProxy = vm.envAddress("ADDRESS_ZK_MINTER_BURNER_PROXY");
        address l1Usdc = vm.envAddress("ADDRESS_L1_USDC");

        vm.startBroadcast(vm.envUint("DEPLOYER_PRIVATE_KEY"));
        LibDeployInit.initL1Contracts(l1Owner, l1Admin, l2NetworkId, bridge, l1EscrowProxy, minterBurnerProxy, l1Usdc);
        vm.stopBroadcast();
    }
}

contract InitL2 is Script {
    function run() external {
        address l2Owner = vm.envAddress("ADDRESS_L2_OWNER");
        address l2Admin = vm.envAddress("ADDRESS_L2_PROXY_ADMIN");
        uint32 l1NetworkId = uint32(vm.envUint("L1_NETWORK_ID"));
        address bridge = vm.envAddress("ADDRESS_LXLY_BRIDGE");
        address l1EscrowProxy = vm.envAddress("ADDRESS_L1_ESCROW_PROXY");
        address minterBurnerProxy = vm.envAddress("ADDRESS_ZK_MINTER_BURNER_PROXY");
        address nativeConverterProxy = vm.envAddress("ADDRESS_NATIVE_CONVERTER_PROXY");
        address zkUSDCe = vm.envAddress("ADDRESS_L2_USDC");
        address zkBWUSDC = vm.envAddress("ADDRESS_L2_WUSDC");

        vm.startBroadcast(vm.envUint("DEPLOYER_PRIVATE_KEY"));
        LibDeployInit.initL2Contracts(
            l2Owner,
            l2Admin,
            l1NetworkId,
            bridge,
            l1EscrowProxy,
            minterBurnerProxy,
            nativeConverterProxy,
            zkUSDCe,
            zkBWUSDC
        );
        vm.stopBroadcast();
    }
}
