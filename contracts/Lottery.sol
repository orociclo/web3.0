 pragma solidity ^0.4.0;
  contract Lottery {
   
    // variable to store manager address
    address public manager;
    
    // we are storing the address of the participants
    address[] public participants;
     
    constructor() public {
        // solidity give global variable to set the smart contract maker: msg.sender
        manager = msg.sender;
    }
    
    // Function to enter the loterry, we are going to make each users
    // pay a small amount to enter the loterry
    function enterLottery() public payable {
        // Set min amount to participate
        require(msg.value > 0.01 ether);
        
        // Add participant
        participants.push(msg.sender);
    }
    
    // Funtion to choose a random winner participant
    function pickWinner() public {
        
        // check this function is called only by the manager (first address)
        require(msg.sender == manager);
        
        // select a random participant
        // Con el hash random transformo en un entero aleatorio de numero de participante
        uint index = random() % participants.length;
        
        // transfer the contract balance (this.balance) to the participant
        participants[index].transfer(this.balance);
        
        // empty the address array
        participants = new address[](0);
    }
    
    // Function to return a random integer on private way
    function random() private view returns(uint256){
        
        // Remix function to retunr a random hash based on time
        return uint(keccak256(block.difficulty, now, participants));
        
    }
 }