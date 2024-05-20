async function enterRaffle() {
    const raffleAddress = "0xF4EEcB0783BF1BAcc4A559609D12a99F7a6577C3"; // replace with your contract address
    const raffle = await ethers.getContractAt("Raffle", raffleAddress);
    const entranceFee = await raffle.getEntranceFee();
    await raffle.enterRaffle({ value: entranceFee });
    console.log("Entered!");

    // Generate Etherscan link
    const networkName = "sepolia"; // replace with the actual network name
    const etherscanLink = `https://${networkName}.etherscan.io/address/${raffleAddress}`;
    console.log(`Etherscan link: ${etherscanLink}`);
}

enterRaffle()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });