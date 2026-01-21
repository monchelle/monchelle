# Faster Prime Finding
# Write a function that returns a list of all primes up to a given number.
#
# For each number, in order to determine if it is prime, take the following steps:

# Find the square root of the number
# Find all the primes up to that square root
# Test to see if any of those primes are divisors
# If a number has no prime divisors, it is prime!

def allPrimesUpTo(num):

    list = [2]
    
    for number in range(3, num):
        for factor in range(2, int(number ** 0.5) + 1):
            if number % factor == 0:
                break
            
        else:
            list.append(number)

    return list

print(allPrimesUpTo(num))