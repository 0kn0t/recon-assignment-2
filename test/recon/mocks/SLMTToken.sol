// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.10;

import {ERC20} from "@solmate/tokens/ERC20.sol";

contract SMErc20 is ERC20 {
    constructor() ERC20("Solmate Token", "SLMT", 18) {}
}