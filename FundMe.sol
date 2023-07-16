// get funds
// withdraw funds
// set minimum fund walue

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

// interface AggregatorV3Interface {
//   function decimals() external view returns (uint8);

//   function description() external view returns (string memory);

//   function version() external view returns (uint256);

//   function getRoundData(
//     uint80 _roundId
//   ) external view returns (uint80 roundId, int256 answer, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound);

//   function latestRoundData()
//     external
//     view
//     returns (uint80 roundId, int256 answer, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound);
// }

contract FundMe {
    uint256 public number;
    uint256 public minimumUsd = 50 * 1e18;
    // use oracle network to find etherium in terms of usd vice versa

    address[] public funders;
    mapping(address => uint256) public addressToAmountFunded;

    function fund() public payable {
        
        // set minimum fund amount in usd
        require(getConversionRate(msg.value) >= minimumUsd, "didnt send enough"); //1e18 == 10^18 == 1000000000000000000
        // msg.value is how much they sent with the function in terms of etherium
        // msg.value is 18 decimal places cause wei
        // so gives 1000000000000000000 wei meaning 1 ether
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender]= msg.value;
    }

    function getPrice() public view returns(uint256) {
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

    function getVersion () public view returns(uint256) {
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        return priceFeed.version();
    }

    function getConversionRate(uint256 ethAmount) public view returns(uint256){
        uint256 ethPrice = getPrice();
        // eath amount also has 18 extra zeros
        uint256 ethAmountInUsd = (ethPrice *ethAmount) / 1e18;
        //  div by 1e18 to not have 36 zeros after multiplication
        return ethAmountInUsd;
    }

    // function withdraw(){}
}