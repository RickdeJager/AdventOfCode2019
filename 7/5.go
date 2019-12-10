// Translation of Day 5. Originally written in Erlang

package main

import "fmt"
import "os"


func get_args(index int, codes []int, num_used int) (int, int, int) {
	opcode := codes[index]
	if index+1 >= len(codes) || num_used < 1 {
		return 0, 0, 0
	}

	arg1 := codes[index+1]
	if (opcode / 100) % 10 == 0 {
		   arg1 = codes[arg1]
	}

	if index+2 >= len(codes) || num_used < 2{
		return arg1, 0, 0
	}

	arg2 := codes[index+2]
	if (opcode / 1000) % 10 == 0 {
		   arg2 = codes[arg2]
	}

	if index+3 >= len(codes) || num_used < 3{
		return arg1, arg2, 0
	}
	arg3 := codes[index+3]

	return arg1, arg2, arg3
}

func done(codes []int) {
	fmt.Println("[99] DONE. codes[0] = ", codes[0])
	os.Exit(0)
}

func add(index *int, codes []int) []int {
	a1, a2, a3 := get_args(*index, codes, 3)
	codes[a3] = a1+a2
	(*index) += 4
	return codes
}

func mul(index *int, codes []int) []int{
	a1, a2, a3 := get_args(*index, codes, 3)
	codes[a3] = a1*a2
	(*index) += 4
	return codes
}

func inp(index *int, codes []int) []int {
	val := 1
	a1 := codes[(*index)+1]
	codes[a1] = val
	(*index) += 2
	return codes
}

func out(index *int, codes []int) {
	a1, _, _ := get_args(*index, codes, 1)
	fmt.Println("[04] PRINT. ", a1)
	(*index) += 2
}

func jt(index *int, codes []int) []int {
	return codes
}

func jf(index *int, codes []int) []int {
	return codes
}

func lt(index *int, codes []int) []int {
	return codes
}

func eq(index *int, codes []int) []int {
	return codes
}

func step(index *int, codes []int) {
	opcode := codes[*index] % 100
	switch opcode {
	case 1: add(index, codes)
	case 2: mul(index, codes)
	case 3: inp(index, codes)
	case 4: out(index, codes)
	case 5: jt(index, codes)
	case 6: jf(index, codes)
	case 7: lt(index, codes)
	case 8: eq(index, codes)
	default: os.Exit(0)
	}
}

func main() {
codes := []int{3,225,1,225,6,6,1100,1,238,225,104,0,1102,67,92,225,1101,14,84,225,1002,217,69,224,101,-5175,224,224,4,224,102,8,223,223,101,2,224,224,1,224,223,223,1,214,95,224,101,-127,224,224,4,224,102,8,223,223,101,3,224,224,1,223,224,223,1101,8,41,225,2,17,91,224,1001,224,-518,224,4,224,1002,223,8,223,101,2,224,224,1,223,224,223,1101,37,27,225,1101,61,11,225,101,44,66,224,101,-85,224,224,4,224,1002,223,8,223,101,6,224,224,1,224,223,223,1102,7,32,224,101,-224,224,224,4,224,102,8,223,223,1001,224,6,224,1,224,223,223,1001,14,82,224,101,-174,224,224,4,224,102,8,223,223,101,7,224,224,1,223,224,223,102,65,210,224,101,-5525,224,224,4,224,102,8,223,223,101,3,224,224,1,224,223,223,1101,81,9,224,101,-90,224,224,4,224,102,8,223,223,1001,224,3,224,1,224,223,223,1101,71,85,225,1102,61,66,225,1102,75,53,225,4,223,99,0,0,0,677,0,0,0,0,0,0,0,0,0,0,0,1105,0,99999,1105,227,247,1105,1,99999,1005,227,99999,1005,0,256,1105,1,99999,1106,227,99999,1106,0,265,1105,1,99999,1006,0,99999,1006,227,274,1105,1,99999,1105,1,280,1105,1,99999,1,225,225,225,1101,294,0,0,105,1,0,1105,1,99999,1106,0,300,1105,1,99999,1,225,225,225,1101,314,0,0,106,0,0,1105,1,99999,8,226,226,224,102,2,223,223,1005,224,329,1001,223,1,223,1108,677,677,224,1002,223,2,223,1006,224,344,101,1,223,223,1007,226,677,224,102,2,223,223,1005,224,359,101,1,223,223,1007,677,677,224,1002,223,2,223,1006,224,374,101,1,223,223,1108,677,226,224,1002,223,2,223,1005,224,389,1001,223,1,223,108,226,677,224,102,2,223,223,1006,224,404,101,1,223,223,1108,226,677,224,102,2,223,223,1005,224,419,101,1,223,223,1008,677,677,224,102,2,223,223,1005,224,434,101,1,223,223,7,677,226,224,1002,223,2,223,1005,224,449,101,1,223,223,1008,226,226,224,102,2,223,223,1005,224,464,1001,223,1,223,107,226,677,224,1002,223,2,223,1006,224,479,1001,223,1,223,107,677,677,224,102,2,223,223,1005,224,494,1001,223,1,223,1008,226,677,224,102,2,223,223,1006,224,509,1001,223,1,223,1107,677,226,224,102,2,223,223,1005,224,524,101,1,223,223,1007,226,226,224,1002,223,2,223,1006,224,539,1001,223,1,223,107,226,226,224,102,2,223,223,1006,224,554,101,1,223,223,108,677,677,224,1002,223,2,223,1006,224,569,1001,223,1,223,7,226,677,224,102,2,223,223,1006,224,584,1001,223,1,223,8,677,226,224,102,2,223,223,1005,224,599,101,1,223,223,1107,677,677,224,1002,223,2,223,1005,224,614,101,1,223,223,8,226,677,224,102,2,223,223,1005,224,629,1001,223,1,223,7,226,226,224,1002,223,2,223,1006,224,644,1001,223,1,223,108,226,226,224,1002,223,2,223,1006,224,659,101,1,223,223,1107,226,677,224,1002,223,2,223,1006,224,674,101,1,223,223,4,223,99,226}
	index := 0
	for ;; {
		step(&index, codes)
	}
}
