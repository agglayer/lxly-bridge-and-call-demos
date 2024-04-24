// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {SafeERC20} from "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

interface CToken {
    function mint(uint256 mintAmount) external;
}

contract FakeKEOM is ERC20, CToken {
    using SafeERC20 for ERC20;

    ERC20 internal _assetToken;

    constructor(string memory kMarketName, string memory kTokenName, address token) ERC20(kMarketName, kTokenName) {
        _assetToken = ERC20(token);
    }

    function mint(uint256 amount) external {
        _assetToken.safeTransferFrom(msg.sender, address(this), amount);
        _mint(msg.sender, amount);
    }
}
