// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

import {vm} from "@chimera/Hevm.sol";

abstract contract VaultManager {
    address internal vault1 = address(0x1337);
    address internal vault2 = address(0x1338);
    address internal vault3 = address(0x1339);
    address internal vault4 = address(0x133A);
    address[] internal vaults;

    address internal vault = vault1;

    function _setupVaults() internal {
        vaults.push(vault1);
        vm.label(vault1, "vault1");
        vaults.push(vault2);
        vm.label(vault2, "vault2");
        vaults.push(vault3);
        vm.label(vault3, "vault3");
        vaults.push(vault4);
        vm.label(vault4, "vault4");
    }

    function _getRandomVault(uint256 seed) internal view returns (address) {
        return vaults[seed % vaults.length];
    }

    function _switchVault(uint256 seed) internal {
        vault = _getRandomVault(seed);
    }
}
