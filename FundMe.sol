// get funds
// withdraw funds
// set minimum fund walue

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";


//interface AggregatorV3Interface {
 // function decimals() external view returns (uint8);
//
  //function description() external view returns (string memory);
//
  //function version() external view returns (uint256);
//
  //function getRoundData(
    //uint80 _roundId
  //) external view returns (uint80 roundId, int256 answer, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound);
//
  //function latestRoundData()
    //external
    //view
    //returns (uint80 roundId, int256 answer, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound);
//}

contract FundMe {
    uint256 public number;
    uint256 public minimumUsd = 50;
    // use oracle network to find etherium in terms of usd vice versa
    function fund() public payable {
        
        // set minimum fund amount in usd
        require(msg.value >= 1e18, "didnt send enough"); //1e18 == 10^18 == 1000000000000000000
        // msg.value is how much they sent with the function in terms of etherium
        // 18 decimal cause wei
    }

    function getPrice() public view returns(uint256) {
        // interactimg with a contract outside our project so we need
        // ABI 
        // Address 0x694AA1769357215DE4FAC081bf1f309aDC325306
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        (, int price, , ,) = priceFeed.latestRoundData();
        //eth in terms of usd gwei format, has 8 decimal places
        return uint256(price * 1e10); //1**10
    }

    function getVersion () public view returns(uint256) {
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        return priceFeed.version();
    }

    function getConversionRate(uint256 ethAmount) public view returns(uint256){
        uint256 ethPrice = getPrice();
        uint256 ethAmountInUsd = (ethPrice *ethAmount) / 1e18;
        return ethAmountInUsd;
    }

    // function withdraw(){}
}