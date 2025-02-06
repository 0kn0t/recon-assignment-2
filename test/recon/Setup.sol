// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

import {RewardsManager} from "../../src/RewardsManager.sol";
import {ActorManager} from "./managers/ActorManager.sol";
import {TokenManager} from "./managers/TokenManager.sol";
import {VaultManager} from "./managers/VaultManager.sol";
import {BaseSetup} from "@chimera/BaseSetup.sol";


abstract contract Setup is BaseSetup, ActorManager, TokenManager, VaultManager {
    RewardsManager internal rewardsManager;

    function setup() internal virtual override {
        _setupActors();
        _setupTokens();
        _setupVaults();
        rewardsManager = new RewardsManager();
    }
}
