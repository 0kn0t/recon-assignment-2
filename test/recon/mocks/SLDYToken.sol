// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

import {ERC20} from "@solady/tokens/ERC20.sol";

contract SLDYToken is ERC20 {
    function name() public view override returns (string memory) {
        return "Solady Token";
    }

    function symbol() public view override returns (string memory) {
        return "SLDY";
    }

    function mint(address to, uint256 amount) public {
        _mint(to, amount);
    }
}