// Defi - This is a testing phase for Fixed Deposit generating smart contract that deals with relative time interest generation and withdrawl.
// Also a simple wallet is attached to this smart contract - Deposit and Withdraw (integers).
// contract time and relative time is prefixed and should be invoked during the function invocation.
// SPDX-License-Identifier: MIT
pragma solidity 0.5.3;

contract Defi{

    address public owner;
    uint public deadline;
    uint public balance;
    uint public FD_balance;
    uint public FD_balwithinterest;
    uint256 public createTime;
    mapping(uint256 => address) sendEther;


    constructor()payable public{
        balance = msg.value;
    }

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }


    function deposit(uint _amount)public{
        uint oldbalance = balance;
        uint newbalance = balance + _amount;
        require(newbalance >= oldbalance,"Overflow check to make sure deposit amount is greater than balance");
        balance = newbalance;
        if (newbalance <= oldbalance){
           revert();
        }
    }


    function withdraw_normal(uint256 _amt,address payable _to) public payable{
	 require(balance >= _amt);
	 balance -= _amt;
	 _amt = msg.value;
	 _to.transfer(_amt);		
	}


    function Time() public {	// This needs to be activated while making a deposit for F.D
        createTime = now;
    	}


    function Fixed_Deposit(uint256 _numberOfDays,uint _amount) public payable {		// Make sure to trigger the time during function invocation
        owner = msg.sender;
        deadline = now + (_numberOfDays * 1 days);
        uint oldbalance = FD_balance;
        uint newbalance = FD_balance + _amount;
        require(newbalance >= oldbalance,"Underflow check to make sure deposit amount is greater than balance");
        FD_balance = newbalance;
        FD_balwithinterest = FD_balance * 1000 * 2/10000;
    	}


    function FD_withdraw(uint _amount,address payable _recipient)public payable onlyOwner{
        require(now >= deadline);
        require(FD_balance >= _amount);
        FD_balance -= _amount;
        _amount = msg.value;
        _recipient.transfer(_amount);
        
        if (balance < _amount){
            revert();
    	} 
    }
}
