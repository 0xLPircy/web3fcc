// get funds
// withdraw funds
// set minimum fund walue

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

contract FundMe {
      uint256 public number;
    function fund() public payable {
        
        // set minimum fund amount in usd
        require(msg.value > 1e18, "didnt send enough"); //1e18 == 10^18 == 1000000000000000000
    }

    // function withdraw(){}
}