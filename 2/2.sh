IFS=',' read -ra org <<< "$(<"input.txt")"

# Set noun and verb
function set_nv () {
        codes[1]=$1
        codes[2]=$2
}

# Execute one step, from index $1
function step () {
	# Bash won't crash on index out of bounds :D
	i1=${codes[$1+1]}
	i2=${codes[$1+2]}
	i3=${codes[$1+3]}
        if [ ${codes[$1]} -eq 1 ]; then
                codes[$i3]=$((${codes[$i1]} + ${codes[$i2]}))
                step_res=0
                return
        elif [ ${codes[$1]} -eq 2 ]; then
                codes[$i3]=$((${codes[$i1]} * ${codes[$i2]}))
                step_res=0
                return
        elif [ ${codes[$1]} -eq 99 ]; then
                step_res=${codes[0]}
                return
        else
                echo "Invalid state"
                echo ${codes[$1]}
                exit 1
        fi
}

# Execute a full run based on a verb and noun
function run () {
	# Restore the codes array
        codes=("${org[@]}")
        set_nv $1 $2
        run_res=0
        i=0
        while [ $run_res -eq 0 ]; do
                step $i
                run_res=$step_res
                i=$(($i + 4))
        done
        return
d
}

run 12 2
echo "Solution for part one: ""$run_res"

for noun in {0..99}; do
        for verb in {0..99}; do
                run $noun $verb
                if [ $run_res -eq 19690720 ]; then
                        solution2=$((100*$noun + $verb))
                        break
                fi
        done
done
# Noun and verb will be set to `99` here, hence the `solution2` variable.
echo "Solution for part two: ""$solution2"
