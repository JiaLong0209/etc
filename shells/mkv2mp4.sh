#!/bin/bash

input=$1
output=$2

ffmpeg -i ${input} -vcodec libx264 -crf 23 -preset medium -acodec aac -b:a 192k ${output}
