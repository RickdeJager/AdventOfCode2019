org=(1 0 0 3 1 1 2 3 1 3 4 3 1 5 0 3 2 1 6 19 1 19 6 23 2 23 6 27 2 6 27 31 2 13 31 35 1 9 35 39 2 10 39 43 1 6 43 47 1 13 47 51 2 6 51 55 2 55 6 59 1 59 5 63 2 9 63 67 1 5 67 71 2 10 71 75 1 6 75 79 1 79 5 83 2 83 10 87 1 9 87 91 1 5 91 95 1 95 6 99 2 10 99 103 1 5 103 107 1 107 6 111 1 5 111 115 2 115 6 119 1 119 6 123 1 123 10 127 1 127 13 131 1 131 2 135 1 135 5 0 99 2 14 0 0)
codes=(1 0 0 3 1 1 2 3 1 3 4 3 1 5 0 3 2 1 6 19 1 19 6 23 2 23 6 27 2 6 27 31 2 13 31 35 1 9 35 39 2 10 39 43 1 6 43 47 1 13 47 51 2 6 51 55 2 55 6 59 1 59 5 63 2 9 63 67 1 5 67 71 2 10 71 75 1 6 75 79 1 79 5 83 2 83 10 87 1 9 87 91 1 5 91 95 1 95 6 99 2 10 99 103 1 5 103 107 1 107 6 111 1 5 111 115 2 115 6 119 1 119 6 123 1 123 10 127 1 127 13 131 1 131 2 135 1 135 5 0 99 2 14 0 0)

function set_nv () {
        codes[1]=$1
        codes[2]=$2
}
step_res=0
run_res=0

function step () {
        if [ ${codes[$1]} -eq 1 ]; then
                i1=${codes[$1+1]}
                i2=${codes[$1+2]}
                i3=${codes[$1+3]}
                codes[$i3]=$((${codes[$i1]} + ${codes[$i2]}))
                step_res=0
                return
        elif [ ${codes[$1]} -eq 2 ]; then
                i1=${codes[$1+1]}
                i2=${codes[$1+2]}
                i3=${codes[$1+3]}
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
function run () {
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
}
run 65 56
echo $run_res
for noun in {0..100}; do
        for verb in {0..100}; do
                run $noun $verb
                echo $run_res
                if [ $run_res -eq 19690720 ]; then
                        echo $((100*$noun + $verb))
                        exit 0
                fi
        done
done
