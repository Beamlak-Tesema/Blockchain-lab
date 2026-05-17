pragma solidity 0.8.20;

contract Contract {
	uint[] public evenNumbers;

	function filterEven(uint[] calldata values) external {
		for (uint i = 0; i < values.length; i++) {
			if (values[i] % 2 == 0) {
				evenNumbers.push(values[i]);
			}
		}
	}
}