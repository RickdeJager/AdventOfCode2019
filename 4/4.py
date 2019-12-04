import sys, re

def check(num):
    s = str(num)
    c = False
    for i in range(1, len(s)):
        if s[i-1] == s[i]:
            c = True
        if int(s[i-1]) > int(s[i]):
            return False
    return c

def check2(num):
    s = str(num)
    c = False
    last = ''
    dupes = re.finditer(r'(\d)\1+', s)
    for i in dupes:
        for j in range(len(i.groups())):
            if len(i.group(j)) == 2:
                c = True
    if not c: return False
    for i in range(1, len(s)):
        last = s[i-1]
        if int(s[i-1]) > int(s[i]):
            return False
    return c


tot = 0
for i in range(307237, 769058):
    if check(i):
        tot += 1
print("Answer to part 1: {}".format(tot))

tot = 0
for i in range(307237, 769058):
    if check2(i):
        tot += 1
print("Answer to part 2: {}".format(tot))


