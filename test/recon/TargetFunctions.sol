// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

import {vm} from "@chimera/Hevm.sol";
import {Setup} from "./Setup.sol";
import {RewardManagerTargets} from "./targets/RewardManagerTargets.sol";

abstract contract TargetFunctions is RewardManagerTargets {
    function switch_actor(uint256 seed) public {
        _switchActor(seed);
    }

    function switch_token(uint256 seed) public asActor {
        _switchToken(seed);
    }

    function switch_vault(uint256 seed) public asActor {
        _switchVault(seed);
    }

    function changeEpoch(uint256 epochNumber) public {
        currentEpoch = epochNumber + 1;
        vm.warp(rewardsManager.DEPLOY_TIME() + epochNumber * rewardsManager.SECONDS_PER_EPOCH());
    }
}
