// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

import {BeforeAfter} from "./BeforeAfter.sol";
import {Setup} from "./Setup.sol";
import {ActorManager} from "./managers/ActorManager.sol";
import {VaultManager} from "./managers/VaultManager.sol";
import {Asserts} from "@chimera/Asserts.sol";


abstract contract Properties is BeforeAfter, Asserts {
    function invariant_total_supply() public returns (bool) {
        // total supply = sum of all user points in a given epoch
        uint256 currentEpoch = rewardsManager.currentEpoch();
        uint sharesSum;
        for (uint i = 0; i < users.length; i++) {
            address user = users[i];
            sharesSum += rewardsManager.shares(currentEpoch, vault, user);
        }
        return sharesSum <= rewardsManager.totalSupply(currentEpoch, vault);
    }

    function invariant_user_shares() public returns (bool) {
        uint256 currentEpoch = rewardsManager.currentEpoch();
        uint pointsSum;
        for (uint i = 0; i < users.length; i++) {
            address user = users[i];
            pointsSum += rewardsManager.points(currentEpoch, vault, user);
        }
        return pointsSum <= rewardsManager.totalPoints(currentEpoch, vault);
    }

    function invariant_points_withdrawn() public returns (bool) {
        if (_before.actorPointsWithdrawn != _after.actorPointsWithdrawn) {
            return _before.actorPoints + _before.actorPointsWithdrawn == _after.actorPoints + _after.actorPointsWithdrawn;
        }
        return true;
    }

    function invariant_correct_receive_amount() public returns (bool) {
        // actor received correct amount of reward
        if (_after.currentTotalPoints > 0) {
            uint expectedRewards = _after.currentRewards * _after.actorPoints / _after.currentTotalPoints;
            uint actualRewards = _after.actorTokenBalance - _before.actorTokenBalance;
            return expectedRewards == actualRewards;
        }
        return true;
    }


    function invariant_soundness() public returns (bool) {
        // if I have 100% of the shares, I should have 100% of the rewards
        if (_after.actorPoints == _after.currentTotalPoints) {
            return _after.currentTotalSupply == _after.actorShares;
        }
        return true;
    }
}

// Global property:
// grab two public variables and compare them
// Sum of public variables and compare them

// state changing property:
// mostly look like unit tests
// property that I received correct amount of reward
// property that I received correct percentage ownership of a token
// soundness property: if I have 100% of the shares, I should have 100% of the rewards
// everybody can withdraw and system is insolvent