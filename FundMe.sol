// get funds
// withdraw funds
// set minimum fund walue

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

contract FundMe {
    uint256 public number;
    uint256 public minimumUsd = 50;
    // use oracle network to find etherium in terms of usd vice versa
    function fund() public payable {
        
        // set minimum fund amount in usd
        require(msg.value >= 1e18, "didnt send enough"); //1e18 == 10^18 == 1000000000000000000
        // msg.value is how much they sent with the function in terms of etherium
    }

    // function withdraw(){}
}