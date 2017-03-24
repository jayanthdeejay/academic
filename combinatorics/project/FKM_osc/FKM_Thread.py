import time
def toString(List):
    return ''.join(List)

strings = []
def allLexicographicRecur (string, data, last, index):
    length = len(string)
    for i in range(length):
        data[index] = string[i]
        if index==last:
            strings.append(toString(data))
        else:
            allLexicographicRecur(string, data, last, index+1)

def allLexicographic(string, length):
    global strings
    strings = []
    data = [""] * (length+1)
    string = sorted(string)
    allLexicographicRecur(string, data, length-1, 0)



def necklaces(p):
    for i in p:
        for j in range(1,len(i)):
            if (not(i[1:]+i[:1]==i)):
                x = i[j:]+i[:j]
                if x in p:
                    if (not(i==x)):
                        p.remove(x)
    return p

def atleast(x,val):
    p = []
    for i in x:
        sum = 0
        for j in i:
            sum += int(j)
        if (sum >= val):
            p.append(i)
    return p

def aperiodic(p):
    prefix = []
    for i in p:
        if(len(i)%2 == 0):
            if(i[1:]+i[:1]==i):
                prefix.append(i[:1])
            elif(i[:2]*(len(i)/2)==i):
                prefix.append(i[:2])
            elif(i[:len(i)/2]*2==i):
                prefix.append(i[:len(i)/2])
            else:
                prefix.append(i)
        elif(len(i)==9):
            if(i[1:]+i[:1]==i):
                prefix.append(i[:1])
            elif(i[:3]*3==i):
                prefix.append(i[:3])
            else:
                prefix.append(i)
        else:
            if(i[1:]+i[:1]==i):
                prefix.append(i[:1])
            else:
                prefix.append(i)
    return prefix


"""
string = raw_input("String: ")
length = input("Length: ")
allLexicographic(string, length)
prompt = "1. De Bruijn Sequence\n2. Universal Cycle\n1/2? "
choice = input(prompt)
if(choice == 1):
    strings = necklaces(strings)
    strings = aperiodic(strings)
    strings = "".join(strings)
    print strings

else:
    val = input("Enter val such that each string has sum at least val: ")
    strings = atleast(strings, val)
    strings = necklaces(strings)
    strings = aperiodic(strings)
    strings = "".join(strings)
    print strings
"""
f = open("FKM_output.txt", "a")
for sample in range(10):
    for i in range(2,10):
        for j in range(2,10):
            string = ""
            for k in range (1,j+1):
                string += str(k)
            start_time = time.time()
            allLexicographic(string, i)
            strings = necklaces(strings)
            strings = aperiodic(strings)
            strings = "".join(strings)
            f.write("%d, %d, %.8f\n" %(i, j, time.time()-start_time))
    f.write("\n")
