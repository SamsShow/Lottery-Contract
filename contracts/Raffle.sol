//Raffle
// Enter the lottery(paying some amount)
// pick a random winner (verifiably random)
// winner to be selected wvery X minutes ->completly automate
// Chainlink Oracle -> Randomness, Automated Execution(chainlink keeper )

// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

// import "@chainlink/contracts/src/v0.8/vrf/VRFCoordinatorV2Interface.sol";
import "@chainlink/contracts/src/v0.8/vrf/VRFConsumerBaseV2.sol";
// import "@chainlink/contracts/src/v0.8/automation/interfaces/AutomationCompatibleInterface.sol";


error Rraffle_NotEnoughETHEntered();

abstract contract Raffle is VRFConsumerBaseV2{


    uint256 private immutable i_entranceFee; //going to use it only one time so to save some gas making it immutable
    address payable[] private s_players;

    //Events
    event RaffleEntered(address indexed player);

    constructor(address vrfCoordinatorV2, uint256 entranceFee) VRFConsumerBaseV2(vrfCoordinatorV2) {
        i_entranceFee = entranceFee;
    }

    function enterRaflle()public payable{
        if(msg.value < i_entranceFee){
            revert Rraffle_NotEnoughETHEntered();
        }
        s_players.push(payable(msg.sender)); //track of all the players who have entered the raffle

        // Emit an event when we update a dynamic array or mapping to make it easier to track
        //named events with the function name reversed
        emit RaffleEntered(msg.sender);
    }

    function fulfillRandomWinner(uint256 requestId, uint256) external {
        //Request the random number from the chainlink oracle
        // Use the random number to pick a winner
        // 2 transactions -> 1. request the random number 2. pick the winner
    }


    function getEntranceFee()public view returns(uint256){
        return i_entranceFee;
    }

    function getPlayers(uint256 index) public view returns(address){
        return s_players[index];
    }
}