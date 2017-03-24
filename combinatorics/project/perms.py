def toString(List):
    return ''.join(List)
dataList = [] 
def allLexicographicRecur (string, data, last, index):
    length = len(string)
    for i in range(length):
        data[index] = string[i]
        if index==last:
            dataList.append(toString(data))
            #print(toString(data))
        else:
            allLexicographicRecur(string, data, last, index+1)
             
def allLexicographic(string, length):
    data = [""] * (length+1)
    string = sorted(string)
    allLexicographicRecur(string, data, length-1, 0)

string = raw_input("String: ")
length = input("Length: ")
allLexicographic(string, length)
print dataList
