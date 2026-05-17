// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Voting {
    struct Proposal {
        address target;
        bytes data;
        uint yesCount;
        uint noCount;
    }

    Proposal[] public proposals;
    mapping(uint => mapping(address => bool)) public hasVoted;
    mapping(uint => mapping(address => bool)) public voteChoice;
    mapping(address => bool) public members;
    mapping(uint => bool) public executed;

    event ProposalCreated(uint proposalId);
    event VoteCast(uint proposalId, address voter);

    constructor(address[] memory _members) {
        members[msg.sender] = true;
        for (uint i = 0; i < _members.length; i++) {
            members[_members[i]] = true;
        }
    }

    function newProposal(address _target, bytes calldata _data) external {
        require(members[msg.sender], "Not a member");
        proposals.push(Proposal(_target, _data, 0, 0));
        emit ProposalCreated(proposals.length - 1);
    }

    function castVote(uint proposalId, bool _supports) external {
        require(members[msg.sender], "Not a member");
        Proposal storage proposal = proposals[proposalId];

        if (hasVoted[proposalId][msg.sender]) {
            // Changing vote: decrement the previous choice
            if (voteChoice[proposalId][msg.sender]) {
                proposal.yesCount--;
            } else {
                proposal.noCount--;
            }
        }

        // Record the new vote
        hasVoted[proposalId][msg.sender] = true;
        voteChoice[proposalId][msg.sender] = _supports;

        if (_supports) {
            proposal.yesCount++;
        } else {
            proposal.noCount++;
        }

        emit VoteCast(proposalId, msg.sender);

        // Execute the proposal if threshold reached
        if (!executed[proposalId] && proposal.yesCount >= 10) {
            executed[proposalId] = true;
            (bool success, ) = proposal.target.call(proposal.data);
            require(success, "Execution failed");
        }
    }
}
