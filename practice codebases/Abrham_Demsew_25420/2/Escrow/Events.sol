pragma solidity 0.8.20;

contract Escrow {
	address public depositor;
	address public beneficiary;
	address public arbiter;

	event Approved(uint amount);

	constructor(address _arbiter, address _beneficiary) payable {
		depositor = msg.sender;
		arbiter = _arbiter;
		beneficiary = _beneficiary;
	}

	function approve() external {
		require(msg.sender == arbiter, "Only arbiter");
		uint amount = address(this).balance;
		(bool success, ) = beneficiary.call{value: amount}("");
		require(success);
		emit Approved(amount);
	}
}