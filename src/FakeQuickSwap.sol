// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract FakeAggLayerToken is ERC20 {
    constructor() ERC20("Aggregation Layer Token", "AGG") {}

    function mint(address receiver, uint256 amount) external {
        _mint(receiver, amount);
    }
}

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

contract FakeQuickSwap is ISwapRouter {
    FakeAggLayerToken public immutable aggLayerToken;

    constructor() {
        aggLayerToken = new FakeAggLayerToken();
    }

    function exactInputSingle(ExactInputSingleParams calldata params) external payable returns (uint256 amountOut) {
        aggLayerToken.mint(params.recipient, params.amountOutMinimum);

        return params.amountOutMinimum;
    }
}
