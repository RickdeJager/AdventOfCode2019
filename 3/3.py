import sys

grid = {}

overlaps = []

w1, w2 = None, None
with open('input.txt', 'r') as in_file:
    lines = in_file.readlines()
    w1 = lines[0].strip().split(',')
    w2 = lines[1].strip().split(',')

def lay_wire(wire, symbol):
    ix = 0
    iy = 0
    wire_step = 0
    for w in wire:
        dx, dy = 0, 0
        if w[0] == 'L':
            dx = -1
        elif w[0] == 'R':
            dx = 1
        elif w[0] == 'U':
            dy = -1
        elif w[0] == 'D':
            dy = 1
        else:
            print("Direction {} not recognized".format(w[0]))
            sys.exit(1)
        for i in range(int(w[1:])):
            ix = ix + dx
            iy = iy + dy
            wire_step += 1
            if (ix, iy) == (0, 0):
                continue
            key = "{},{}".format(ix, iy)
            if not key in grid:
                grid[key] = (symbol, wire_step)
            elif grid[key][0] != symbol:
                #overlaps.append((ix, iy, wire_step))
                overlaps.append((grid[key][1], wire_step))

#w1 = ['R75','D30','R83','U83','L12','D49','R71','U7','L72']
#w2 = ['U62','R66','U55','R34','D71','R55','D58','R83']
lay_wire(w1, '1')
lay_wire(w2, '2')
closest = None
closest_d = 10000000
for i in overlaps:
    print(i)
    #d = abs(i[0] - 0) + abs(i[1] - 0)
    d = i[0] + i[1]
    if d < closest_d:
        closest = (i[0], i[1])
        closest_d = d

print(closest, closest_d)
