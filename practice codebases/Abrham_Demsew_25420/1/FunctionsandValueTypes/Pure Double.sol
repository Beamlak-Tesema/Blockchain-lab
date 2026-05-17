pragma solidity ^0.8.20;

contract Contract {
	function double(uint value) external pure returns (uint) {
		return value * 2;
	}
}
