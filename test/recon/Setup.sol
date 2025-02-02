// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

import {RewardsManager} from "../../src/RewardsManager.sol";
import {FOTToken} from "./mocks/FOTToken.sol";
import {OZToken} from "./mocks/OZToken.sol";
import {SLDYToken} from "./mocks/SLDYToken.sol";
import {SLMTToken} from "./mocks/SLMTToken.sol";
import {StETHToken} from "./mocks/StETHToken.sol";
import {BaseSetup} from "@chimera/BaseSetup.sol";
import {vm} from "@chimera/Hevm.sol";
import {IERC20} from "@openzeppelin/token/ERC20/IERC20.sol";

interface IERC20Extended is IERC20 {
    function mint(address to, uint256 amount) external;
}

abstract contract Setup is BaseSetup {
    RewardsManager rewardsManager;
    IERC20Extended token;

    address internal user1 = address(this);
    address internal user2 = 0x537C8f3d3E18dF5517a58B3fB9D9143697996802;
    address internal user3 = 0xc0A55e2205B289a967823662B841Bd67Aa362Aec;
    address[] internal users;

    address internal actor = address(this);

    address internal vault = address(0x1337);

    modifier asActor {
        vm.prank(actor);
        _;
    }

    modifier stateless {
        _;
        revert("Setup: state changes not allowed");
    }

    function setup() internal virtual override {
        users.push(user1);
        users.push(user2);
        users.push(user3);

        rewardsManager = new RewardsManager();
    }

    function _getRandomUser(uint256 seed) internal view returns (address) {
        return users[seed % users.length];
    }

    function _switchActor(uint256 seed) internal {
        actor = _getRandomUser(seed);
    }

    function _switchToOZ() internal {
        token = IERC20Extended(address(new OZToken()));
        token.approve(address(rewardsManager), type(uint256).max);
    }

    function _switchToSLMT() internal {
        token = IERC20Extended(address(new SLMTToken()));
        token.approve(address(rewardsManager), type(uint256).max);
    }

    function _switchToFOT() internal {
        token = IERC20Extended(address(new FOTToken()));
        token.approve(address(rewardsManager), type(uint256).max);
    }

    function _switchToSLDY() internal {
        token = IERC20Extended(address(new SLDYToken()));
        token.approve(address(rewardsManager), type(uint256).max);
    }

    function _switchToUSDT() internal {
        token = IERC20Extended(0xdAC17F958D2ee523a2206206994597C13D831ec7);
        vm.prank(0xF977814e90dA44bFA03b6295A0616a897441aceC); // binance hot wallet (mimicking Mint)
        token.transfer(actor, 1000000 ether);
        token.approve(address(rewardsManager), type(uint256).max);
    }

    function _switchToStETH() internal {
        token = IERC20Extended(address(new StETHToken()));
        token.approve(address(rewardsManager), type(uint256).max);
    }
}
