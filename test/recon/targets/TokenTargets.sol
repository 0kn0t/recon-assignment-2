// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {BaseTargetFunctions} from "@chimera/BaseTargetFunctions.sol";
import {Properties} from "../Properties.sol";
import {vm} from "@chimera/Hevm.sol";


abstract contract TokenTargets is BaseTargetFunctions, Properties {
  function token_approve(address spender, uint256 amount) public asActor {
        token.approve(spender, amount);
    }

    function token_mint(address _to, uint256 _amount) public asAdmin {
        token.mint(_to, _amount);
    }

    function token_transfer(address to, uint256 amount) public asActor {
        token.transfer(to, amount);
    }

    function token_transferFrom(address from, address to, uint256 amount) public asActor {
        token.transferFrom(from, to, amount);
    }
}