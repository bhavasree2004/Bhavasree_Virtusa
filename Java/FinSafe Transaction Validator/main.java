/* 
Java - FinSafe Transaction Validator

Business Case: FinSafe is a digital wallet app. They are seeing an increase in Overdraft errors where users spend more than they have because the app processes transactions too slowly.

Problem Statement: Build a robust Transaction Processor that validates every Spend request against the user's current balance and logs every action for auditing purposes.

Tasks:
1.Encapsulation: Create an Account class with private variables - balance, accountHolder
2. Custom Exception: Create a user-defined exception called InSufficientFundsException.
3. Validation Logic:
Write a method: processTransaction(double amount)
If the amount is negative, throw an IllegalArgumentException.
If the amount is greater than the balance, throw your custom InSufficientFundsException.
4. Transaction History:
Store the last 5 successful transaction amounts in an ArrayList.
Provide a method: printMiniStatement()

Deliverable: A console-based Java application where a user can: Deposit, Withdraw, View History with full error handling.
*/

import java.util.InputMismatchException;
import java.util.Scanner;

public class main {
    public static void main(String[] args) {

        Scanner sc = new Scanner(System.in);

        System.out.print("Enter account holder name: ");
        String name = sc.nextLine();

        double balance = 0;

        while (true) {
            try {
                System.out.print("Enter initial balance: ");
                balance = sc.nextDouble();
                break;
            } catch (InputMismatchException e) {
                System.out.println("Invalid input! Enter a number.");
                sc.nextLine();
            }
        }

        Account account = new Account(name, balance);

        while (true) {
            System.out.println("\n===== FinSafe Menu =====");
            System.out.println("1. Deposit");
            System.out.println("2. Withdraw");
            System.out.println("3. Mini Statement");
            System.out.println("4. Show Balance");
            System.out.println("5. Exit");

            int choice;

            try {
                System.out.print("Enter choice: ");
                choice = sc.nextInt();
            } catch (InputMismatchException e) {
                System.out.println("Invalid input! Please enter a number.");
                sc.nextLine();
                continue;
            }

            try {
                switch (choice) {
                    case 1:
                        double deposit;
                        try {
                            System.out.print("Enter amount: ");
                            deposit = sc.nextDouble();
                        } catch (InputMismatchException e) {
                            System.out.println("Invalid amount!");
                            sc.nextLine();
                            continue;
                        }
                        account.deposit(deposit);
                        break;

                    case 2:
                        double withdraw;
                        try {
                            System.out.print("Enter amount: ");
                            withdraw = sc.nextDouble();
                        } catch (InputMismatchException e) {
                            System.out.println("Invalid amount!");
                            sc.nextLine();
                            continue;
                        }
                        account.withdraw(withdraw);
                        break;

                    case 3:
                        account.printMiniStatement();
                        break;

                    case 4:
                        account.showBalance();
                        break;

                    case 5:
                        System.out.println("Exiting...");
                        return;

                    default:
                        System.out.println("Invalid choice!");
                }

            } catch (IllegalArgumentException e) {
                System.out.println("Error: " + e.getMessage());
            } catch (InSufficientFundsException e) {
                System.out.println("Error: " + e.getMessage());
            }
        }
    }
}
