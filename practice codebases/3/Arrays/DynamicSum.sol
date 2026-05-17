pragma solidity 0.8.20;

contract Contract {
	function sum(uint[] calldata values) external pure returns (uint total) {
		for (uint i = 0; i < values.length; i++) {
			total += values[i];
		}
	}
}