#Creating steps to make a modulo and a code to represent it. print(10 %2)

number_to_check = int(input("What is the number you want to check? "))

print(number_to_check % 2)

if number_to_check % 2 == 0:
    print("It's an even number")
else:
    print("It's an odd number")