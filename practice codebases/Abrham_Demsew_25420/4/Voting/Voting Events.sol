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

    event ProposalCreated(uint proposalId);
    event VoteCast(uint proposalId, address voter);

    function newProposal(address target, bytes calldata data) external {
        Proposal memory proposal = Proposal({
            target: target,
            data: data,
            yesCount: 0,
            noCount: 0
        });

        proposals.push(proposal);
        emit ProposalCreated(proposals.length - 1);
    }

    function castVote(uint proposalId, bool inSupport) external {
        Proposal storage proposal = proposals[proposalId];

        if (inSupport) {
            proposal.yesCount++;
        } else {
            proposal.noCount++;
        }

        emit VoteCast(proposalId, msg.sender);
    }
}
