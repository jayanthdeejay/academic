import time
def lyndonWords(s,n):
    strings = [0]
    while strings:
        strings[-1] += 1
        yield strings 
        los = len(strings)
        while len(strings) < n:
            strings.append(strings[-los])
        while strings and strings[-1] == s:
            strings.pop()


def lyndonWordsBinary(s,n):
    strings = [-1]
    while strings:
        strings[-1] += 1
        yield strings
        los = len(strings)
        while len(strings) < n:
            strings.append(strings[-los])
        while strings and strings[-1] == s - 1:
            strings.pop()


def uCycle(s,n):
    cycle = []
    for c in lyndonWords(s,n):
        if n % len(c) == 0:
            cycle += c
    return cycle

def uCycleBinary(s,n):
    cycle = []
    for c in lyndonWordsBinary(s,n):
        if n % len(c) == 0:
            cycle += c
    return cycle



start_time = time.time()
f=open("new.txt","a")
"""
for k in range (2,11):
    for i in range(2,11):
        for j in range(10):
            start_time = time.time()
            uCycle(k,i)
            f.write("%d, %d, %.8f\n" %(k, i, time.time()-start_time))
    f.write("\n")
f.write("\n\nTotal time: %.6f" % (time.time()-totime))
"""
"""
#for i in range(10):
for j in range(2,11):
    start_time = time.time()
    uCycle(10,j)
    f.write("%d, %d, %.8f\n" %(9, j, time.time()-start_time))
"""
uCycle(9,9)
f.write("%d, %d, %.8f" %(9, 9, time.time()-start_time))
