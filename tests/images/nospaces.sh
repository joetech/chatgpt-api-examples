#!/bin/bash

for i in *.bmp *.jpg *.png
do
    mv "$i" "${i// /-}"
done