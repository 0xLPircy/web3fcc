// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

library PriceConverter{
    function getPrice() internal view returns(uint256) {
        // interactimg with a contract outside our project so we need
        // ABI 
        // Address 0x694AA1769357215DE4FAC081bf1f309aDC325306
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        (, int price, , ,) = priceFeed.latestRoundData();
        //eth in terms of usd, has 8 decimal places
        // so if returns 300000000000 means 3000.00000000
        return uint256(price * 1e10); //1^10
        // so now itll be 8+10 18 just as msg.value is
        // msg.value is uint and price int so typecastong done
    }

    function getVersion () internal view returns(uint256) {
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        return priceFeed.version();
    }

    function getConversionRate(uint256 ethAmount) internal view returns(uint256){
        uint256 ethPrice = getPrice();
        // eath amount also has 18 extra zeros
        uint256 ethAmountInUsd = (ethPrice *ethAmount) / 1e18;
        //  div by 1e18 to not have 36 zeros after multiplication
        return ethAmountInUsd;
    }
}