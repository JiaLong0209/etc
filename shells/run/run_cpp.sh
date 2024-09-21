#!/bin/bash
args=$@
echo "File: $args"
echo "-------------------"
filename=$1

extension=$(echo $filename | cut -d '.' -f 2)
name=$(echo $filename | cut -d '.' -f 1)

g++ "${name}.${extension}" -std=c++11 -Wall -o "${name}.out" && ./"${name}.out"
rm ./"${name}.out"
# g++ "${args}"  && ./a.out && rm ./a.out


