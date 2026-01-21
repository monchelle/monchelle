# Encoding ASCII art
#
# Task
# Write a function encodeString that will encode a string like 'AAAAABBBBAAA' and return a list of tuples: [('A', 5), ('B', 4), ('A', 3)], meaning that the string has "5 a's followed by 4 b's followed by 3 a's."
# Write a corresponding function decodeString that will take in a list of tuples and print the original string.
#
# Constraints
# No need to check inputs; all tests cases will be strings.

def encodeString(stringVal):
    prevChar = None
    myList = []
    x = 1
    
    for char in stringVal:
        if char == prevChar:
            x = x + 1
        else:
            if prevChar is not None:
                myList.append((prevChar,x))
            x = 1
            prevChar = char

    myList.append((prevChar, x))
    return myList

def decodeString(encodedList):
    piecesOfString = []
    
    for char in encodedList:
        miniString = char[0] * char[1]
        piecesOfString.append(miniString)
        
    stringVal = ""
    
    for piece in piecesOfString:
        stringVal = stringVal + piece
        
    return stringVal
