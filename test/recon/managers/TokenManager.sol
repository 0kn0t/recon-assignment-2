// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

import {vm} from "@chimera/Hevm.sol";

import {FOTToken} from "../mocks/FOTToken.sol";
import {OZToken} from "../mocks/OZToken.sol";
import {SLDYToken} from "../mocks/SLDYToken.sol";
import {SLMTToken} from "../mocks/SLMTToken.sol";
import {StETHToken} from "../mocks/StETHToken.sol";
import {USDTToken} from "../mocks/USDTToken.sol";
import {IERC20} from "@openzeppelin/token/ERC20/IERC20.sol";

abstract contract TokenManager {
    USDTToken internal _usdt;
    StETHToken internal _stETH;
    SLMTToken internal _slmt;
    SLDYToken internal _sldy;
    OZToken internal _oz;
    FOTToken internal _fot;

    address[] internal tokens;

    address internal token;

    function _setupTokens(address[] memory actors,address[] memory vaults, address[] memory approveTo) internal {
        _usdt = new USDTToken();
        _stETH = new StETHToken();
        _slmt = new SLMTToken();
        _sldy = new SLDYToken();
        _oz = new OZToken();
        _fot = new FOTToken();

        tokens.push(address(_usdt));
        tokens.push(address(_stETH));
        tokens.push(address(_slmt));
        tokens.push(address(_sldy));
        tokens.push(address(_oz));
        tokens.push(address(_fot));

        _mintTo(address(this), 1000 ether);
        token = address(_oz);

        for (uint i; i < tokens.length; i++) {
            for (uint256 i; i < approveTo.length; i++) {
                _approveForAllActors(token, actors, approveTo[i]);
                _approveForAllActors(token, vaults, approveTo[i]);
            }
        }
    }

    function _getRandomToken(uint256 seed) internal view returns (address) {
        return tokens[seed % tokens.length];
    }

    function _mintTo(address to, uint256 amount) internal {
        _usdt.mint(to, amount);
        _stETH.mint(to, amount);
        _slmt.mint(to, amount);
        _sldy.mint(to, amount);
        _oz.mint(to, amount);
        _fot.mint(to, amount);
    }

    function _approveForAllActors(address token, address[] memory actors, address to) internal {
        for (uint256 i; i < actors.length; i++) {
            vm.prank(actors[i]);
            IERC20(token).approve(to, type(uint256).max);
        }
    }

    function _switchToken(uint256 seed) internal {
        token = _getRandomToken(seed);
    }
}
