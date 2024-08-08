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
