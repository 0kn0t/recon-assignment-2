// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {vm} from "@chimera/Hevm.sol";
import {RewardsManager} from "../../../src/RewardsManager.sol";
import {Properties} from "../Properties.sol";
import {Setup} from "../Setup.sol";
import {BaseTargetFunctions} from "@chimera/BaseTargetFunctions.sol";


abstract contract RewardManagerTargets is BaseTargetFunctions, Properties {
    function rewardsManager_accrueUser(uint256 epochId) public asActor {
        rewardsManager.accrueUser(epochId, vault, actor);
    }

    function rewardsManager_accrueVault(uint256 epochId) public asActor {
        rewardsManager.accrueVault(epochId, vault);
    }

    function rewardsManager_addBulkRewards(uint256 epochStart, uint256 epochEnd, uint256[] memory amounts) public asActor {
        rewardsManager.addBulkRewards(epochStart, epochEnd, vault, token, amounts);
    }

    function rewardsManager_addBulkRewards_clamped(uint256 epochStart, uint256 windowLength, uint256[] memory amounts) public asActor {
        uint epochEnd = epochStart + windowLength;
        uint256[] memory clampedAmounts = new uint256[](windowLength + 1);
        for (uint256 i = 0; i < windowLength + 1; i++) {
            clampedAmounts[i] = amounts[i];
        }
        rewardsManager_addBulkRewards(epochStart, epochEnd, amounts);
    }

    function rewardsManager_addBulkRewardsLinearly(uint256 epochStart, uint256 epochEnd, uint256 total) public asActor {
        rewardsManager.addBulkRewardsLinearly(epochStart, epochEnd, vault, token, total);
    }

    function rewardsManager_addReward(uint256 epochId, uint256 amount) public asActor {
        rewardsManager.addReward(epochId, vault, token, amount);
    }

    function rewardsManager_claimBulkTokensOverMultipleEpochs(uint256 epochStart, uint256 epochEnd, address[] memory tokens, address actor) public asActor {
        rewardsManager.claimBulkTokensOverMultipleEpochs(epochStart, epochEnd, vault, tokens, actor);
    }

    function rewardsManager_claimReward(uint256 epochId) public asActor {
        rewardsManager.claimReward(epochId, vault, token, actor);
    }

    function rewardsManager_claimRewardEmitting(uint256 epochId) public asActor {
        rewardsManager.claimRewardEmitting(epochId, vault, token, actor);
    }

    function rewardsManager_claimRewardReferenceEmitting(uint256 epochId, address actor) public asActor {
        rewardsManager.claimRewardReferenceEmitting(epochId, vault, token, actor);
    }

    function rewardsManager_claimRewards(uint256[] memory epochsToClaim, address[] memory vaults, address[] memory tokens, address[] memory users) public asActor {
        rewardsManager.claimRewards(epochsToClaim, vaults, tokens, users);
    }

    function rewardsManager_notifyTransfer(address from, address to, uint256 amount) public asActor {
        rewardsManager.notifyTransfer(from, to, amount);
    }

    function rewardsManager_notifyTransfer_clamped(uint256 amount, uint256 seed1, uint256 seed2) public {
        address from = _getRandomVault(seed1);
        address to = _getRandomVault(seed2);
        rewardsManager_notifyTransfer(from, to, amount);
    }

    function rewardsManager_reap(RewardsManager.OptimizedClaimParams memory params) public asActor {
        rewardsManager.reap(params);
    }

    function rewardsManager_tear(RewardsManager.OptimizedClaimParams memory params) public asActor {
        rewardsManager.tear(params);
    }
}