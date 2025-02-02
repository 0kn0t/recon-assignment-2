// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.10;

import {ERC20} from "@openzeppelin/token/ERC20/ERC20.sol";

contract OZErc20 is ERC20 {
    constructor() ERC20("OZ Token", "OZT") {}
}