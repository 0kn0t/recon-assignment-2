// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

import {Test, console} from "forge-std/Test.sol";
import {TargetFunctions} from "./TargetFunctions.sol";
import {FoundryAsserts} from "@chimera/FoundryAsserts.sol";
import {IERC20} from "@openzeppelin/token/ERC20/IERC20.sol";

contract CryticToFoundry is Test, TargetFunctions, FoundryAsserts {
    function setUp() public {
        setup();
    }

    function test_crytic() public {
        rewardsManager_addReward(1, 1000);
        rewardsManager_notifyTransfer(address(0), actor, 100);
        rewardsManager_accrueUser(1);
        rewardsManager_accrueVault(1);
        changeEpoch(2);
        rewardsManager_claimRewardReferenceEmitting(1, actor);
    }
}
