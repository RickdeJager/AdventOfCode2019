org=(1 0 0 3 1 1 2 3 1 3 4 3 1 5 0 3 2 1 6 19 1 19 6 23 2 23 6 27 2 6 27 31 2 13 31 35 1 9 35 39 2 10 39 43 1 6 43 47 1 13 47 51 2 6 51 55 2 55 6 59 1 59 5 63 2 9 63 67 1 5 67 71 2 10 71 75 1 6 75 79 1 79 5 83 2 83 10 87 1 9 87 91 1 5 91 95 1 95 6 99 2 10 99 103 1 5 103 107 1 107 6 111 1 5 111 115 2 115 6 119 1 119 6 123 1 123 10 127 1 127 13 131 1 131 2 135 1 135 5 0 99 2 14 0 0)
codes=(1 0 0 3 1 1 2 3 1 3 4 3 1 5 0 3 2 1 6 19 1 19 6 23 2 23 6 27 2 6 27 31 2 13 31 35 1 9 35 39 2 10 39 43 1 6 43 47 1 13 47 51 2 6 51 55 2 55 6 59 1 59 5 63 2 9 63 67 1 5 67 71 2 10 71 75 1 6 75 79 1 79 5 83 2 83 10 87 1 9 87 91 1 5 91 95 1 95 6 99 2 10 99 103 1 5 103 107 1 107 6 111 1 5 111 115 2 115 6 119 1 119 6 123 1 123 10 127 1 127 13 131 1 131 2 135 1 135 5 0 99 2 14 0 0)

function set_nv () {
        codes[1]=$1
        codes[2]=$2
}

function step () {
        if [ ${codes[$1]} -eq 1 ]; then
                i1=${codes[$1+1]}
                i2=${codes[$1+2]}
                i3=${codes[$1+3]}
                codes[$i3]=$((${codes[$i1]} + ${codes[$i2]}))
                return 0
        elif [ ${codes[$1]} -eq 2 ]; then
                i1=${codes[$1+1]}
                i2=${codes[$1+2]}
                i3=${codes[$1+3]}
                codes[$i3]=$((${codes[$i1]} * ${codes[$i2]}))
                return 0
        elif [ ${codes[$1]} -eq 99 ]; then
                echo "Exited normally"
                return ${codes[0]}
        else
                echo "Invalid state"
                echo ${codes[$1]}
                exit 1
        fi
}
i=0
function run () {
        codes=("${org[@]}")
        set_nv $1 $2
        run_res=0
        echo $run_res
        while [ $run_res -eq 0 ]; do
                run_res=$(step $i)
                i=$(($i + 4))
        done
        return $run_res
}
for i in {0..100}; do
        for j in {0..100}; do
                res=$(run $i $j)
                if [ $res -eq 19690720 ]; then
                        echo $i
                        echo $j
                fi
        done
done
