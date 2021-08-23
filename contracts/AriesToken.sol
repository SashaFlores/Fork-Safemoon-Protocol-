// SPDX-License-Identifier: MIT
pragma solidity ^0.6.12;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract AriesToken is ERC20 {
  uint BurnTokens = 5;
  uint AdminFee = 5;
  address public admin;
  
  mapping(address => bool) public excludedFromTax;

  constructor() public ERC20('Aries', 'ARI') {
    _mint(msg.sender, 10000 * 10 ** 18); 
    admin = msg.sender;
    excludedFromTax[msg.sender] = true;
  }

  function transfer(address recipient, uint256 amount) 
    public 
    override 
    returns (bool) {
    if(excludedFromTax[msg.sender] == true) { 
      _transfer(_msgSender(), recipient, amount);
    } else { 
      uint burnAmount = amount.mul(BurnTokens) / 100;
      uint adminAmount = amount.mul(AdminFee) / 100;
      _burn(_msgSender(), burnAmount);
      _transfer(_msgSender(), admin, adminAmount);
      uint recipientAmount = amount
        .sub(burnAmount)
        .sub(adminAmount);
      _transfer(_msgSender(), recipient, recipientAmount); 
    }
    return true;
  }

  function transferFrom(address sender, address recipient, uint256 amount) 
    public 
    override 
    returns (bool) {
    if(excludedFromTax[sender] == true) { 
      _transfer(sender, recipient, amount);
      _approve(
        sender, 
        _msgSender(), 
        allowance(sender, _msgSender()).sub(
          amount, 
          "ERC20: transfer amount exceeds allowance"
        )
      );
    } else {
      uint burnAmount = amount.mul(BurnTokens) / 100;
      uint adminAmount = amount.mul(AdminFee) / 100;
      _burn(sender, burnAmount);
      _transfer(sender, admin, adminAmount);
      uint recipientAmount = amount
        .sub(burnAmount)
        .sub(adminAmount);
      _transfer(sender, recipient, recipientAmount); 
      _approve(
        sender, 
        _msgSender(),
        allowance(sender, _msgSender()).sub(recipientAmount)
      );
    }
    return true;
  }

  function addExcludedFromTax(address excluded) external {
    require(msg.sender == admin, 'only admin');
    excludedFromTax[excluded] = true;
  }

}
