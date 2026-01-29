# Bad Arguments
# Create a custom exception called NonIntArgumentException
# Fill in the wrapper function in the handleNonIntArguments function to act as an annotation.
# Check the test code to make sure you understand how this annotation is being used.
# Parameters:
# func: The function that will be called with the arguments. In this case, the function in the test code is sum.
# *args: The arguments that will be passed to func. Remember that args alone, without the asterisk, is a tuple of values.
# Result:
# Make sure that your wrapper actually returns the result of the function that's being called.

class NonIntArgumentException(Exception):
    pass

def handleNonIntArguments(func):
    def wrapper(*args):
        for arg in args:
            if type(arg) is not int:
                raise NonIntArgumentException(f'{arg} is not an integer!')
        return func(*args)
    return wrapper

@handleNonIntArguments
def sum(a, b, c):
    return a + b + c
