// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

import {vm} from "@chimera/Hevm.sol";
import {RewardsManager} from "../../src/RewardsManager.sol";
import {ActorManager} from "./managers/ActorManager.sol";
import {TokenManager} from "./managers/TokenManager.sol";
import {VaultManager} from "./managers/VaultManager.sol";
import {BaseSetup} from "@chimera/BaseSetup.sol";


abstract contract Setup is BaseSetup, ActorManager, TokenManager, VaultManager {
    RewardsManager internal rewardsManager;

    uint256 internal minEpoch;
    uint256 internal maxEpoch;
    uint256 internal currentEpoch;

    function setup() internal virtual override {
        _setupActors();
        _setupVaults();
        rewardsManager = new RewardsManager();

        address[] memory approveTo = new address[](1);
        approveTo[0] = address(rewardsManager);
        _setupTokens(users, vaults, approveTo);
    }
    modifier asAdmin {
        vm.prank(address(this));
        _;
    }

    modifier asActor {
        vm.prank(actor);
        _;
    }

    modifier asVault {
        vm.prank(vault);
        _;
    }
}
