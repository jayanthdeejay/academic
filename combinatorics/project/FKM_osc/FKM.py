import time
def toString(List):
    return ''.join(List)

strings = []
def stringPermutations (strng, dat, lst, idx):
    length = len(strng)
    for i in range(length):
        dat[idx] = strng[i]
        if idx==lst:
            strings.append(toString(dat))
        else:
            stringPermutations (strng, dat, lst, idx+1)

def generateStrings (strng, length):
    global strings
    strings = []
    dat = [""] * (length+1)
    strng = sorted(strng)
    stringPermutations (strng, dat, length-1, 0)



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
strng = raw_input("String: ")
length = input("Length: ")
generateStrings(strng, length)
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


f = open("FKM_output3.txt", "a")
for sample in range(10):
    for j in range(2,8):
        strng = "1234567"
        start_time = time.time()
        generateStrings(strng, j)
        strings = necklaces(strings)
        strings = aperiodic(strings)
        strings = "".join(strings)
        f.write("%d, %d, %.8f\n" %(7, j, time.time()-start_time))
    f.write("\n")



f = open("FKM_output.txt", "a")
string = "1234567"
for i in range(10):
	start_time = time.time()
	generateStrings(string,7)
	strings = necklaces(strings)
	strings = aperiodic(strings)
	strings = "".join(strings)
	f.write("%d, %d, %.8f\n" %(7, 7, time.time()-start_time))

"""

f = open("FKM_last.txt", "a")
start_time = time.time()
generateStrings("12345", 7)
strings = necklaces(strings)
strings = aperiodic(strings)
strings = "".join(strings)
f.write("%d, %d, %.8f\n" %(5, 7, time.time()-start_time))
print "\n"
strings = []
start_time = time.time()
generateStrings("12346", 8)
strings = necklaces(strings)
strings = aperiodic(strings)
strings = "".join(strings)
f.write("%d, %d, %.8f\n" %(5, 8, time.time()-start_time))
print "\n"
strings = []
start_time = time.time()
generateStrings("12347", 9)
strings = necklaces(strings)
strings = aperiodic(strings)
strings = "".join(strings)
f.write("%d, %d, %.8f\n" %(5, 9, time.time()-start_time))
