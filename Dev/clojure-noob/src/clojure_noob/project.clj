def LengthLimitedLyndonWords(s,n):
    w = [-1]
    while w:
        w[-1] += 1
        yield w
        m = len(w)
        while len(w) < n:
            w.append(w[-m])
        while w and w[-1] == s - 1:
            w.pop()


def DeBruijnSequence(s,n):
    output = []
    for w in LengthLimitedLyndonWords(s,n):
        if n % len(w) == 0:
            output += w
    return output


