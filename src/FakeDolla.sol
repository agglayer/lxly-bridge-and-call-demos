// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract FakeDolla is ERC20 {
    constructor() ERC20("Dolla", "DOLLA") {}

    function mint(address receiver, uint256 amount) external {
        _mint(receiver, amount);
    }
}
