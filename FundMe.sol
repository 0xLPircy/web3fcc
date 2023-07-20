// Get funds
// withdraw funds
// set minimum fund walue

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
import "./PriceConverter.sol";

error NotOwner();

contract FundMe {
    using PriceConverter for uint256;

    uint256 public constant minimumUsd = 50 * 1e18;     // use oracle network to find etherium in terms of usd vice versa
    //  constant: 841,980 -> 822,426
    // calling: 2407 -> 307

    address[] public funders;
    mapping(address => uint256) public addressToAmountFunded;

    // setting up owner of contract
    address public immutable i_owner;
    // 822426 -> 798955
    constructor(){
        i_owner = msg.sender;
    }

    function fund() public payable {
        
        // set minimum fund amount in usd
        require(msg.value.getConversionRate() >= minimumUsd, "didnt send enough"); //1e18 == 10^18 == 1000000000000000000
        // msg.value is how much they sent with the function in terms of etherium
        // msg.value is 18 decimal places cause wei
        // so gives 1000000000000000000 wei meaning 1 ether
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] += msg.value;
    }

    function withdraw() public onlyOwner{

        // for loop
        for (uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++){
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
        (bool callSuccess, ) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "Call Failed");

    }

    modifier onlyOwner {
        // require(msg.sender == i_owner, "Sender is not owner");
        if (msg.sender != i_owner) { revert NotOwner();}
        _;
    }

    receive() external payable {
        fund();
    }

    fallback() external payable {
        fund();
    }
}