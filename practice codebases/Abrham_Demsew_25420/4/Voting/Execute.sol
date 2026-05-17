pragma solidity ^0.8.20;

contract Voting {
    struct Proposal {
        address target;
        bytes data;
        uint yesCount;
        uint noCount;
        bool executed;
    }

    Proposal[] public proposals;
    mapping(uint => mapping(address => uint8)) private votes;
    mapping(address => bool) public isMember;

    event ProposalCreated(uint proposalId);
    event VoteCast(uint proposalId, address voter);

    constructor(address[] memory members) public {
        isMember[msg.sender] = true;

        for (uint i = 0; i < members.length; i++) {
            isMember[members[i]] = true;
        }
    }

    function newProposal(address target, bytes calldata data) external {
        require(isMember[msg.sender], "Only members");
        Proposal memory proposal = Proposal({
            target: target,
            data: data,
            yesCount: 0,
            noCount: 0,
            executed: false
        });

        proposals.push(proposal);
        emit ProposalCreated(proposals.length - 1);
    }

    function castVote(uint proposalId, bool inSupport) external {
        require(isMember[msg.sender], "Only members");
        Proposal storage proposal = proposals[proposalId];

        if (inSupport) {
            proposal.yesCount++;
            if (!proposal.executed && proposal.yesCount >= 10) {
                proposal.executed = true;
                (bool success, ) = proposal.target.call(proposal.data);
                require(success);
            }
        } else {
            proposal.noCount++;
        }

        emit VoteCast(proposalId, msg.sender);
    }
}
