#!/bin/bash

for dir in `ls`; do
  if [[ ! -e "$dir/.git" ]]; then
    echo "$dir is not a git repo."
    continue
  fi

  echo "===== $dir ====="
  cd $dir


  echo "git pull start..."
  git pull
  
  echo ""
  cd ..
done

