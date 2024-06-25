#!/bin/bash

echo "==== running on CPU ===="
python3 /app/app.py 

echo "==== running on GPU ===="
python3 /app/app.py gpu

echo "==== done... sleeping for 4h ===="
sleep 4h