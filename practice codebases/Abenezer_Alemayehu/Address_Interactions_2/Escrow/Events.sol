// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract Escrow {
    address public depositor;
    address public beneficiary;
    address public arbiter;

    event Approved(uint);

    constructor(address _arbiter, address _beneficiary) payable {
        depositor = msg.sender;
        arbiter = _arbiter;
        beneficiary = _beneficiary;
    }

    function approve() external {
        require(msg.sender == arbiter, "Only the arbiter can approve");
        uint balance = address(this).balance;
        (bool success, ) = beneficiary.call{value: balance}("");
        require(success, "Transfer failed");
        emit Approved(balance);
    }
}
