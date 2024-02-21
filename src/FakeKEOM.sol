// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

interface CToken {
    function mint(uint256 mintAmount) external;
}

contract FakeKMATIC is ERC20, CToken {
    constructor() ERC20("Fake KMATIC", "FKMATIC") {}

    function mint(uint256 mintAmount) external {
        _mint(msg.sender, mintAmount);
    }
}
