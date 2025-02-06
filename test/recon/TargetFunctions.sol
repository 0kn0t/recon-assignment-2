// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

import {Setup} from "./Setup.sol";
import {RewardManagerTargets} from "./targets/RewardManagerTargets.sol";
import {TokenTargets} from "./targets/TokenTargets.sol";

abstract contract TargetFunctions is RewardManagerTargets, TokenTargets {
    function switch_actor(uint256 seed) public {
        _switchActor(seed);
    }

    function switch_token(uint256 seed) public asActor {
        _switchToken(seed);
    }

    function switch_vault(uint256 seed) public asActor {
        _switchVault(seed);
    }
}
