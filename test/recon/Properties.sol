// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

import {Asserts} from "@chimera/Asserts.sol";
import {BeforeAfter} from "./BeforeAfter.sol";

abstract contract Properties is BeforeAfter, Asserts {
    function invariant_total_supply() public returns (bool) {
        // Shares Sum to Total Supply
        uint sharesSum;
        for(uint i = 0; i < users.length; i++) {
            address user = users[i];
            sharesSum += rewardsManager.shares(currentEpoch, vault, user);
        }
        return sharesSum == rewardsManager.totalSupply(currentEpoch, vault);
    }


}
