pragma solidity 0.8.20;

contract Contract {
	function filterEven(uint[] calldata values) external pure returns (uint[] memory) {
		uint count = 0;
		for (uint i = 0; i < values.length; i++) {
			if (values[i] % 2 == 0) {
				count++;
			}
		}

		uint[] memory evens = new uint[](count);
		uint index = 0;
		for (uint i = 0; i < values.length; i++) {
			if (values[i] % 2 == 0) {
				evens[index] = values[i];
				index++;
			}
		}

		return evens;
	}
}