pragma solidity ^0.8.20;

contract Contract {
	address public owner;

	constructor() {
		owner = msg.sender;
	}

	function tip() public payable {
		(bool success, ) = owner.call{ value: msg.value }("");
		require(success, "Transfer failed");
	}

	receive() external payable {}
}
