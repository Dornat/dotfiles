#!/bin/bash

ls *.c > test
sed -i 's/$/ \\/' test
sed -i 's/^/\	\	/' test
#sed -i '5r test' Makefile
sed -i '/SRC/r test' Makefile
rm -f test
