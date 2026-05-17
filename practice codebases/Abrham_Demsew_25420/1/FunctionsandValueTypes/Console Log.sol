pragma solidity ^0.8.20;

import "forge-std/console.sol";

contract Contract {
	function winningNumber(string calldata message) external returns (uint) {
		console.log(message);

		bytes memory data = bytes(message);
		uint result = 0;
		bool found = false;
		for (uint i = 0; i < data.length; i++) {
			uint8 c = uint8(data[i]);
			if (c >= 48 && c <= 57) {
				found = true;
				result = result * 10 + (c - 48);
			} else if (found) {
				break;
			}
		}

		return result;
	}
}
