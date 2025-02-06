// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

import {ERC20} from "@openzeppelin/token/ERC20/ERC20.sol";

contract USDTToken is ERC20 {
    constructor() ERC20("TETHER", "USDT") {}

    function decimals() public pure override returns (uint8) {
        return 6;
    }

    function mint(address to, uint256 amount) public {
        _mint(to, amount);
    }
}