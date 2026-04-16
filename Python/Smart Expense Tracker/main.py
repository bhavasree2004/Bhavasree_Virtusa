"""
Python - Smart Expense Tracker with Insights

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
"""
import pandas as pd
import matplotlib.pyplot as plt
import csv
import os

file= "Personal_Finance_Dataset.csv"

if not os.path.exists(file):
    open(file, "w").write("Date,Transaction_Description,Category,Amount,Type\n")

def add_expense():

    date = input("Enter date (YYYY-MM-DD): ")
    try:
        pd.to_datetime(date)
    except:
        print("Invalid date format! Use YYYY-MM-DD\n")
        return
    
    Transaction_Description = input("Enter description: ")

    Category = input("Enter category: ")

    amount=input("Enter amount: ")
    try:
        amount = float(amount)
    except ValueError:
        print("Invalid amount! Please enter a number.\n")
        return
    
    Type = input("Enter Type:")

    with open(file, "a", newline="") as f:
        writer = csv.writer(f)
        writer.writerow([date,Transaction_Description,Category,amount,Type])

    print("Expense added successfully!\n")

def load_data():
    try:
        df = pd.read_csv(file)
        
        if df.empty:
            print("No data available.\n")
            return None

        df["Date"] = pd.to_datetime(df["Date"])
        df["Amount"] = pd.to_numeric(df["Amount"], errors="coerce")
        
        return df.dropna(subset=["Amount"])

    except FileNotFoundError:
        print("No expense data found. Add expenses data.\n")
        return None
    return df

def category_summary(df):
    category_total = df.groupby("Category")["Amount"].sum()

    print("\n--- Category-wise Expenses ---")
    for cat, total in category_total.items():
        print(cat, ":", total)

    return category_total

def monthly_summary(df):
    df["Month"] = df["Date"].dt.month
    monthly_total = df.groupby("Month")["Amount"].sum()

    print("\n--- Monthly Summary ---")
    for month, total in monthly_total.items():
        print("Month", month, ":", total)

def insights(category_total):
    highest = category_total.idxmax()
    amount = category_total.max()

    print("\nHighest Spending Category:", highest)
    print("Amount:", amount)

    print("\n--- Suggestions ---")
    for cat, total in category_total.items():
        if total == amount:
            print(f"Highest spending is on {cat}. Try reducing it.")
        elif total > amount * 0.5:
            print(f"High spending detected in {cat}.")

def chart(category_total):
    if not os.path.exists("charts"):
        os.makedirs("charts")

    category_total.plot(kind="pie", autopct="%1.1f%%")
    plt.title("Expense Distribution")
    plt.ylabel("")

    plt.savefig("expense_chart.png")
    plt.show()

def main():
    while True:
        print("\n===== Expense Tracker =====")
        print("1. Add Expense")
        print("2. View Summary")
        print("3. Show Chart")
        print("4. Exit")

        choice = input("Enter choice: ")

        if choice == "1":
            add_expense()

        elif choice == "2":
            df = load_data()
            if df is None:
                continue

            category_total = category_summary(df)
            monthly_summary(df)
            insights(category_total)

            print("\nTotal Expense:", df["Amount"].sum())

        elif choice == "3":
            df = load_data()
            if df is None:
                continue

            category_total = df.groupby("Category")["Amount"].sum()
            chart(category_total)

        elif choice == "4":
            print("Exiting program")
            break

        else:
            print("Invalid choice! Try again.")

main()
