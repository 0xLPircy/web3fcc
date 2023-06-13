// SPDX-License-Identifier: MIT
pragma solidity >=0.8.7;

contract SimpleStorage{
    uint256 public favoriteNumber;
    People public person = People({favoriteNumber:2, name:"Jane"});

    struct People{
        uint256 favoriteNumber;
        string name;
    }

    uint256[] favoriteNumbersList;
    People[] public people;

    function store (uint256 _favoriteNumber) public {
        favoriteNumber = _favoriteNumber;
    }

    function retrieve() public view returns(uint256){
        return favoriteNumber;
    }

}