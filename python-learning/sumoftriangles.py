# Sum of Triangles
# You are given a function triangle that returns the triangular number for a given number, num. Your goal is to use this to create a function called square that returns the square of a given positive integer, num.
# Fill in the function square that returns the square of a number using only the triangle function. No multiplication or exponents allowed.

num = 4

def triangle(num):
    if num == 1:
        return num
    return num + triangle(num - 1)

def square(num):
    if num == 1:
        return num
    return triangle(num) + triangle(num - 1)

print(square(num))
