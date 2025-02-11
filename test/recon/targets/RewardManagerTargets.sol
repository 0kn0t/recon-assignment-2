// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {RewardsManager} from "../../../src/RewardsManager.sol";
import {Properties} from "../Properties.sol";
import {Setup} from "../Setup.sol";
import {ActorManager} from "../managers/ActorManager.sol";
import {TokenManager} from "../managers/TokenManager.sol";
import {VaultManager} from "../managers/VaultManager.sol";
import {BaseTargetFunctions} from "@chimera/BaseTargetFunctions.sol";


abstract contract RewardManagerTargets is BaseTargetFunctions, Properties {
    function rewardsManager_accrueUser(uint256 epochId) public asActor {
        rewardsManager.accrueUser(epochId, vault, actor);
    }

    function rewardsManager_accrueUser_clamped(uint256 epochId) public {
        epochId %= currentEpoch;
        rewardsManager_accrueUser(epochId);
    }

    function rewardsManager_accrueVault(uint256 epochId) public asActor {
        rewardsManager.accrueVault(epochId, vault);
    }

    function rewardsManager_accrueVault_clamped(uint256 epochId) public {
        epochId %= currentEpoch;
        rewardsManager_accrueVault(epochId);
    }

    function rewardsManager_addBulkRewards(uint256 epochStart, uint256 epochEnd, uint256[] memory amounts) public asActor {
        rewardsManager.addBulkRewards(epochStart, epochEnd, vault, token, amounts);
        for (uint256 i = 0; i < amounts.length; i++) {
            if (amounts[i] > 0) {
                if (epochEnd > maxEpoch) {
                    maxEpoch = epochEnd;
                }
                if (epochStart < minEpoch) {
                    minEpoch = epochStart;
                }
            }
        }
    }

    function rewardsManager_addBulkRewards_clamped(uint256 epochStart, uint256[] memory amounts) public {
        uint epochEnd = epochStart + amounts.length - 1;
        rewardsManager_addBulkRewards(epochStart, epochEnd, amounts);
        for (uint256 i = 0; i < amounts.length; i++) {
            if (amounts[i] > 0) {
                if (epochStart + i > maxEpoch) {
                    maxEpoch = epochStart + i;
                }
                if (epochStart + i < minEpoch) {
                    minEpoch = epochStart + i;
                }
            }
        }
    }

    function rewardsManager_addBulkRewardsLinearly(uint256 epochStart, uint256 epochEnd, uint256 total) public asActor {
        rewardsManager.addBulkRewardsLinearly(epochStart, epochEnd, vault, token, total);
        if (total > 0) {
            if (epochEnd > maxEpoch) {
                maxEpoch = epochEnd;
            }
            if (epochStart < minEpoch) {
                minEpoch = epochStart;
            }
        }
    }

    function rewardsManager_addReward(uint256 epochId, uint256 amount) public asActor {
        rewardsManager.addReward(epochId, vault, token, amount);
        if (amount > 0) {
            if (epochId > maxEpoch) {
                maxEpoch = epochId;
            }
            if (epochId < minEpoch) {
                minEpoch = epochId;
            }
        }
    }

    function rewardsManager_claimBulkTokensOverMultipleEpochs(uint256 epochStart, uint256 epochEnd, address[] memory tokens, address actor) public asActor {
        rewardsManager.claimBulkTokensOverMultipleEpochs(epochStart, epochEnd, vault, tokens, actor);
    }

    function rewardsManager_claimBulkTokensOverMultipleEpochs_clamped(uint256 epochStart, uint256 epochEnd, uint8 seed) public {
        epochStart = between(epochStart, minEpoch, maxEpoch);
        epochEnd = between(epochEnd, epochStart, maxEpoch);
        uint256 length = seed % tokens.length;
        address[] memory tokens = new address[](length);
        for (uint256 i = 0; i < length; i++) {
            tokens[i] = _getRandomToken(seed + i);
        }
        address actor = _getRandomUser(seed);
        rewardsManager_claimBulkTokensOverMultipleEpochs(epochStart, epochEnd, tokens, actor);
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

    function rewardsManager_claimRewardReferenceEmitting_clamped(uint256 epochId, uint256 seed) public {
        epochId = between(epochId, minEpoch, maxEpoch);
        address actor = _getRandomUser(seed);
        rewardsManager_claimRewardReferenceEmitting(epochId, actor);
    }

    function rewardsManager_claimRewards(uint256[] memory epochsToClaim, address[] memory vaults, address[] memory tokens, address[] memory users) public asActor {
        rewardsManager.claimRewards(epochsToClaim, vaults, tokens, users);
    }

    function rewardsManager_claimRewards_clamped(uint256[] memory epochsToClaim, uint8 seed) public {
        uint256 length = epochsToClaim.length;
        uint256[] memory toClaim = new uint256[](length);
        for (uint256 i = 0; i < length; i++) {
            toClaim[i] = epochsToClaim[i] % rewardsManager.currentEpoch();
        }
        address[] memory vaults = new address[](length);
        for (uint256 i = 0; i < length; i++) {
            vaults[i] = _getRandomVault(seed + i);
        }
        address[] memory tokens = new address[](length);
        for (uint256 i = 0; i < length; i++) {
            tokens[i] = _getRandomToken(seed + i);
        }
        address[] memory users = new address[](length);
        for (uint256 i = 0; i < length; i++) {
            users[i] = _getRandomVault(seed + i);
        }
        rewardsManager_claimRewards(toClaim, vaults, tokens, users);
    }

    function rewardsManager_notifyTransfer(address from, address to, uint256 amount) public asVault {
        rewardsManager.notifyTransfer(from, to, amount);
    }

    function rewardsManager_notifyTransfer_clamped1(uint256 amount) public {
        rewardsManager_notifyTransfer(address(0), actor, amount);
    }

    function rewardsManager_notifyTransfer_clamped2(uint256 amount) public {
        rewardsManager_notifyTransfer(actor, address(0), amount);
    }

    function rewardsManager_notifyTransfer_clamped3(uint256 amount, uint256 seed) public {
        address to = _getRandomUser(seed);
        rewardsManager_notifyTransfer(actor, to, amount);
    }

    function rewardsManager_reap(RewardsManager.OptimizedClaimParams memory params) public asActor {
        rewardsManager.reap(params);
    }

    function rewardsManager_reap_clamped(uint256 epochStart, uint256 epochEnd, uint8 seed) public {
        epochStart = between(epochStart, minEpoch, maxEpoch);
        epochEnd = between(epochEnd, epochStart, maxEpoch);
        uint256 length = seed % tokens.length;
        address[] memory tokens = new address[](length);
        for (uint256 i = 0; i < length; i++) {
            tokens[i] = _getRandomToken(seed + i);
        }
        RewardsManager.OptimizedClaimParams memory params = RewardsManager.OptimizedClaimParams({
            epochStart: epochStart,
            epochEnd: epochEnd,
            vault: vault,
            tokens: tokens
        });
        rewardsManager_reap(params);
    }

    function rewardsManager_tear(RewardsManager.OptimizedClaimParams memory params) public asActor {
        rewardsManager.tear(params);
    }


    function rewardsManager_tear_clamped(uint256 epochStart, uint256 epochEnd, uint8 seed) public {
        epochStart = between(epochStart, minEpoch, maxEpoch);
        epochEnd = between(epochEnd, epochStart, maxEpoch);
        uint256 length = seed % tokens.length;
        address[] memory tokens = new address[](length);
        for (uint256 i = 0; i < length; i++) {
            tokens[i] = _getRandomToken(seed + i);
        }
        RewardsManager.OptimizedClaimParams memory params = RewardsManager.OptimizedClaimParams({
            epochStart: epochStart,
            epochEnd: epochEnd,
            vault: vault,
            tokens: tokens
        });
        rewardsManager_tear(params);
    }
}