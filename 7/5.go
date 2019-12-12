// Translation of Day 5. Originally written in Erlang

package main

import "fmt"
import "os"
import "strings"
import "strconv"
import "io/ioutil"


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

func inp(index *int, codes []int ,input_index *int, inputs[]int ) []int {
	val := inputs[(*input_index)]
	a1 := codes[(*index)+1]
	codes[a1] = val
	(*index) += 2
	(*input_index) += 1
	return codes
}

func out(index *int, codes []int, out_buf *int) {
	a1, _, _ := get_args(*index, codes, 1)
	(*out_buf) = a1
	fmt.Println("[04] PRINT. ", a1)
	(*index) += 2
}

func jt(index *int, codes []int) {
	a1, a2, _ := get_args(*index, codes, 2)
	if a1 != 0 {
		(*index) = a2
	} else {
		(*index) += 3
	}
}

func jf(index *int, codes []int) {
	a1, a2, _ := get_args(*index, codes, 2)
	if a1 == 0 {
		(*index) = a2
	} else {
		(*index) += 3
	}
}

func lt(index *int, codes []int) {
	a1, a2, a3 := get_args(*index, codes, 3)
	if a1 < a2 {
		codes[a3] = 1
	} else {
		codes[a3] = 0
	}
	(*index) += 4
}

func eq(index *int, codes []int) {
	a1, a2, a3 := get_args(*index, codes, 3)
	if a1 == a2 {
		codes[a3] = 1
	} else {
		codes[a3] = 0
	}
	(*index) += 4
}

func step(index *int, codes []int, input_index *int, inputs []int, out_buf *int) int {
	opcode := codes[*index] % 100
	switch opcode {
	case 1: add(index, codes)
	case 2: mul(index, codes)
	case 3: inp(index, codes, input_index, inputs)
	case 4: out(index, codes, out_buf)
	case 5: jt(index, codes)
	case 6: jf(index, codes)
	case 7: lt(index, codes)
	case 8: eq(index, codes)
	case 99: return *out_buf
	default: fmt.Println("invalid opcode: ", opcode)
		return 0
	}
	return -1
}

func sim(string_codes []string, setting int, input int) int{
	codes := []int{}
	for i := range string_codes {
		int_code, _ := strconv.Atoi(string_codes[i])
		codes = append(codes, int_code)
	}
	index := 0
	input_index := 0
	inputs := []int{setting, input} // Setting, input value
	res := -1
	out_buf := 0
	for ;res < 0; {
		res = step(&index, codes, &input_index, inputs, &out_buf)
	}
	return res
}

func main() {
	file, _ := ioutil.ReadFile("input.txt")
	contents := string(file)
	contents = contents[:len(contents)-1]
	codes := strings.Split(contents, ",")
	max := 0
	settings := []int{0, 0, 0, 0, 0}
//	res_a := 0
	options := []int{0, 1, 2, 3, 4}


	for a:=0; a < 5; a++ {
		res_a := sim(codes, a, 0)
		for b:=0; b < 5; b++ {
			res_b := sim(codes, b, res_a)
			for c:=0; c < 5; c++ {
				res_c := sim(codes, c, res_b)
				for d:=0; d < 5; d++ {
					res_d := sim(codes, d, res_c)
					for e:=0; e < 5; e++ {
						res_e := sim(codes, e, res_d)
						if res_e > max {
							max = res_e
							settings[0] = a
							settings[1] = b
							settings[2] = c
							settings[3] = d
							settings[4] = e
						}
					}
				}
			}
		}
	}
	fmt.Println("Max", max, settings)
//	fmt.Println(sim(codes, 5, 0))
}
