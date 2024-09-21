#!/bin/bash
filename=$1
name=$(echo $filename | cut -d '.' -f 1)
tsc "${name}.ts" && node "${name}.js"
rm "${name}.js"
