pragma solidity 0.8.20;

contract StackClub {
	address[] public members;

	constructor() {
		members.push(msg.sender);
	}

	modifier onlyMember() {
		require(_isMember(msg.sender), "Not a member");
		_;
	}

	function addMember(address newMember) external onlyMember {
		members.push(newMember);
	}

	function removeLastMember() external onlyMember {
		members.pop();
	}

	function isMember(address account) public view returns (bool) {
		return _isMember(account);
	}

	function _isMember(address account) internal view returns (bool) {
		for (uint i = 0; i < members.length; i++) {
			if (members[i] == account) {
				return true;
			}
		}
		return false;
	}
}
