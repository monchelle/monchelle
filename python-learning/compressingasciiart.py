# Create two new functions: encodeFile and decodeFile.
# encodeFile opens a file containing an ASCII art smiley face, performs some modification to the data in the file, and writes that data to a new file. The new file size should be smaller than the original file size.
# decodeFile opens the file and performs some reverse of the original modification to expand the data in the file to its original form. It then returns the original string.
# Parameters:
# filename: The filename you must open in order to perform the required operation
# newFilename: The filename you must save the modified file to in the encodeFile function
# Result:
# decodeFile must return the "decoded" (uncompressed) data string.

import os

def encodeString(stringVal):
    encodedList = []
    prevChar = None
    count = 0
    for char in stringVal:
        if prevChar != char and prevChar is not None:
            encodedList.append((prevChar, count))
            count = 0
        prevChar = char
        count = count + 1
    encodedList.append((prevChar, count))
    return encodedList

def decodeString(encodedList):
    decodedStr = ''
    for item in encodedList:
        decodedStr = decodedStr + item[0] * item[1]
    return decodedStr

def encodeFile(filename, newFilename):
    
    with open(filename, 'r') as f:
        print(f'Original file size: {os.path.getsize(filename)} bytes')
        stringVal = f.read()
        stringVal = stringVal.replace('\n', '|')  # Remove newlines for compression
        encodedList = encodeString(stringVal)
        encodedStr = ''

        for char in encodedList:
            encodedStr = encodedStr + char[0] + str(char[1])
    
    with open(newFilename, 'w') as f:
        f.write(encodedStr)
        print(f'New file size: {os.path.getsize(newFilename)} bytes')
    

def decodeFile(filename):
    
    with open(filename, 'r') as f:
        encodedStr = f.read()
        encodedList = []
        i = 0
        while i < len(encodedStr):
            char = encodedStr[i]
            i += 1
            countStr = ''
            while i < len(encodedStr) and encodedStr[i].isdigit():
                countStr += encodedStr[i]
                i += 1
            count = int(countStr)
            encodedList.append((char, count))

    decodedStr = decodeString(encodedList)
    decodedStr = decodedStr.replace('|', '\n')  # Restore newlines
    return decodedStr
