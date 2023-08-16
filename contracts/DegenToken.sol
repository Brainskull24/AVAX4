// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DegenToken is ERC20, Ownable {

    constructor() ERC20("Degen", "DGN") {}

    event RedeemToken(address account, uint rewardCategory);
    event BurnToken(address account, uint amount);
    event TransferToken(address from, address to, uint amount);

    // onlyOwner modifier allows only the user to execute the function
    function mint(address to, uint256 amount) public onlyOwner {
            _mint(to, amount);
    }
    
    // In-built transfer function is used
    // transfer(to, amount);

    //Wrapper function for balanceOf function of ERC20
    function getBalance() public view returns (uint){
        return balanceOf(msg.sender);
    }

    function redeem(uint rewardCategory) public {
        uint requiredAmount = rewardCategory * 10;
        require(balanceOf(msg.sender)>=requiredAmount,"Insufficient Amount");
        burn(requiredAmount);
        emit RedeemToken(msg.sender, rewardCategory);
    }

    // Wrapper function to access the private _burn function of ERC20
    function burn(uint amount) public {
        _burn(msg.sender, amount);
        emit BurnToken(msg.sender, amount);
    }
}
