pragma solidity ^0.5.16;

contract Election {
    // Model a Candidate
    struct Candidate {
    	uint id;
    	string name;
    	uint voteCount;	
    }
    // Store Addresses that voted
    mapping(address => bool) public voters;
    // Store Candidate
    // Fetch Candidates
    mapping(uint => Candidate) public candidates;
    // Store Candidates Count
    uint public candidatesCount;

    event votedEvent (uint indexed _candidateId);
	
	constructor () public {
		addCandidate("Candidate 1");
		addCandidate("Candidate 2");
		addCandidate("Candidate 3");
		addCandidate("Candidate 4");
	}
	function addCandidate (string memory _name) private {
	candidatesCount ++;
	candidates[candidatesCount] = Candidate(candidatesCount,_name,0);
	}	

	function vote (uint _candidateId) public {
	
	//require they haven't voted before
	require (!voters[msg.sender]);
	
	// require a valid candidate
	require (_candidateId > 0 && _candidateId <= candidatesCount);
	
	// record that address has voted
	voters[msg.sender] = true;
	
	// update candidate vote count
	candidates[_candidateId].voteCount ++;

	// trigger voted event
	emit votedEvent(_candidateId);
	}
}
