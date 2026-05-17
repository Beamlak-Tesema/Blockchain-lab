// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Contract {
    address public charity;

    constructor(address _charity) payable {
        charity = _charity;
    }

    receive() external payable {

    }

    function donate() external {
        selfdestruct(payable(charity));
    }
}