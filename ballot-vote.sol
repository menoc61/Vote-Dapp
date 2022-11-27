//SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.7.0<0.9.0;
//Making a voting contract
/// @title Ballot vote system
/// @author Gille Momeni SE3 IAI CAMEROUN 11/2022
/// @notice Smart contract to manage the sytem of voting at AICS || IAI CAMEROUN
/// @dev Error of execution constructor need bytes as argument but input string(list of candidates)
contract Ballot {
    address public owner; //person connecting to the contract
    struct Candidate {    
    bytes32 name; //name of each candidate
    uint voteCount; //number of cummulated votes per candidate
    }
    Candidate[] public candidates; //get candidates array out of the Smart contract
    struct Voter {
        bool voted;// defined if a user has the ability to vote or not
        uint vote;// defined the voting index
        uint weight; // defined the access to vote or the importance of a voice
    }
    mapping (address => Voter) voters; //assiging addresses to any voter as key index

    constructor(bytes32[] memory candidateNames) {
        //add candidateNames upon deployment
        for (uint i = 0; i < candidateNames.length; i++) {
            candidates.push(Candidate({
                name: candidateNames[i],
                voteCount: 0
            }));
        }    
        owner = msg.sender; // person emmiting the contract
        
        voters[owner].weight = 1;//add 1 to the owner weight
    }
    
    //authenticates votes
    modifier auth {
        require(msg.sender == owner, "Only the owner can give right to vote");
        _;
    }
    function giveRightToVote(address voter) public auth {
        require(!voters[voter].voted , " had already voted!");
        require(voters[voter].weight == 0 , " had not yet the right to vote!");
        voters[voter].weight = 1;
    }
    //function for voting
    function vote(uint candidate) public {
        Voter storage sender = voters[msg.sender]; //person calling the contract
        require(sender.weight != 0, "User has no right to vote");
        require(!sender.voted, "User has already voted");
        sender.voted = true;
        sender.vote = candidate;

        candidates[candidate].voteCount += sender.weight;
    }
    //showing the results of winning candidate by index
     function winnerCandidate() view public returns (uint _winningCandidate) {
        uint winningVoteCount = 0;
        for (uint i = 0; i < candidates.length; i++) {
            if (candidates[i].voteCount > winningVoteCount) {              
            winningVoteCount = candidates[i].voteCount;
            _winningCandidate = i;
            }
        }
     }
    //showing the results of winning candidate by name
     function winnerName() view public returns (bytes32 _winningName) {
        _winningName = candidates[winnerCandidate()].name;
     }
}