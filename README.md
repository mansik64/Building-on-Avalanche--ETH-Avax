# EpicAdventure
The `EpicAdventure` smart contract is a blockchain-based game token contract built on Ethereum using the ERC20 standard. The contract introduces a custom token called `EpicCoin` (EPC), which players can earn, transfer, and spend within the game. Players can redeem their tokens to unlock unique avatars, including a warrior, mage, archer, or assassin. The contract allows the game owner to mint new tokens, while players can burn their tokens to obtain these avatars, adding an interactive and strategic element to the gameplay. The contract also provides functions for viewing available avatars and checking the player's token balance and owned avatars.


## Description
The EpicAdventure contract is an ERC20-based game token system where players use EpicCoin (EPC) to acquire in-game avatars. The contract includes features for minting, burning, and transferring tokens, along with a mechanism for players to redeem their tokens for specific avatars like warrior, mage, archer, and assassin. Each avatar requires a different amount of tokens, creating a strategic element for players. The contract also provides functions to view available avatars, check a player's balance, and see their owned avatars. The contract is managed by the owner, who has the exclusive right to mint new tokens.
`Key feature : -`
>>`mintEpicCoins(address to, uint256 amount):` The function uses the internal _mint method from the ERC20 standard to create and assign the specified amount of tokens to the provided address.
>>`burnEpicCoins(uint256 amount):`The function calls the _burn method to reduce the caller's token balance by the specified amount, effectively destroying the tokens.
>>`transferEpicCoins(address to, uint256 amount):`The function invokes the transfer method from the ERC20 standard to move tokens from the caller’s balance to the recipient’s balance.
>>`viewAvailableAvatars():`Allows anyone to view the list of available avatars in the game.
>>`viewMyAvatars():` A PlayerAvatars struct containing the counts of each avatar type owned by the caller.
>>`viewMyBalance():` Allows a player to check their current balance of EpicCoin tokens.
>>`redeemAvatar(uint256 index):`An integer representing the avatar type to redeem (0 for warrior, 1 for mage, 2 for archer, 3 for assassin).

## Getting Started

### Executing program

To run this program, you can use Remix, an online Solidity IDE. To get started, go to the Remix website at https://remix.ethereum.org/.

```jS Solidity

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract EpicAdventure is ERC20, Ownable {

    string[] avatars = [
        "warrior",
        "mage",
        "archer",
        "assassin"
    ];

    struct PlayerAvatars {
        uint warrior;
        uint mage;
        uint archer;
        uint assassin;
    }
    
    mapping(address => PlayerAvatars) playerAvatars;

    constructor() ERC20("EpicCoin", "EPC") Ownable(msg.sender) {}

    function mintEpicCoins(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    function burnEpicCoins(uint256 amount) public {
        _burn(msg.sender, amount);
    }

    function transferEpicCoins(address to, uint256 amount) public {
        transfer(to, amount);
    }

    function viewAvailableAvatars() public view returns (string[] memory) {
        return avatars;
    }

    function viewMyAvatars() public view returns (PlayerAvatars memory) {
        return playerAvatars[msg.sender];
    }

    function viewMyBalance() public view returns (uint256) {
        return balanceOf(msg.sender);
    }

    function redeemAvatar(uint256 index) public {
        require(index <= 3, "Invalid index");
        if (index == 0) {
            require(balanceOf(msg.sender) >= 10, "Insufficient balance");
            _burn(msg.sender, 10);
            playerAvatars[msg.sender].warrior++;
        } else if (index == 1) {
            require(balanceOf(msg.sender) >= 20, "Insufficient balance");
            _burn(msg.sender, 20);
            playerAvatars[msg.sender].mage++;
        } else if (index == 2) {
            require(balanceOf(msg.sender) >= 30, "Insufficient balance");
            _burn(msg.sender, 30);
            playerAvatars[msg.sender].archer++;
        } else if (index == 3) {
            require(balanceOf(msg.sender) >= 40, "Insufficient balance");
            _burn(msg.sender, 40);
            playerAvatars[msg.sender].assassin++;
        } else {
            revert("Invalid input");
        }
    }
}

```
We can write test scripts using Hardhat or Truffle to interact with the contract functions. You can also manually interact with the contract via the Remix interface to test each function.
When you're ready, you can deploy the contract to a live network like Ethereum Mainnet or any testnet (e.g., Rinkeby, Goerli). This will require a funded account and connection to a network through an Infura node or similar.

#### Author
Mansi Shukla - Chandigarh University BE-C.S.E Students

#### License
This contract is licensed under the MIT License