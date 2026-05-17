pragma solidity ^0.8.20;

contract Contract {
	mapping(address => bool) public members;

	function addMember(address account) external {
		members[account] = true;
	}

	function isMember(address account) external view returns (bool) {
		return members[account];
	}
}