// SPDX-License-Identifier: AGPL-3.0
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

interface ISwapRouter {
    struct ExactInputSingleParams {
        address tokenIn;
        address tokenOut;
        address recipient;
        uint256 deadline;
        uint256 amountIn;
        uint256 amountOutMinimum;
        uint160 limitSqrtPrice;
    }

    function exactInputSingle(ExactInputSingleParams calldata params) external payable returns (uint256 amountOut);
}

contract SwapHelper {
    using SafeERC20 for IERC20;

    function swapAndTransfer(address swapper, address tokenToSell, uint256 amount, address tokenToBuy, address receiver)
        external
    {
        IERC20 erc20 = IERC20(tokenToSell);

        // 1) transfer the token from the sender to this helper
        erc20.safeTransferFrom(msg.sender, address(this), amount);

        // 2a) allow the swapper to spend
        erc20.approve(swapper, amount);
        // 2b) swap
        ISwapRouter.ExactInputSingleParams memory params =
            ISwapRouter.ExactInputSingleParams(tokenToSell, tokenToBuy, receiver, block.timestamp + 86400, amount, 0, 0);
        ISwapRouter(swapper).exactInputSingle(params);
    }
}
