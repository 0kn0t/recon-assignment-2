// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

import {ERC20} from "@openzeppelin/token/ERC20/ERC20.sol";

contract StETHToken is ERC20 {
    uint256 public totalShares;
    uint256 public totalPooledEther;

    mapping(address => uint256) private shares;

    constructor() ERC20("Staked Ether Mock", "StETHToken") {
        _mintShares(address(this), 10 ** decimals());

        totalPooledEther = 10 ** decimals();
    }

    function mint(address _account, uint256 _amount) external {
        require(_amount <= 1000 * (10 ** decimals()), "StETHToken: amount is too big");

        uint256 sharesAmount = getSharesByPooledEth(_amount);

        _mintShares(_account, sharesAmount);

        totalPooledEther += _amount;
    }

    function setTotalPooledEther(uint256 _totalPooledEther) external {
        totalPooledEther = _totalPooledEther;
    }

    function totalSupply() public view override returns (uint256) {
        return totalPooledEther;
    }

    function balanceOf(address _account) public view override returns (uint256) {
        return getPooledEthByShares(_sharesOf(_account));
    }

    function sharesOf(address _account) external view returns (uint256) {
        return _sharesOf(_account);
    }

    function getSharesByPooledEth(uint256 _ethAmount) public view returns (uint256) {
        return (_ethAmount * totalShares) / totalPooledEther;
    }

    function getPooledEthByShares(uint256 _sharesAmount) public view returns (uint256) {
        return (_sharesAmount * totalPooledEther) / totalShares;
    }

    function transferShares(address _recipient, uint256 _sharesAmount) external returns (uint256) {
        _transferShares(msg.sender, _recipient, _sharesAmount);
        uint256 tokensAmount = getPooledEthByShares(_sharesAmount);
        return tokensAmount;
    }

    function transferSharesFrom(address _sender, address _recipient, uint256 _sharesAmount) external returns (uint256) {
        uint256 tokensAmount = getPooledEthByShares(_sharesAmount);
        _spendAllowance(_sender, msg.sender, tokensAmount);
        _transferShares(_sender, _recipient, _sharesAmount);
        return tokensAmount;
    }

    function _update(address from, address to, uint256 value) internal override {
        uint256 _sharesToTransfer = getSharesByPooledEth(value);
        _transferShares(from, to, _sharesToTransfer);
    }

    function _sharesOf(address _account) internal view returns (uint256) {
        return shares[_account];
    }

    function _transferShares(address _sender, address _recipient, uint256 _sharesAmount) internal {
        require(_sender != address(0), "TRANSFER_FROM_ZERO_ADDR");
        require(_recipient != address(0), "TRANSFER_TO_ZERO_ADDR");
        require(_recipient != address(this), "TRANSFER_TO_STETH_CONTRACT");

        uint256 currentSenderShares = shares[_sender];
        require(_sharesAmount <= currentSenderShares, "BALANCE_EXCEEDED");

        shares[_sender] = currentSenderShares - _sharesAmount;
        shares[_recipient] += _sharesAmount;
    }

    function _mintShares(address _recipient, uint256 _sharesAmount) internal returns (uint256 newTotalShares) {
        require(_recipient != address(0), "MINT_TO_ZERO_ADDR");

        totalShares += _sharesAmount;

        shares[_recipient] += _sharesAmount;

        return totalShares;
    }
}