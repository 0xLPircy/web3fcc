// Get funds
// withdraw funds
// set minimum fund walue

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

// import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
import "./PriceConverter.sol";

contract FundMe {
    using PriceConverter for uint256;

    uint256 public minimumUsd = 50 * 1e18;
    // use oracle network to find etherium in terms of usd vice versa

    address[] public funders;
    mapping(address => uint256) public addressToAmountFunded;

    // setting up owner of contract
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    function fund() public payable {
        // set minimum fund amount in usd
        require(
            msg.value.getConversionRate() >= minimumUsd,
            "didnt send enough"
        ); //1e18 == 10^18 == 1000000000000000000
        // msg.value is how much they sent with the function in terms of etherium
        // msg.value is 18 decimal places cause wei
        // so gives 1000000000000000000 wei meaning 1 ether

        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = msg.value;
    }

    function withdraw() public {
        // for loop
        for (
            uint256 funderIndex = 0;
            funderIndex < funders.length;
            funderIndex++
        ) {
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }

        // reset the array
        funders = new address[](0);
        // blank new array with 0 objects

        // // Transfer
        // payable(msg.sender).transfer(address(this).balance);
        // // msg.sender -> address
        // // payable(msg.sender) -> payable address

        // // Send
        // bool sendSuccess = payable(msg.sender).send(address(this).balance);
        // require(sendSuccess, "Send Failed");

        // Call
        (bool callSuccess, ) = payable(msg.sender).call{
            value: address(this).balance
        }("");
        require(callSuccess, "Call Failed");
    }
}
