#this file contains information from sources from where I have learned about Python, these are not my own codes.
print("Welcome to the tip calculator!")
bill = float(input("What was the total bill? $"))
tip = int(input("What percentage tip would you like to give? 10 12 15 "))
people = int(input("How many people to split the bill? "))
#bill_with_tip = tip /100 * bill + bill
# we are using the below approach to understand each step.
tip_as_percent = tip / 100
total_tip_amount = bill * tip_as_percent
total_bill = bill + total_tip_amount
bill_per_person = total_bill/people
final_amount = round(bill_per_person, 2)
print(f"Your amount is: $ {final_amount}")
