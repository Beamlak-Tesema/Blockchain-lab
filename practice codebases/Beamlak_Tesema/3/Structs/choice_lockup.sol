pragma solidity 0.8.20;

contract Contract {
	enum Choices { Yes, No }
	
	struct Vote {
		Choices choice;
		address voter;
	}
	
	Vote[] public votes;

	function createVote(Choices choice) external {
		votes.push(Vote(choice, msg.sender));
	}

	function hasVoted(address account) external view returns (bool) {
		(bool found,) = _findVoteIndex(account);
		return found;
	}

	function findChoice(address account) external view returns (Choices) {
		(bool found, uint index) = _findVoteIndex(account);
		require(found, "Vote not found");
		return votes[index].choice;
	}

	function _findVoteIndex(address account) internal view returns (bool found, uint index) {
		for (uint i = 0; i < votes.length; i++) {
			if (votes[i].voter == account) {
				return (true, i);
			}
		}
		return (false, 0);
	}
}