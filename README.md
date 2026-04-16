1. Java - FinSafe Transaction Validator

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

2. Python - Smart Expense Tracker with Insights

Problem Statement : Many individuals struggle to track daily expenses and understand spending patterns. Build a Python application that allows users to log, categorize, and analyze their expenses.

Objectives:
1. Record daily expenses (date, category, amount, description)
2. Categorize spending (Food, Travel, Bills, etc.)
3. Generate monthly summaries and insights

Key Features:
1. CLI (Command Line Interface) or simple GUI input system
2. Data storage using CSV or JSON
3. Monthly expense summary
4. Category-wise breakdown (pie chart using libraries like matplotlib)
5. Detect highest spending category

Expected Outcome: A tool that helps users understand where their money goes and suggests areas to reduce spending.

3. SQL - E-Commerce Logistics Tracker

Business Case:
SwiftShip is a third-party logistics provider. They handle thousands of packages daily. Their current challenge is Lost in Transit items and identifying which delivery partners are underperforming.

Problem Statement:
Create a tracking database that identifies delayed shipments and ranks delivery partners based on their Success Rate.

Tasks:
1. Schema Design: Create the following tables:Partners, Shipments, DeliveryLogs
2. Delayed Shipment Query: Write a query to find all shipments where - ActualDeliveryDate > PromisedDate
3. Performance Ranking: Use COUNT and GROUP BY to show how many - Successful deliveries, Returned deliveries, each partner handled.
4. Zone Filter: Identify the most popular Destination City for orders placed in the last 30 days to help the warehouse plan truck routes.
