def change_char(s, p, r):
    return s[:p]+r+s[p+1:]
a = []
l = 25
h = 6
final = "2"*(l*h)
with open('input.txt' ) as in_file:
    lines = in_file.readlines()[0]
    mz = 125
    mi = 0
    for i in range((len(lines)-1)// (l*h)):
        a.append(lines[i*l*h:(i+1)*h*l])
        z = a[i].count('0')
        if z < mz:
            mz = z
            mi = i
        for c in range(len(final)):
            if final[c] == "2":
                final = change_char(final, c, a[i][c])
    print(a[mi].count('1')*a[mi].count('2'))
for c in range(len(final)):
    print("█" if final[c] == "1" else " ", end="" if (c+1) % l != 0 else "\n")
