// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {RewardsManager} from "../../../src/RewardsManager.sol";
import {Properties} from "../Properties.sol";
import {Setup} from "../Setup.sol";
import {BaseTargetFunctions} from "@chimera/BaseTargetFunctions.sol";


abstract contract RewardManagerTargets is BaseTargetFunctions, Properties {
    function rewardsManager_accrueUser(uint256 epochId) public asActor {
        rewardsManager.accrueUser(epochId, vault, actor);
        t(false, "11");
    }

    function rewardsManager_accrueVault(uint256 epochId) public asActor {
        rewardsManager.accrueVault(epochId, vault);
        t(false, "22");
    }

    function rewardsManager_addBulkRewards(uint256 epochStart, uint256 epochEnd, uint256[] memory amounts) public asActor {
        rewardsManager.addBulkRewards(epochStart, epochEnd, vault, address(token), amounts);
    }

    function rewardsManager_addBulkRewards_clamped(uint256 epochStart, uint256 epochEnd, uint256[] memory amounts) public asActor {
        uint256 totalEpochs;
        unchecked {
            totalEpochs = epochEnd - epochStart + 1;
        }
        uint256[] memory clampedAmounts = new uint256[](totalEpochs);
        for (uint256 i = 0; i < totalEpochs; i++) {
            clampedAmounts[i] = amounts[i];
        }
        rewardsManager_addBulkRewards(epochStart, epochEnd, clampedAmounts);
    }

    function rewardsManager_addBulkRewardsLinearly(uint256 epochStart, uint256 epochEnd, uint256 total) public asActor {
        rewardsManager.addBulkRewardsLinearly(epochStart, epochEnd, vault, address(token), total);
    }

    function rewardsManager_addReward(uint256 epochId, uint256 amount) public asActor {
        rewardsManager.addReward(epochId, vault, address(token), amount);
    }

    function rewardsManager_claimBulkTokensOverMultipleEpochs(uint256 epochStart, uint256 epochEnd) public asActor {
        address[] memory tokens = new address[](1);
        tokens[0] = address(token);
        rewardsManager.claimBulkTokensOverMultipleEpochs(epochStart, epochEnd, vault, tokens, actor);
    }

    function rewardsManager_claimReward(uint256 epochId) public asActor {
        rewardsManager.claimReward(epochId, vault, address(token), actor);
    }

    function rewardsManager_claimRewardEmitting(uint256 epochId) public asActor {
        rewardsManager.claimRewardEmitting(epochId, vault, address(token), actor);
    }

    function rewardsManager_claimRewardReferenceEmitting(uint256 epochId) public asActor {
        rewardsManager.claimRewardReferenceEmitting(epochId, vault, address(token), actor);
    }

    function rewardsManager_claimRewards(uint256 epochId) public asActor {
        address[] memory tokens = new address[](1);
        tokens[0] = address(token);
        address[] memory users = new address[](1);
        users[0] = actor;
        address[] memory vaults = new address[](1);
        vaults[0] = vault;
        uint256[] memory epochsToClaim = new uint256[](1);
        epochsToClaim[0] = epochId;
        rewardsManager.claimRewards(epochsToClaim, vaults, tokens, users);
    }

    function rewardsManager_notifyTransfer(address from, address to, uint256 amount) public asActor {
        rewardsManager.notifyTransfer(from, to, amount);
    }

    function rewardsManager_reap(RewardsManager.OptimizedClaimParams memory params) public asActor {
        rewardsManager.reap(params);
    }

    function rewardsManager_tear(RewardsManager.OptimizedClaimParams memory params) public asActor {
        rewardsManager.tear(params);
    }
}