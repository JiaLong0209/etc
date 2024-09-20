#!/bin/bash

input=$1
output=$2

ffmpeg -i ${input} -vcodec libx264 -crf 10 -preset slow -acodec aac -b:a 192k ${output}
