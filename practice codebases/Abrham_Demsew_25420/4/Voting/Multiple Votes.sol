pragma solidity ^0.8.20;

contract Voting {
    struct Proposal {
        address target;
        bytes data;
        uint yesCount;
        uint noCount;
    }

    Proposal[] public proposals;
    mapping(uint => mapping(address => uint8)) private votes;

    function newProposal(address target, bytes calldata data) external {
        Proposal memory proposal = Proposal({
            target: target,
            data: data,
            yesCount: 0,
            noCount: 0
        });

        proposals.push(proposal);
    }

    function castVote(uint proposalId, bool inSupport) external {
        Proposal storage proposal = proposals[proposalId];
        uint8 previous = votes[proposalId][msg.sender];
        uint8 current = inSupport ? 1 : 2;

        if (previous == current) {
            return;
        }

        if (previous == 1) {
            proposal.yesCount--;
        } else if (previous == 2) {
            proposal.noCount--;
        }

        if (current == 1) {
            proposal.yesCount++;
        } else {
            proposal.noCount++;
        }

        votes[proposalId][msg.sender] = current;
    }
}
