# Convert hexadecimal to decimal
# Write a function to convert a hexadecimal string up to 3 characters long into a decimal integer.
# Do not use Python function int(hexNum, 16) to do this.
# Parameters
# hexNum: Some value that needs to be converted into a decimal number, if possible. Up to three characters long.


hexNum = 'A6G'

hexNumbers = {
    '0': 0, '1': 1, '2': 2, '3': 3, '4': 4, '5': 5, '6': 6, '7': 7, '8': 8, '9': 9,
    'A': 10, 'B': 11, 'C': 12, 'D': 13, 'E': 14, 'F': 15
}

def hexToDec(hexNum):
    # check length
    if len(hexNum) > 3:
        print('None')
        return

    #check characters
    for char in hexNum:
        if char not in hexNumbers: 
            print('None')
            return

    # evaluate
    if len(hexNum) == 1:
        return hexNumbers[hexNum[0]]
    else:
        if len(hexNum) == 2:
            return hexNumbers[hexNum[0]] * 16 + hexNumbers[hexNum[1]]
        else:
            if len(hexNum) == 3:
                return hexNumbers[hexNum[0]] * 256 + hexNumbers[hexNum[1]] * 16 + hexNumbers[hexNum[2]]
                    


hexToDec(hexNum)