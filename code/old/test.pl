line = re.sub('\((([a-z :]|\([a-z: ]*\)*)|:\)|:\(|)*\)', '', line)
line = re.sub(':\(|:\)|[a-z ]|:', '', line)