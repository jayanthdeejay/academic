import time
def aperiodicPrefixes(s,n):
    z = [[]]
    strings = [0]
    while strings:
        strings[-1] += 1
        z.append(strings[:])
        los = len(strings)
        while len(strings) < n:
            strings.append(strings[-los])
        while strings and strings[-1] == s:
            strings.pop()
    del z[0]
    return z

def aperiodicBinaryPrefixes(n):
    z = [[]]
    strings = [-1]
    while strings:
        strings[-1] += 1
        z.append(strings[:])
        los = len(strings)
        while len(strings) < n:
            strings.append(strings[-los])
        while strings and strings[-1] == 1:
            strings.pop()
    del z[0]
    return z

def binaryCycle(n):
    cycle = []
    for c in aperiodicBinaryPrefixes(n):
        if n%len(c) == 0:
            cycle += c
    return cycle


def uCycle(s,n):
    cycle = []
    for c in aperiodicPrefixes(s,n):
        if n % len(c) == 0:
            cycle += c
    return cycle


#print "De Bruijn Sequence for s = 3, n = 4:"
#print ''.join(str(p) for p in uCycle(3,4))
#print "\nBinary De Bruijn Sequence for n = 4:"
#print ''.join(str(p) for p in binaryCycle(4))

def DeBruijnSequence(s,n):
    output = []
    for w in LengthLimitedLyndonWords(s,n):
        if n % len(w) == 0:
            output += w
    return output
totime = time.time()
f=open("output.txt","a")
for k in range (10):
    for i in range(2,9):
        for j in range(2,9):
            start_time = time.time()
            #print "De Bruijn sequence for S: " + str(i) + ", N: " + str(j) + " is:\n" + ''.join(str(p) for p in uCycle(i,j))
            uCycle(i,j)
            #seconds = time.time() - start_time
            #m, s = divmod(seconds, 60)
            #h, m = divmod(m, 60)
            f.write("%d, %d, %.7f\n" %(i, j, time.time()-start_time))
            #print "S: %d, N: %d, Time: %.6f" % (i, j, time.time()-start_time)

f.write("\n\n")
print "Total time: %.6f" % (time.time()-totime)
