#!/bin/bash
target="~/Games/osu/osu.AppImage"
file=$1

echo "Copy $file to $target"

copy $1 $target

echo "Finished!"
