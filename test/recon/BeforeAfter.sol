// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

import {Setup} from "./Setup.sol";
import {IERC20} from "@openzeppelin/token/ERC20/IERC20.sol";

// ghost variables for tracking state variable values before and after function calls
abstract contract BeforeAfter is Setup {
    struct Vars {
        uint256 epoch;
        uint256 actorTokenBalance;
        uint256 actorPoints;
        uint256 actorShares;
        uint256 actorLastAccrue;
        uint256 actorPointsWithdrawn;
        uint256 actorPointsPercentage;
        mapping(address => uint256) usersBalances;
        uint256 currentTotalSupply;
        uint256 currentTotalPoints;
    }

    Vars internal _before;
    Vars internal _after;

    modifier updateGhosts {
        __before();
        _;
        __after();
    }

    function __snapshot(Vars storage vars) internal {
        vars.epoch = rewardsManager.currentEpoch();
        vars.actorTokenBalance = IERC20(token).balanceOf(actor);
        vars.actorPoints = rewardsManager.points(rewardsManager.currentEpoch(), vault, actor);
        vars.actorShares = rewardsManager.shares(rewardsManager.currentEpoch(), vault, actor);
        vars.actorLastAccrue = rewardsManager.lastUserAccrueTimestamp(rewardsManager.currentEpoch(), vault, actor);
        vars.actorPointsWithdrawn = rewardsManager.pointsWithdrawn(rewardsManager.currentEpoch(), vault, actor, token);
        vars.actorPointsPercentage = vars.actorPoints * 10000 / rewardsManager.totalPoints(rewardsManager.currentEpoch(), vault);
        vars.currentTotalSupply = rewardsManager.totalSupply(rewardsManager.currentEpoch(), vault);
        vars.currentTotalPoints = rewardsManager.totalPoints(rewardsManager.currentEpoch(), vault);

        for (uint8 i; i < users.length; i++) {
            vars.usersBalances[users[i]] = IERC20(token).balanceOf(users[i]);
        }
    }

    function __before() internal {
        __snapshot(_before);
    }

    function __after() internal {
        __snapshot(_after);
    }
}
