input="$1"
output="$2"
crf="${3:-24}"
preset="${4:-slow}"

ffmpeg -i ${input} -c:v libx264 -crf ${crf} -preset ${preset} -c:a copy ${output}
