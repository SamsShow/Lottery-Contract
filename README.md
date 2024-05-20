# Lottery-Contract
 Hardhat Smart Contract Lottery System

 # Key Components

## Chainlink VRF (Verifiable Random Function)
- Ensures that the random number used to select the winner is provably random and tamper-proof.

## Chainlink Keepers
- Automates the execution of the contract based on predefined conditions (e.g., time intervals).

# State Variables

## Chainlink VRF Variables
- `i_vrfCoordinatorV2`: Address of the VRFCoordinatorV2 contract.
- `i_subscriptionId`: Subscription ID for Chainlink VRF.
- `i_gasLane`: Maximum gas price for the callback request.
- `i_callbackGasLimit`: Maximum gas to be used for the callback.
- `REQUEST_CONFIRMATIONS`: Number of confirmations required before the VRF response is considered.
- `NUM_WORDS`: Number of random words requested.

## Lottery Variables
- `i_interval`: Time interval for each raffle draw.
- `i_entranceFee`: Fee to enter the raffle.
- `s_lastTimeStamp`: Timestamp of the last raffle draw.
- `s_recentWinner`: Address of the most recent winner.
- `s_players`: List of players in the current raffle.
- `s_raffleState`: State of the raffle (OPEN or CALCULATING).

# Events

- `RequestedRaffleWinner(uint256 indexed requestId)`: Emitted when a random winner is requested.
- `RaffleEnter(address indexed player)`: Emitted when a player enters the raffle.
- `WinnerPicked(address indexed player)`: Emitted when a winner is picked.

# Functions

## Constructor
- Initializes the contract with the necessary parameters and sets the initial state of the raffle to OPEN.

## enterRaffle
- Allows users to enter the raffle by sending the required entrance fee.
- Adds the player's address to the `s_players` array.
- Emits the `RaffleEnter` event.

## checkUpkeep
- Called by Chainlink Keepers to check if the upkeep (i.e., selecting a winner) is needed.
- Returns `true` if the time interval has passed, the raffle is open, there are players, and the contract has a balance.

## performUpkeep
- Called by Chainlink Keepers when `checkUpkeep` returns `true`.
- Initiates the random number request to Chainlink VRF.
- Sets the raffle state to CALCULATING.
- Emits the `RequestedRaffleWinner` event.

## fulfillRandomWords
- Callback function called by Chainlink VRF with the random number.
- Uses the random number to select a winner from the `s_players` array.
- Resets the raffle state to OPEN, clears the players array, updates the last timestamp, and transfers the contract balance to the winner.
- Emits the `WinnerPicked` event.

# Error Handling

## Custom Errors
- `Raffle__UpkeepNotNeeded`: Thrown when upkeep is not needed.
- `Raffle__TransferFailed`: Thrown when the transfer to the winner fails.
- `Raffle__SendMoreToEnterRaffle`: Thrown when the sent ETH is less than the entrance fee.
- `Raffle__RaffleNotOpen`: Thrown when the raffle is not open.
- `Raffle__NotEnoughETHEntered`: Thrown when not enough ETH is sent to enter the raffle.

# Getter Functions

- `getRaffleState`
- `getNumWords`
- `getRequestConfirmations`
- `getRecentWinner`
- `getPlayer`
- `getLastTimeStamp`
- `getInterval`
- `getEntranceFee`
- `getNumberOfPlayers`

Functions to retrieve the state and configuration of the raffle.

# Summary

This contract ensures a fair and automated raffle system by leveraging Chainlink's VRF for randomness and Keepers for automation. Users can participate by sending ETH, and the contract will automatically select a winner at defined intervals, transferring the accumulated prize to the winner. The use of custom errors and events helps in monitoring and debugging the contract's operation.
