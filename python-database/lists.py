#Making a list
#order of states I lived in.
states_of_india = ["Meghalaya", "West Bengal", "Maharashtra", "Telangana", "Uttar Pradesh"]

print(states_of_india[1])
print(states_of_india[-2])

## Picking random names from a list
import random
# 1st Option
friends = ["Arjun", "Sahedev", "Bheem", "Yudhishthir", "Nakul"]
print(random.choice(friends))

#2nd Option
random_index = random.randint(0,4)
print(friends[random_index])