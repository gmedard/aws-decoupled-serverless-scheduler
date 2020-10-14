#!/bin/bash
id=0
while [ $id -le $1 ]
do
    echo "This is $id"
    id=$(( $id +1 ))
done