pragma solidity ^0.8.20;

contract Contract {
	address payable private owner;

	constructor() payable {
		owner = payable(msg.sender);
		require(msg.value >= 1 ether, "At least 1 ether required");
	}

	function withdraw() public {
		require(msg.sender == owner, "Only owner can withdraw");
		(bool success, ) = owner.call{value: address(this).balance}("");
		require(success, "Withdraw failed");
	}
}