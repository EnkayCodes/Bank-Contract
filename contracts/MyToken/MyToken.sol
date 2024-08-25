// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;


contract ERC20Token {
    // Mapping of accounts to balances
    mapping (address => uint256) public balances;

    // Mapping of accounts to allowed spenders
    mapping (address => mapping (address => uint256)) public allowed;

    // Token name
    string public name;

    // Token symbol
    string public symbol;

    // Token total supply
    uint256 public totalSupply;

    // Token decimals
    uint8 public decimals;

    // Event emitted when tokens are transferred
    event Transfer(address indexed from, address indexed to, uint256 value);

    // Event emitted when tokens are approved for spending
    event Approval(address indexed owner, address indexed spender, uint256 value);

    // Constructor function
    constructor() {
        name = "Enkay_Token";
        symbol = "ENT";
        decimals = 18;

        // Initialize the balances mapping with the total supply
        balances[msg.sender] = totalSupply;
    }

    // Function to transfer tokens
    function transfer(address _to, uint256 _value) public returns (bool) {
        // Check if the sender has enough balance
        require(balances[msg.sender] >= _value, "Insufficient balance");

        // Subtract the value from the sender's balance
        balances[msg.sender] -= _value;

        // Add the value to the recipient's balance
        balances[_to] += _value;

        // Emit the Transfer event
        emit Transfer(msg.sender, _to, _value);

        return true;
    }

    // Function to approve tokens for spending
    function approve(address _spender, uint256 _value) public returns (bool) {
        // Check if the sender has enough balance
        require(balances[msg.sender] >= _value, "Insufficient balance");

        // Set the allowed value for the spender
        allowed[msg.sender][_spender] = _value;

        // Emit the Approval event
        emit Approval(msg.sender, _spender, _value);

        return true;
    }

    // Function to transfer tokens from one account to another
    function transferFrom(address _from, address _to, uint256 _value) public returns (bool) {
        // Check if the sender has enough balance
        require(balances[_from] >= _value, "Insufficient balance");

        // Check if the sender has allowed the spender to spend the value
        require(allowed[_from][msg.sender] >= _value, "Insufficient allowance");

        // Subtract the value from the sender's balance
        balances[_from] -= _value;

        // Add the value to the recipient's balance
        balances[_to] += _value;

        // Subtract the value from the allowed value
        allowed[_from][msg.sender] -= _value;

        // Emit the Transfer event
        emit Transfer(_from, _to, _value);

        return true;
    }

    // Function to get the balance of an account
    function balanceOf(address _owner) public view returns (uint256) {
        return balances[_owner];
    }

    // Function to get the allowed value for a spender
    function allowance(address _owner, address _spender) public view returns (uint256) {
        return allowed[_owner][_spender];
    }
}

