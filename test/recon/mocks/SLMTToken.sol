// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

import {ERC20} from "@solmate/tokens/ERC20.sol";

contract SLMTToken is ERC20 {
    constructor() ERC20("Solmate Token", "SLMT", 18) {}

    function mint(address to, uint256 amount) public {
        _mint(to, amount);
    }
}