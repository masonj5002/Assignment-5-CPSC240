#!/bin/bash

echo "Remove old executable files, if there are any"
rm *.out
rm *.lis
rm *.o

echo "Assemble the x86 file series.asm"
nasm -f elf64 -o series.o series.asm

echo "Compile the 'C' file main.c"
gcc -c -fno-pie -no-pie -o main.o main.c

echo "Link the files"
gcc -m64 -o go.out series.o main.o -fno-pie -no-pie

echo "Next, the program will run:
*********************************
"

chmod +x go.out
./go.out