
//SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.0 <0.9.0;

import './ERC20Interface.sol';

contract Cryptos is ERC20Interface {
    string public name = "Cryptos";
    string public symbol = "CRPT";
    uint public decimals = 0;
    uint public override totalSupply;
    address public founder;
    mapping(address => uint) public balances;
    mapping(address => mapping(address => uint)) public allowed;

    constructor(){
        totalSupply = 1000000;
        founder = msg.sender;
        balances[founder] = totalSupply;
    }

    function balanceOf(address tokenOwner) public view override returns (uint balance) {
        return balances[tokenOwner];
    }

    function transfer(address to, uint tokens) public virtual override returns(bool success) {
        require(balances[msg.sender] >= tokens);

        balances[to] += tokens;
        balances[msg.sender] -= tokens;

        emit Transfer(msg.sender, to, tokens);

        return true;
    }

    function allowance(address tokenOwner, address spender) view public override returns(uint) {
        return allowed[tokenOwner][spender];
    }

    function approve(address spender, uint tokens) public override returns(bool success){
        require(balances[msg.sender] >= tokens);
        require(tokens > 0);
        
        allowed[msg.sender][spender] = tokens;

        emit Approval(msg.sender, spender, tokens);

        return true;
    }

    function transferFrom(address from, address to, uint tokens) public virtual override returns (bool success) {
        require(allowed[from][to] >= tokens);
        require(balances[from] >= tokens);

        balances[from] -= tokens;
        balances[to] += tokens;
        allowed[from][to] -= tokens;

        emit Transfer(from, to, tokens);

        return true;
    }
}