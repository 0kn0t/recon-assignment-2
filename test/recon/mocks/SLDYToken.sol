// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.10;

import {ERC20} from "@solady/tokens/ERC20.sol";

contract SLErc20 is ERC20 {
    function name() public view override returns (string memory) {
        return "Solady Token";
    }

    function symbol() public view override returns (string memory) {
        return "SLDY";
    }
}