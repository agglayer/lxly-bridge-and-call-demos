// SPDX-License-Identifier: AGPL-3.0
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

interface KToken {
    function balanceOf(address owner) external view returns (uint256);

    function mint(uint256 mintAmount) external;

    function transfer(address dst, uint256 amount) external returns (bool);
}

contract KEOMHelper {
    using SafeERC20 for IERC20;
    using SafeERC20 for KToken;

    // deposits to a given KEOM market, and transfers the kTokens to the receiver
    // this is needed because by default KEOM sends the kTokens to msg.sender
    function depositAndTransfer(address token, uint256 amount, address market, address receiver) external {
        IERC20 erc20 = IERC20(token);
        KToken kToken = KToken(market);

        // 1) transfer the token from the sender to this helper
        erc20.safeTransferFrom(msg.sender, address(this), amount);

        // 2a) allow the market to spend
        erc20.approve(market, amount);
        // 2b) deposit into the market
        kToken.mint(amount);

        // 3) transfer all the kTokens to receiver
        kToken.transfer(receiver, kToken.balanceOf(address(this)));
    }
}
