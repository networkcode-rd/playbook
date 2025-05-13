print("Welcome to Python Pizza Deliveries!")
size = input("What size pizza do you want? S, M or L: ")
pepperoni = input("Do you want pepperoni on your pizza? Y or N: ")
extra_cheese = input("Do you want extra cheese? Y or N: ")
bill = 0
if size == "S":
    bill += 15
elif size == "M":
    bill += 20
elif size == "L":
    bill += 25
else:
    print("Wrong input, please try again.")

if pepperoni == "Y":
    if size == "S":
        bill+= 3
    elif size == "M":
        bill += 4
    else:
        bill += 5
else:
    print("Wrong input, please try again.")

if extra_cheese == "Y":
    bill += 1

print(f"Your final bill is Rs.{bill}")
