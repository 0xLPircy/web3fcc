// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol"; 

library PriceConverter{
    function getPrice(AggregatorV3Interface priceFeed) internal view returns(uint256) {
        // // interactimg with a contract outside our project so we need
        // // ABI 
        // // Address 0x694AA1769357215DE4FAC081bf1f309aDC325306
        // AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306); //this address is different for diff chains cause similar function but diff ways
        (, int price, , ,) = priceFeed.latestRoundData(); //pricefeed named contract of type aggregator with function latestRoundData
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

    function getConversionRate(uint256 ethAmount, AggregatorV3Interface priceFeed) internal view returns(uint256){
        uint256 ethPrice = getPrice(priceFeed);
        // eath amount also has 18 extra zeros
        uint256 ethAmountInUsd = (ethPrice *ethAmount) / 1e18;
        //  div by 1e18 to not have 36 zeros after multiplication
        return ethAmountInUsd;
    }
}