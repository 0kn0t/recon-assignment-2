// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

import {ERC20} from "@openzeppelin/token/ERC20/ERC20.sol";

contract FOTToken is ERC20 {
    uint256 public feePercentage = 200; // 2%
    address public feeRecipient = address(0x123);

    constructor() ERC20("FOT Token", "FOT") {}

    function mint(address to, uint256 amount) public {
        _mint(to, amount);
    }

    function _update(address from, address to, uint256 value) internal override {
        require(to != address(0), "Transfer to zero address");

        if (from == address(0)) {
            super._update(from, to, value);
        } else {
            uint256 feeAmount = (value * feePercentage) / 10000;
            uint256 transferAmount = value - feeAmount;

            super._transfer(from, feeRecipient, feeAmount);
            super._transfer(from, to, transferAmount);
        }
    }
}