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

    function test_crytic2() public {
//        vm.warp(block.timestamp + 962939);
//
//        vm.roll(block.number + 194277);
//
//        rewardsManager_accrueVault_clamped();
//
//        vm.roll(block.number + 20112);
//        vm.warp(block.timestamp + 503421);
//        switch_actor(17035090997006960232076608967213057814198191299372836645275460291849153733323);
//
//        vm.warp(block.timestamp + 1774673);
//
//        vm.roll(block.number + 128090);
//
//        vm.roll(block.number + 9053);
//        vm.warp(block.timestamp + 112766);
//        rewardsManager_addReward(62961026262190809576807421588969090637873201314731266129821246479913087991057, 134);
//
//        vm.roll(block.number + 10650);
//        vm.warp(block.timestamp + 303345);
//        switch_token(69954786579505065321264714075232190118325507553752693682661233629284181789667);
//
//        vm.warp(block.timestamp + 1702330);
//        vm.roll(block.number + 100624);
//        rewardsManager_notifyTransfer_clamped_deposit(334688706);
//        vm.warp(block.timestamp + 1805802);
//        vm.roll(block.number + 212461);
//        rewardsManager_claimRewards_clamped([52774849457316397963239284324697259702224282141629980675057133320389995504313], 1);
//        vm.warp(block.timestamp + 5154);
//        rewardsManager_accrueUser_clamped();
//        t(invariant_total_supply(), "invariant_total_supply");
    }
}
