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

#Long list of list items
states_N_UT_of_india = ["Andhra Pradesh", "Arunachal Pradesh", "Assam", "Bihar", "Chhattisgarh", "Goa", "Gujarat", "Haryana", "Himachal Pradesh", "Jharkhand", "Karnataka", "Kerala", "Madhya Pradesh", "Maharashtra", "Manipur", "Meghalaya", "Mizoram", "Nagaland", "Odisha", "Punjab", "Rajasthan", "Sikkim", "Tamil Nadu", "Telangana", "Tripura", "Uttar Pradesh", "Uttarakhand", "West Bengal", "Andaman and Nicobar Islands", "Chandigarh", "Dadra and Nagar Haveli and Daman and Diu", "Delhi", "Jammu and Kashmir", "Ladakh", "Lakshadweep", "Puducherry"]
print(len(states_N_UT_of_india))
print(states_N_UT_of_india[35])


# Creating Nested List
fruits = ["Cherry", "Apple", "Pear"]
veg = ["Cucumber", "Kale", "Spinnach"]
grocery_item = [fruits,veg]
print(grocery_item)
