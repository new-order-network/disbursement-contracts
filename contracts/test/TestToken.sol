// SPDX-License-Identifier: LGPL-3.0-only
pragma solidity ^0.6.0;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract TestToken is ERC20 {
    constructor(string memory name_, string memory symbol_) ERC20(name_, symbol_) public {
        //_mint(msg.sender, 10000000);
    }

    function mint (address _account, uint amount) public{
        _mint(_account, amount);
    }
}