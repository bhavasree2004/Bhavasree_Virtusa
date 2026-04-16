import java.util.ArrayList;

class Account {
    private String accountHolder;
    private double balance;
    private ArrayList<Double> transactions;

    public Account(String accountHolder, double balance) {
        this.accountHolder = accountHolder;
        this.balance = balance;
        this.transactions = new ArrayList<>();

        if (balance > 0) {
            addTransaction(balance);
        }
    }

    // Deposit
    public void deposit(double amount) {
        if (amount <= 0) {
            throw new IllegalArgumentException("Amount must be positive");
        }

        balance += amount;
        addTransaction(amount);
        System.out.println("Deposit successful!");
    }

    // Withdraw
    public void withdraw(double amount) throws InSufficientFundsException {
        if (amount <= 0) {
            throw new IllegalArgumentException("Amount must be positive");
        }

        if (amount > balance) {
            throw new InSufficientFundsException("Insufficient balance!");
        }

        balance -= amount;
        addTransaction(-amount);
        System.out.println("Withdrawal successful!");
    }

    // Maintain last 5 transactions
    private void addTransaction(double amount) {
        if (transactions.size() == 5) {
            transactions.remove(0);
        }
        transactions.add(amount);
    }

    // Mini statement
    public void printMiniStatement() {
        System.out.println("\n--- Mini Statement ---");
        for (double t : transactions) {
            System.out.println(t);
        }
    }

    // Show balance
    public void showBalance() {
        System.out.println("Current Balance: " + balance);
    }
}