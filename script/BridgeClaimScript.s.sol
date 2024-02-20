// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import {Script} from "forge-std/Script.sol";
import "forge-std/console.sol";
import {IERC20} from "forge-std/interfaces/IERC20.sol";

import "@oz-contracts-upgradeable/token/ERC20/extensions/IERC20MetadataUpgradeable.sol";
import {IPolygonZkEVMBridgeV2} from "@zkevm/v2/interfaces/IPolygonZkEVMBridgeV2.sol";

contract BridgeAsset is Script {
    function run() public {
        uint256 deployerPrivateKey = vm.envUint("DEPLOYER_PRIVATE_KEY");
        address deployerAddress = vm.addr(deployerPrivateKey);

        address usdcAddr = vm.envAddress("ADDRESS_L1_USDC");
        address bridgeAddr = vm.envAddress("ADDRESS_LXLY_BRIDGE");

        vm.startBroadcast(deployerPrivateKey);

        IPolygonZkEVMBridgeV2 bridge = IPolygonZkEVMBridgeV2(bridgeAddr);
        IERC20 usdc = IERC20(usdcAddr);

        uint256 amount = 10 ** 6;
        usdc.approve(bridgeAddr, amount);
        bridge.bridgeAsset(uint32(vm.envUint("L2_NETWORK_ID")), deployerAddress, amount, usdcAddr, true, "");
    }
}

contract ClaimAsset is Script {
    function run() public {
        uint256 deployerPrivateKey = vm.envUint("DEPLOYER_PRIVATE_KEY");
        address deployerAddress = vm.addr(deployerPrivateKey);
        address usdcAddr = vm.envAddress("ADDRESS_L1_USDC");
        address bridgeAddr = vm.envAddress("ADDRESS_LXLY_BRIDGE");

        vm.startBroadcast(deployerPrivateKey);

        IPolygonZkEVMBridgeV2 bridge = IPolygonZkEVMBridgeV2(bridgeAddr);
        uint256 amount = 2 * 10 ** 6;

        // most values from https://proof-generator.polygon.technology/api/zkevm/cardona/merkle-proof?deposit_cnt=6295&net_id=0
        bridge.claimAsset(
            // smt proof local exit root
            [
                bytes32(bytes(hex"")),
                bytes32(bytes(hex"")),
                bytes32(bytes(hex"")),
                bytes32(bytes(hex"")),
                bytes32(bytes(hex"")),
                bytes32(bytes(hex"")),
                bytes32(bytes(hex"")),
                bytes32(bytes(hex"")),
                bytes32(bytes(hex"")),
                bytes32(bytes(hex"")),
                bytes32(bytes(hex"")),
                bytes32(bytes(hex"")),
                bytes32(bytes(hex"")),
                bytes32(bytes(hex"")),
                bytes32(bytes(hex"")),
                bytes32(bytes(hex"")),
                bytes32(bytes(hex"")),
                bytes32(bytes(hex"")),
                bytes32(bytes(hex"")),
                bytes32(bytes(hex"")),
                bytes32(bytes(hex"")),
                bytes32(bytes(hex"")),
                bytes32(bytes(hex"")),
                bytes32(bytes(hex"")),
                bytes32(bytes(hex"")),
                bytes32(bytes(hex"")),
                bytes32(bytes(hex"")),
                bytes32(bytes(hex"")),
                bytes32(bytes(hex"")),
                bytes32(bytes(hex"")),
                bytes32(bytes(hex"")),
                bytes32(bytes(hex""))
            ],
            // smt proof rollup exit root
            [
                bytes32(bytes(hex"0000000000000000000000000000000000000000000000000000000000000000")),
                bytes32(bytes(hex"0000000000000000000000000000000000000000000000000000000000000000")),
                bytes32(bytes(hex"0000000000000000000000000000000000000000000000000000000000000000")),
                bytes32(bytes(hex"0000000000000000000000000000000000000000000000000000000000000000")),
                bytes32(bytes(hex"0000000000000000000000000000000000000000000000000000000000000000")),
                bytes32(bytes(hex"0000000000000000000000000000000000000000000000000000000000000000")),
                bytes32(bytes(hex"0000000000000000000000000000000000000000000000000000000000000000")),
                bytes32(bytes(hex"0000000000000000000000000000000000000000000000000000000000000000")),
                bytes32(bytes(hex"0000000000000000000000000000000000000000000000000000000000000000")),
                bytes32(bytes(hex"0000000000000000000000000000000000000000000000000000000000000000")),
                bytes32(bytes(hex"0000000000000000000000000000000000000000000000000000000000000000")),
                bytes32(bytes(hex"0000000000000000000000000000000000000000000000000000000000000000")),
                bytes32(bytes(hex"0000000000000000000000000000000000000000000000000000000000000000")),
                bytes32(bytes(hex"0000000000000000000000000000000000000000000000000000000000000000")),
                bytes32(bytes(hex"0000000000000000000000000000000000000000000000000000000000000000")),
                bytes32(bytes(hex"0000000000000000000000000000000000000000000000000000000000000000")),
                bytes32(bytes(hex"0000000000000000000000000000000000000000000000000000000000000000")),
                bytes32(bytes(hex"0000000000000000000000000000000000000000000000000000000000000000")),
                bytes32(bytes(hex"0000000000000000000000000000000000000000000000000000000000000000")),
                bytes32(bytes(hex"0000000000000000000000000000000000000000000000000000000000000000")),
                bytes32(bytes(hex"0000000000000000000000000000000000000000000000000000000000000000")),
                bytes32(bytes(hex"0000000000000000000000000000000000000000000000000000000000000000")),
                bytes32(bytes(hex"0000000000000000000000000000000000000000000000000000000000000000")),
                bytes32(bytes(hex"0000000000000000000000000000000000000000000000000000000000000000")),
                bytes32(bytes(hex"0000000000000000000000000000000000000000000000000000000000000000")),
                bytes32(bytes(hex"0000000000000000000000000000000000000000000000000000000000000000")),
                bytes32(bytes(hex"0000000000000000000000000000000000000000000000000000000000000000")),
                bytes32(bytes(hex"0000000000000000000000000000000000000000000000000000000000000000")),
                bytes32(bytes(hex"0000000000000000000000000000000000000000000000000000000000000000")),
                bytes32(bytes(hex"0000000000000000000000000000000000000000000000000000000000000000")),
                bytes32(bytes(hex"0000000000000000000000000000000000000000000000000000000000000000")),
                bytes32(bytes(hex"0000000000000000000000000000000000000000000000000000000000000000"))
            ],
            uint256(6295) + 2 ** 64, // global index when originNetwork == 0: uint256(depositCount) + 2 ** 64
            // uint256(6295) + uint256(0) * 2 ** 32, // global index: uint256(depositCount) + uint256(sourceBridgeNetwork) * _MAX_LEAFS_PER_NETWORK
            bytes32(bytes(hex"")), // mainnetExitRoot
            bytes32(bytes(hex"")), // rollupExitRoot
            uint32(vm.envUint("L1_NETWORK_ID")), // originNetwork
            usdcAddr, // originTokenAddress
            uint32(vm.envUint("L2_NETWORK_ID")), // destinationNetwork
            deployerAddress, // destinationAddress
            amount, // amount
            bytes(hex"") // metadata
        );
    }
}

contract ClaimMessage is Script {
    function run() public {
        uint256 deployerPrivateKey = vm.envUint("DEPLOYER_PRIVATE_KEY");
        address deployerAddress = vm.addr(deployerPrivateKey);
        address originAddr = deployerAddress;
        address bridgeAddr = vm.envAddress("ADDRESS_LXLY_BRIDGE");

        vm.startBroadcast(deployerPrivateKey);

        IPolygonZkEVMBridgeV2 bridge = IPolygonZkEVMBridgeV2(bridgeAddr);
        // most values from https://proof-generator.polygon.technology/api/zkevm/cardona/merkle-proof?deposit_cnt=6296&net_id=0
        bridge.claimMessage(
            // smt proof local exit root
            [
                bytes32(bytes(hex"0000000000000000000000000000000000000000000000000000000000000000")),
                bytes32(bytes(hex"ad3228b676f7d3cd4284a5443f17f1962b36e491b30a40b2405849e597ba5fb5")),
                bytes32(bytes(hex"b4c11951957c6f8f642c4af61cd6b24640fec6dc7fc607ee8206a99e92410d30")),
                bytes32(bytes(hex"9951fcdaad7190f66121372f7f2ac3682eacba6829f252499e9cc5e298a5e763")),
                bytes32(bytes(hex"a16542485398b4c78ccd92ef33f19cb53d36d0047224838aba0abbc502fb99cd")),
                bytes32(bytes(hex"0eb01ebfc9ed27500cd4dfc979272d1f0913cc9f66540d7e8005811109e1cf2d")),
                bytes32(bytes(hex"887c22bd8750d34016ac3c66b5ff102dacdd73f6b014e710b51e8022af9a1968")),
                bytes32(bytes(hex"343091bb5c43e454ab5a22fcb041ff2bc8d06e890ed27abfe456feef4bf308bf")),
                bytes32(bytes(hex"9867cc5f7f196b93bae1e27e6320742445d290f2263827498b54fec539f756af")),
                bytes32(bytes(hex"cefad4e508c098b9a7e1d8feb19955fb02ba9675585078710969d3440f5054e0")),
                bytes32(bytes(hex"f9dc3e7fe016e050eff260334f18a5d4fe391d82092319f5964f2e2eb7c1c3a5")),
                bytes32(bytes(hex"d2416b0547a24241cd2ef5367c52144cacd3d14e16010f4ea718a5034a74b4b3")),
                bytes32(bytes(hex"7f17ce1f4c5dafccee42fe11509b46f2f9315ee72a026916419191c0428f06fc")),
                bytes32(bytes(hex"c1df82d9c4b87413eae2ef048f94b4d3554cea73d92b0f7af96e0271c691e2bb")),
                bytes32(bytes(hex"5c67add7c6caf302256adedf7ab114da0acfe870d449a3a489f781d659e8becc")),
                bytes32(bytes(hex"da7bce9f4e8618b6bd2f4132ce798cdc7a60e7e1460a7299e3c6342a579626d2")),
                bytes32(bytes(hex"2733e50f526ec2fa19a22b31e8ed50f23cd1fdf94c9154ed3a7609a2f1ff981f")),
                bytes32(bytes(hex"e1d3b5c807b281e4683cc6d6315cf95b9ade8641defcb32372f1c126e398ef7a")),
                bytes32(bytes(hex"5a2dce0a8a7f68bb74560f8f71837c2c2ebbcbf7fffb42ae1896f13f7c7479a0")),
                bytes32(bytes(hex"b46a28b6f55540f89444f63de0378e3d121be09e06cc9ded1c20e65876d36aa0")),
                bytes32(bytes(hex"c65e9645644786b620e2dd2ad648ddfcbf4a7e5b1a3a4ecfe7f64667a3f0b7e2")),
                bytes32(bytes(hex"f4418588ed35a2458cffeb39b93d26f18d2ab13bdce6aee58e7b99359ec2dfd9")),
                bytes32(bytes(hex"5a9c16dc00d6ef18b7933a6f8dc65ccb55667138776f7dea101070dc8796e377")),
                bytes32(bytes(hex"4df84f40ae0c8229d0d6069e5c8f39a7c299677a09d367fc7b05e3bc380ee652")),
                bytes32(bytes(hex"cdc72595f74c7b1043d0e1ffbab734648c838dfb0527d971b602bc216c9619ef")),
                bytes32(bytes(hex"0abf5ac974a1ed57f4050aa510dd9c74f508277b39d7973bb2dfccc5eeb0618d")),
                bytes32(bytes(hex"b8cd74046ff337f0a7bf2c8e03e10f642c1886798d71806ab1e888d9e5ee87d0")),
                bytes32(bytes(hex"838c5655cb21c6cb83313b5a631175dff4963772cce9108188b34ac87c81c41e")),
                bytes32(bytes(hex"662ee4dd2dd7b2bc707961b1e646c4047669dcb6584f0d8d770daf5d7e7deb2e")),
                bytes32(bytes(hex"388ab20e2573d171a88108e79d820e98f26c0b84aa8b2f4aa4968dbb818ea322")),
                bytes32(bytes(hex"93237c50ba75ee485f4c22adf2f741400bdf8d6a9cc7df7ecae576221665d735")),
                bytes32(bytes(hex"8448818bb4ae4562849e949e17ac16e0be16688e156b5cf15e098c627c0056a9"))
            ],
            // smt proof rollup exit root
            [
                bytes32(bytes(hex"0000000000000000000000000000000000000000000000000000000000000000")),
                bytes32(bytes(hex"0000000000000000000000000000000000000000000000000000000000000000")),
                bytes32(bytes(hex"0000000000000000000000000000000000000000000000000000000000000000")),
                bytes32(bytes(hex"0000000000000000000000000000000000000000000000000000000000000000")),
                bytes32(bytes(hex"0000000000000000000000000000000000000000000000000000000000000000")),
                bytes32(bytes(hex"0000000000000000000000000000000000000000000000000000000000000000")),
                bytes32(bytes(hex"0000000000000000000000000000000000000000000000000000000000000000")),
                bytes32(bytes(hex"0000000000000000000000000000000000000000000000000000000000000000")),
                bytes32(bytes(hex"0000000000000000000000000000000000000000000000000000000000000000")),
                bytes32(bytes(hex"0000000000000000000000000000000000000000000000000000000000000000")),
                bytes32(bytes(hex"0000000000000000000000000000000000000000000000000000000000000000")),
                bytes32(bytes(hex"0000000000000000000000000000000000000000000000000000000000000000")),
                bytes32(bytes(hex"0000000000000000000000000000000000000000000000000000000000000000")),
                bytes32(bytes(hex"0000000000000000000000000000000000000000000000000000000000000000")),
                bytes32(bytes(hex"0000000000000000000000000000000000000000000000000000000000000000")),
                bytes32(bytes(hex"0000000000000000000000000000000000000000000000000000000000000000")),
                bytes32(bytes(hex"0000000000000000000000000000000000000000000000000000000000000000")),
                bytes32(bytes(hex"0000000000000000000000000000000000000000000000000000000000000000")),
                bytes32(bytes(hex"0000000000000000000000000000000000000000000000000000000000000000")),
                bytes32(bytes(hex"0000000000000000000000000000000000000000000000000000000000000000")),
                bytes32(bytes(hex"0000000000000000000000000000000000000000000000000000000000000000")),
                bytes32(bytes(hex"0000000000000000000000000000000000000000000000000000000000000000")),
                bytes32(bytes(hex"0000000000000000000000000000000000000000000000000000000000000000")),
                bytes32(bytes(hex"0000000000000000000000000000000000000000000000000000000000000000")),
                bytes32(bytes(hex"0000000000000000000000000000000000000000000000000000000000000000")),
                bytes32(bytes(hex"0000000000000000000000000000000000000000000000000000000000000000")),
                bytes32(bytes(hex"0000000000000000000000000000000000000000000000000000000000000000")),
                bytes32(bytes(hex"0000000000000000000000000000000000000000000000000000000000000000")),
                bytes32(bytes(hex"0000000000000000000000000000000000000000000000000000000000000000")),
                bytes32(bytes(hex"0000000000000000000000000000000000000000000000000000000000000000")),
                bytes32(bytes(hex"0000000000000000000000000000000000000000000000000000000000000000")),
                bytes32(bytes(hex"0000000000000000000000000000000000000000000000000000000000000000"))
            ],
            uint256(6296) + 2 ** 64, // global index when originNetwork == 0: uint256(depositCount) + 2 ** 64
            // uint256(6217) + uint256(1) * 2 ** 32, // global index when originNetwork == 1: uint256(depositCount) + uint256(sourceBridgeNetwork) * _MAX_LEAFS_PER_NETWORK
            bytes32(bytes(hex"3fd2df85ddfab297a39b501ff37dcaa881520f330f00e6b0157f48ff434d4e3b")), // mainnetExitRoot
            bytes32(bytes(hex"4475d32e911ee5441fa5918c696e04e5024a4c498d2065bdd23e810cb688a853")), // rollupExitRoot
            uint32(vm.envUint("L1_NETWORK_ID")), // originNetwork
            0x549Dd117fD893131C613c23597995f74B5993f05, // originAddress
            uint32(vm.envUint("L2_NETWORK_ID")), // destinationNetwork
            0x9BD74Ddb858E3bb98ED951d5cfe0B3e6Fe8DC240, // destinationAddress
            0, // amount
            bytes(
                hex"00000000000000000000000000000000000000000000000000000000000018980000000000000000000000004d758bd4ce9f7ed1e03ade50f1e2ef83c477113f0000000000000000000000001c7d4b196cb0c7b01d743fbc6116a902379c72380000000000000000000000000000000000000000000000000000000000000080000000000000000000000000000000000000000000000000000000000000008489eabf02000000000000000000000000b67826c2176682fd3ae3e31a561fc4b9fb01222500000000000000000000000000000000000000000000000000000000001e84800000000000000000000000000000000000000000000000000000000000000060000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000"
            ) // metadata
        );
    }
}

contract EncodeMetadata is Script {
    function run() public {
        address token = vm.envAddress("ADDRESS_L1_USDC");

        string memory safeName = _safeName(token);
        string memory safeSymbol = _safeSymbol(token);
        uint8 safeDecimals = _safeDecimals(token);
        console.log("safe name", safeName);
        console.log("safe symbol", safeSymbol);
        bytes memory metadata = abi.encode(safeName, safeSymbol, safeDecimals);

        console.logBytes(metadata);

        (string memory name, string memory symbol, uint8 decimals) = abi.decode(metadata, (string, string, uint8));
        console.log("name", name);
        console.log("symbol", symbol);
    }

    function _safeSymbol(address token) internal view returns (string memory) {
        (bool success, bytes memory data) =
            address(token).staticcall(abi.encodeCall(IERC20MetadataUpgradeable.symbol, ()));
        return success ? _returnDataToString(data) : "NO_SYMBOL";
    }

    function _safeName(address token) internal view returns (string memory) {
        (bool success, bytes memory data) =
            address(token).staticcall(abi.encodeCall(IERC20MetadataUpgradeable.name, ()));
        return success ? _returnDataToString(data) : "NO_NAME";
    }

    function _safeDecimals(address token) internal view returns (uint8) {
        (bool success, bytes memory data) =
            address(token).staticcall(abi.encodeCall(IERC20MetadataUpgradeable.decimals, ()));
        return success && data.length == 32 ? abi.decode(data, (uint8)) : 18;
    }

    function _returnDataToString(bytes memory data) internal pure returns (string memory) {
        if (data.length >= 64) {
            return abi.decode(data, (string));
        } else if (data.length == 32) {
            // Since the strings on bytes32 are encoded left-right, check the first zero in the data
            uint256 nonZeroBytes;
            while (nonZeroBytes < 32 && data[nonZeroBytes] != 0) {
                nonZeroBytes++;
            }

            // If the first one is 0, we do not handle the encoding
            if (nonZeroBytes == 0) {
                return "NOT_VALID_ENCODING";
            }
            // Create a byte array with nonZeroBytes length
            bytes memory bytesArray = new bytes(nonZeroBytes);
            for (uint256 i = 0; i < nonZeroBytes; i++) {
                bytesArray[i] = data[i];
            }
            return string(bytesArray);
        } else {
            return "NOT_VALID_ENCODING";
        }
    }
}

contract DecodeMetadata is Script {
    function run() public {
        bytes memory metadata =
            hex"000000000000000000000000000000000000000000000000000000000000006000000000000000000000000000000000000000000000000000000000000000a000000000000000000000000000000000000000000000000000000000000000060000000000000000000000000000000000000000000000000000000000000004555344430000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000045553444300000000000000000000000000000000000000000000000000000000";
        console.logBytes(metadata);

        (string memory name, string memory symbol, uint8 decimals) = abi.decode(metadata, (string, string, uint8));

        console.log("name", name);
        console.log("symbol", symbol);
    }
}
