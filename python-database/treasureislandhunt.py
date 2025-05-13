print(r'''
*******************************************************************************
          |                   |                  |                     |
 _________|________________.=""_;=.______________|_____________________|_______
|                   |  ,-"_,=""     `"=.|                  |
|___________________|__"=._o`"-._        `"=.______________|___________________
          |                `"=._o`"=._      _`"=._                     |
 _________|_____________________:=._o "=._."_.-="'"=.__________________|_______
|                   |    __.--" , ; `"=._o." ,-"""-._ ".   |
|___________________|_._"  ,. .` ` `` ,  `"-._"-._   ". '__|___________________
          |           |o`"=._` , "` `; .". ,  "-._"-._; ;              |
 _________|___________| ;`-.o`"=._; ." ` '`."\ ` . "-._ /_______________|_______
|                   | |o ;    `"-.o`"=._``  '` " ,__.--o;   |
|___________________|_| ;     (#) `-.o `"=.`_.--"_o.-; ;___|___________________
____/______/______/___|o;._    "      `".o|o_.--"    ;o;____/______/______/____
/______/______/______/_"=._o--._        ; | ;        ; ;/______/______/______/_
____/______/______/______/__"=._o--._   ;o|o;     _._;o;____/______/______/____
/______/______/______/______/____"=._o._; | ;_.--"o.--"_/______/______/______/_
____/______/______/______/______/_____"=.o|o_.--""___/______/______/______/____
/______/______/______/______/______/______/______/______/______/______/_____ /
*******************************************************************************
''')
print("Welcome to Treasure Island.")
print("Your mission is to find the treasure.")
choice1 = input('You\'re at a crossroad, where do you want to do? Type "left" or "right": ')

if choice1 == "left":
    choice2 = input('You are now in front of a huge lake, '
                    'would you like to wait for boat or swim. '
          'Type "wait" to wait for a boat or "swim" to swim across the sea: ').lower()
    if choice2 == "wait":
        choice3 = input("You have now arrived to an island safely."
                        "There is a house with three doors with different colours."
                        "red, blue, yellow."
                        "Which door you choose to open? ").lower()
        if choice3 == "red":
            print("Fire caught you. Game Over.")
        elif choice3 == "blue":
            print("You reached the den of beast. Game over.")
        elif choice3 == "yellow":
            print("You got the handfull of treasure. You win!")
        else:
            print("Game Over, you opted for a door that does not exist")
    else:
        print("Sharks are now following you and no room to escape. Game over.")

else:
    print("You fell into a hole. Game Over.")
