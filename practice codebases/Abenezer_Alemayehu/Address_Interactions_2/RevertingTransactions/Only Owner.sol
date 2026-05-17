// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Contract {
    address public owner;

    error NotOwner(address);

    constructor() payable {
        require(msg.value >= 1 ether, "Must send at least 1 ether");
        owner = msg.sender;
    }

    function withdraw() public {
        if (msg.sender != owner) {
            revert NotOwner(msg.sender);
        }
        (bool success, ) = owner.call{value: address(this).balance}("");
        require(success, "Transfer failed");
    }
}
