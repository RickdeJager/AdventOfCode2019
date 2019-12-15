# Some observations: 2 astroids on the same angle block eachother -> Unique angles only
# 1. Select an astroid
# Calculate angles to all other astroids
# Set size = number of visible astroids

from math import acos, sqrt, atan2
astroids = []

with open("input.txt", 'r') as in_file:
    lines = in_file.readlines()
    for i in range(len(lines)):
        line = lines[i]
        for j in range(len(line)):
            char = line[j]
            if char == '#':
                astroids.append((j, i, set()))

#def angle(one, two):
    #return round(acos((one[1]-two[1])/sqrt( (one[0]-two[0])**2 + (one[1]-two[1])**2 )), 3)
def angle(one, two):
    return atan2(one[0]-two[0], one[1]-two[1])

for astroid1 in astroids:
    for astroid2 in astroids:
        if astroid2 == astroid1:
            continue
        astroid1[2].add(angle(astroid1, astroid2))

#print([(len(i[2]), i[0], i[1]) for i in astroids])
m = 0
mi = (0,0)
for i in astroids:
    if len(i[2]) > m:
        m = len(i[2])
        mi = (i[0], i[1])
print(m, mi)

