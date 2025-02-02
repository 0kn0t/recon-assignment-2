// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

import {ERC20} from "@openzeppelin/token/ERC20/ERC20.sol";

contract OZToken is ERC20 {
    constructor() ERC20("OZ Token", "OZ") {}

    function mint(address to, uint256 amount) public {
        _mint(to, amount);
    }
}