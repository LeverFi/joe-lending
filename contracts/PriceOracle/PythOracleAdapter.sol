// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import {IPyth, PythStructs} from "./interfaces/IPyth.sol";

contract PythOracleAdapter {

    IPyth public immutable pyth;

    bytes32 public immutable assetID;

    uint8 public immutable decimals;

    constructor(IPyth pyth_, bytes32 assetID_) {
        pyth = pyth_;
        assetID = assetID_;

        PythStructs.Price memory price = pyth.getPrice(assetID);

        uint32 absExpo = uint32(price.expo * (- 1));

        require(absExpo <= type(uint8).max, "overflow exponent");

        // should be safe
        decimals = uint8(absExpo);
    }

    function latestRoundData() public view returns (
        uint80 roundId,
        int256 answer,
        uint256 startedAt,
        uint256 updatedAt,
        uint80 answeredInRound
    ) {
        // Shh, not in use
        roundId = 0;
        startedAt = 0;
        answeredInRound = 0;

        PythStructs.Price memory price = pyth.getPrice(assetID);

        answer = int256(price.price);
        updatedAt = uint256(price.publishTime);
    }
}
