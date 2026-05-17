pragma solidity 0.8.20;

contract Contract {
	function sum(uint[5] calldata numbers) external pure returns (uint) {
		uint total;
		for (uint i = 0; i < numbers.length; i++) {
			total += numbers[i];
		}
		return total;
	}
}