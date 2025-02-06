// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Properties} from "../Properties.sol";
import {ActorManager} from "../managers/ActorManager.sol";
import {TokenManager} from "../managers/TokenManager.sol";
import {BaseTargetFunctions} from "@chimera/BaseTargetFunctions.sol";
import {IERC20} from "@openzeppelin/token/ERC20/IERC20.sol";

interface IERC20Extended is IERC20 {
    function mint(address to, uint256 amount) external;
}


abstract contract TokenTargets is BaseTargetFunctions, Properties {
    function token_approve(address spender, uint256 amount) public asActor {
        IERC20Extended(token).approve(spender, amount);
    }

    function token_mint(address _to, uint256 _amount) public asAdmin {
        IERC20Extended(token).mint(_to, _amount);
    }

    function token_transfer(address to, uint256 amount) public asActor {
        IERC20Extended(token).transfer(to, amount);
    }
}