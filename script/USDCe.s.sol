pragma solidity 0.6.12;

import "forge-std/Script.sol";
import "@usdc-e/usdc-impl/FiatTokenV2_1.sol";
import "@usdc-e/usdc-proxy/FiatTokenProxy.sol";

/// @notice Copy of USDC's deploy+init script.

contract DeployUSDCe is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("DEPLOYER_PRIVATE_KEY");

        vm.startBroadcast(deployerPrivateKey);

        // deploy USDC implementation and proxy
        FiatTokenV2_1 usdceImpl = new FiatTokenV2_1();
        FiatTokenProxy usdceProxy = new FiatTokenProxy(address(usdceImpl));

        console.log("Deployed USDCE at address: %s", address(usdceProxy));

        vm.stopBroadcast();
    }
}

contract InitUSDCe is Script {
    function run() external {
        uint256 minterAllowedAmount = vm.envUint("MINTER_ALLOWED_AMOUNT");
        address masterMinter = vm.envAddress("ADDRESS_MASTER_MINTER");
        address pauser = vm.envAddress("ADDRESS_PAUSER");
        address blacklister = vm.envAddress("ADDRESS_BLACKLISTER");
        address owner = vm.envAddress("ADDRESS_OWNER");

        uint256 ownerAdminPrivateKey = vm.envUint("OWNER_ADMIN_PRIVATE_KEY");
        address ownerAdminAddr = vm.addr(ownerAdminPrivateKey);

        vm.startBroadcast(ownerAdminPrivateKey);

        address payable usdceProxyAddr = payable(vm.envAddress("ADDRESS_L2_USDC"));
        console.log("usdc", usdceProxyAddr);

        // change proxy admin so we can call init after (fallback requires caller != admin)
        FiatTokenProxy usdceProxy = FiatTokenProxy(usdceProxyAddr);
        console.log("from", usdceProxy.admin());
        console.log("to", owner);
        usdceProxy.changeAdmin(owner);

        // now we can initialize through the proxy
        FiatTokenV2_1 usdce = FiatTokenV2_1(usdceProxyAddr);
        console.log("initializing", usdceProxyAddr);
        initializeAndConfigureMinters(usdce, ownerAdminAddr, minterAllowedAmount);

        vm.stopBroadcast();
    }

    function initializeAndConfigureMinters(FiatTokenV2_1 usdce, address deployerAddress, uint256 minterAllowedAmount)
        internal
    {
        // we first initialize the token with the deployer as the controller
        // so we can configure the minters. Later on we will relinquish this
        // power to the appropriate controllers
        usdce.initialize(
            "USD Coin",
            "USDC",
            "USD",
            6,
            deployerAddress, // master minter
            deployerAddress, // pauser
            deployerAddress, // blacklister
            deployerAddress // owner
        );
        usdce.initializeV2("USD Coin");
        // we pass the 0 address here because `initializeV2_1`'s `lostAndFound`
        // parameter will not be used, since this is a newly deployed token and
        // thus we can assume it will have a balance of 0
        usdce.initializeV2_1(address(0));

        usdce.configureMinter(vm.envAddress("ADDRESS_ZK_MINTER_BURNER_PROXY"), minterAllowedAmount);
        console.log(
            "Configured zkMinterBurnerProxy with address %s as minter with allowance: %s",
            vm.envAddress("ADDRESS_ZK_MINTER_BURNER_PROXY"),
            minterAllowedAmount
        );
        usdce.configureMinter(vm.envAddress("ADDRESS_NATIVE_CONVERTER_PROXY"), minterAllowedAmount);
        console.log(
            "Configured nativeConverter with address %s as minter with allowance: %s",
            vm.envAddress("ADDRESS_NATIVE_CONVERTER_PROXY"),
            minterAllowedAmount
        );
    }
}
