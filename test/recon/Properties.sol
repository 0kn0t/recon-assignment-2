// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

import {Asserts} from "@chimera/Asserts.sol";
import {BeforeAfter} from "./BeforeAfter.sol";
import {Test, console2 as console} from "forge-std/Test.sol";


abstract contract Properties is BeforeAfter, Asserts {
//    function invariant_total_points() public returns (bool) {
//        // total points = sum of all user points in a given epoch
//        uint256 currentEpoch = rewardsManager.currentEpoch();
//        uint pointsSum;
//        for (uint i = 0; i < users.length; i++) {
//            address user = users[i];
//            pointsSum += rewardsManager.points(currentEpoch, vault, user);
//        }
//        return pointsSum == rewardsManager.totalPoints(currentEpoch, vault);
//    }
//
//
//    function invariant_user_shares() public returns (bool) {
//        uint256 currentEpoch = rewardsManager.currentEpoch();
//        uint pointsSum;
//        for (uint i = 0; i < users.length; i++) {
//            address user = users[i];
//            pointsSum += rewardsManager.points(currentEpoch, vault, user);
//        }
//        return pointsSum == rewardsManager.totalPoints(currentEpoch, vault);
//    }

    function invariant_points_withdrawn() public returns (bool) {
        if (_before.actorPointsWithdrawn != _after.actorPointsWithdrawn) {
            return _before.actorPoints + _before.actorPointsWithdrawn == _after.actorPoints + _after.actorPointsWithdrawn;
        }
        return true;
    }

    function invariant_points_percentage() public returns (bool) {
        if (_before.actorPoints > _after.actorPoints) {
            return _before.actorPointsPercentage == _after.actorPointsPercentage;
        } else if (_before.actorPoints < _after.actorPoints) {
            return _before.actorPointsPercentage == _after.actorPointsPercentage;
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