pragma solidity ^0.8.20;

contract Contract {
	uint public x;

	constructor(uint _x) {
		x = _x;
	}

	function increment() external {
		x += 1;
	}

	function add(uint value) external view returns (uint) {
		return x + value;
	}
}
