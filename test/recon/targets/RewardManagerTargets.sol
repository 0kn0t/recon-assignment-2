// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Properties} from "../Properties.sol";
import {BaseTargetFunctions} from "@chimera/BaseTargetFunctions.sol";
import {Authorization, Signature} from "src/interfaces/IMorpho.sol";


abstract contract MorphoTargets is BaseTargetFunctions, Properties {
    /**
     * ADMIN FUNCTIONS
     */
    function morpho_createMarket() public asAdmin withMarketParams {
        morpho.createMarket(marketParams);
    }

    function morpho_accrueInterest() public withMarketParams {
        morpho.accrueInterest(marketParams);
    }

    function morpho_enableIrm() public asAdmin {
        morpho.enableIrm(address(irm));
    }

    function morpho_enableLltv(uint256 _lltv) public asAdmin {
        morpho.enableLltv(_lltv);
        lltv = _lltv;
    }

    function morpho_setFee(uint256 newFee) public withMarketParams asAdmin {
        morpho.setFee(marketParams, newFee);
    }

    function morpho_setFeeRecipient(address newFeeRecipient) public asAdmin {
        morpho.setFeeRecipient(newFeeRecipient);
    }

    function morpho_setOwner(address newOwner) public asAdmin stateless {
        morpho.setOwner(newOwner);
    }

    /*
     * ACTOR FUNCTIONS
     */
    function morpho_supply(uint256 assets, uint256 shares) public asActor withMarketParams {
        morpho.supply(marketParams, assets, shares, actor, hex"");
    }

    function morpho_supply_clamped_assets(uint256 assets) public {
        morpho_supply(assets, 0);
    }

    function morpho_supply_clamped_shares(uint256 shares) public {
        morpho_supply(0, shares);
    }

    function morpho_supplyCollateral(uint256 assets) public asActor withMarketParams {
        morpho.supplyCollateral(marketParams, assets, actor, hex"");
    }

    function morpho_withdraw(uint256 assets, uint256 shares) public asActor withMarketParams {
        morpho.withdraw(marketParams, assets, shares, actor, actor);
    }

    function morpho_withdraw_clamped_assets(uint256 assets) public {
        morpho_withdraw(assets, 0);
    }

    function morpho_withdraw_clamped_shares(uint256 shares) public {
        morpho_withdraw(0, shares);
    }

    function morpho_withdrawCollateral(uint256 assets) public asActor withMarketParams {
        morpho.withdrawCollateral(marketParams, assets, actor, actor);
    }

    function morpho_borrow(uint256 assets, uint256 shares) public asActor withMarketParams {
        morpho.borrow(marketParams, assets, shares, actor, actor);
    }

    function morpho_borrow_clamped_assets(uint256 assets) public {
        morpho_borrow(assets, 0);
    }

    function morpho_borrow_clamped_shares(uint256 shares) public {
        morpho_borrow(0, shares);
    }

    function morpho_repay(uint256 assets, uint256 shares) public asActor withMarketParams {
        morpho.repay(marketParams, assets, shares, actor, hex"");
    }

    function morpho_repay_clamped_assets(uint256 assets) public {
        morpho_repay(assets, 0);
    }

    function morpho_repay_clamped_shares(uint256 shares) public {
        morpho_repay(0, shares);
    }

    function morpho_setAuthorization(address authorized, bool newIsAuthorized) public asActor {
        morpho.setAuthorization(authorized, newIsAuthorized);
    }

    function morpho_setAuthorizationWithSig(Authorization memory authorization, Signature memory signature) public asActor {
        morpho.setAuthorizationWithSig(authorization, signature);
    }

    function morpho_flashLoan(uint256 assets) public asActor {
        morpho.flashLoan(address(loan), assets, hex"11");
    }

    function morpho_liquidate(address borrower, uint256 seizedAssets, uint256 repaidShares) public asActor withMarketParams {
        morpho.liquidate(marketParams, borrower, seizedAssets, repaidShares, hex"");
    }


    function morpho_liquidate_clamped_assets(uint256 seed, uint256 seizedAssets) public {
        address borrower = _getRandomUser(seed);
        morpho_liquidate(borrower, seizedAssets, 0);
    }

    function morpho_liquidate_clamped_shares(uint256 seed, uint256 repaidShares) public {
        address borrower = _getRandomUser(seed);
        morpho_liquidate(borrower, 0, repaidShares);
    }

    function morpho_liquidate_doomsday(uint256 seed) public stateless {
        address borrower = _getRandomUser(seed);
        (,uint256 borrowShares, uint256 collateral) = morpho.position(_getMarketId(), borrower);
        precondition(borrowShares > 0);
        oracle.setPrice(1);
        morpho_liquidate(borrower, collateral, 0);
    }
}