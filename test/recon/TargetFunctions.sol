// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

import {Setup} from "./Setup.sol";
import {RewardManagerTargets} from "./targets/RewardManagerTargets.sol";
import {TokenTargets} from "./targets/TokenTargets.sol";

abstract contract TargetFunctions is RewardManagerTargets, TokenTargets {
    function switch_actor(uint256 seed) public {
        _switchActor(seed);
    }

    function switchToOZ() public asActor {
        _switchToOZ();
    }

    function switchToSLMT() public asActor {
        _switchToSLMT();
    }

    function switchToSLDY() public asActor {
        _switchToSLDY();
    }

    function switchToFOT() public asActor {
        _switchToFOT();
    }

    function switchToUSDT() public asActor {
        _switchToUSDT();
    }

    function switchToStETH() public asActor {
        _switchToStETH();
    }
}
