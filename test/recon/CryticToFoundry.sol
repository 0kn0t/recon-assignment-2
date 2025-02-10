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
        // TODO: add failing property tests here for debugging
        uint256[] memory amounts = new uint256[](3);
        amounts[0] = 100000;
        amounts[1] = 200000;
        amounts[2] = 300000;
        rewardsManager_addBulkRewards_clamped(100, amounts);
    }
}
