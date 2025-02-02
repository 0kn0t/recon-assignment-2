// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {ERC20} from "@openzeppelin/token/ERC20/ERC20.sol";

contract FeeToken is ERC20 {
    uint256 public feePercentage = 200; // 2%
    address public feeRecipient = address(0x123);

    constructor() ERC20("FOT Token", "FOT") {}

    function _transfer(
        address sender,
        address recipient,
        uint256 amount
    ) internal virtual override {
        require(sender != address(0), "Transfer from zero address");
        require(recipient != address(0), "Transfer to zero address");

        uint256 feeAmount = (amount * feePercentage) / 10000;
        uint256 transferAmount = amount - feeAmount;

        super._transfer(sender, feeRecipient, feeAmount);
        super._transfer(sender, recipient, transferAmount);
    }
}