// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

import {vm} from "@chimera/Hevm.sol";

abstract contract ActorManager {
    address internal user1 = address(this);
    address internal user2 = 0x537C8f3d3E18dF5517a58B3fB9D9143697996802;
    address internal user3 = 0xc0A55e2205B289a967823662B841Bd67Aa362Aec;
    address[] internal users;

    address internal actor = address(this);

    function _setupActors() internal {
        users.push(user1);
        users.push(user2);
        users.push(user3);
    }

    function _getRandomUser(uint256 seed) internal view returns (address) {
        return users[seed % users.length];
    }

    function _switchActor(uint256 seed) internal {
        actor = _getRandomUser(seed);
    }
}
