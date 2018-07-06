#!/usr/bin/env bash

count=$1
end=$2
echo -n "$count"
while [[ $count -lt $end ]]; do
  count=$(($count + 1))
  echo -n " $count"
done
echo ""
