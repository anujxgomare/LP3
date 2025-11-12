// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.0;

contract BankAccount {
    struct Account {
        uint256 balance;
        uint256 withdrawAmount; // user’s last withdrawal request
        bool exists;
    }

    mapping(address => Account) private accounts;

    event AccountCreated(address indexed user, uint256 initialDeposit);
    event Deposit(address indexed user, uint256 amount);
    event Withdraw(address indexed user, uint256 amount);

    // ✅ Create new account with an initial deposit (logical, not ETH)
    function createAccount(uint256 initialDeposit) public {
        require(!accounts[msg.sender].exists, "Account already exists");

        accounts[msg.sender] = Account({
            balance: initialDeposit,
            withdrawAmount: 0,
            exists: true
        });

        emit AccountCreated(msg.sender, initialDeposit);
    }

    // ✅ Deposit funds (adds to logical balance)
    function deposit(uint256 amount) public {
        require(accounts[msg.sender].exists, "Account not found");
        require(amount > 0, "Deposit must be > 0");

        accounts[msg.sender].balance += amount;
        emit Deposit(msg.sender, amount);
    }

    // ✅ Withdraw funds (deducts from balance)
    function withdraw(uint256 amount) public {
        require(accounts[msg.sender].exists, "Account not found");
        require(amount > 0, "Withdraw must be > 0");
        require(amount <= accounts[msg.sender].balance, "Insufficient balance");

        accounts[msg.sender].balance -= amount; // 💡 actually deducts balance
        accounts[msg.sender].withdrawAmount = amount;

        emit Withdraw(msg.sender, amount);
    }

    // ✅ Show current balance
    function showBalance() public view returns (uint256) {
        require(accounts[msg.sender].exists, "Account not found");
        return accounts[msg.sender].balance;
    }

    // ✅ Show last withdrawal amount
    function getWithdrawAmount() public view returns (uint256) {
        require(accounts[msg.sender].exists, "Account not found");
        return accounts[msg.sender].withdrawAmount;
    }

    // ✅ Show both balance + last withdrawal
    function getAccountDetails()
        public
        view
        returns (uint256 balance, uint256 withdrawAmount)
    {
        require(accounts[msg.sender].exists, "Account not found");
        Account storage acc = accounts[msg.sender];
        return (acc.balance, acc.withdrawAmount);
    }
}
