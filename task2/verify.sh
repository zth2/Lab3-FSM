#!/bin/bash

#open file for vbuddy
~/Documents/iacLAB-0/lab0-devtools/tools/attach_usb.sh

# cleanup
rm -rf obj_dir
rm -f sinegen.vcd

# Translate Verilog -> C++ including testbench
verilator   -Wall --trace \
            -cc f1_fsm.sv \
            --exe verify.cpp \
            --prefix "Vdut" \
            -o Vdut \
            -CFLAGS "-isystem /opt/homebrew/Cellar/googletest/1.15.2/include"\
            -LDFLAGS "-L/opt/homebrew/Cellar/googletest/1.15.2/lib -lgtest -lgtest_main -lpthread" \

# Build C++ project with automatically generated Makefile
make -j -C obj_dir/ -f Vdut.mk

# Run executable simulation file
./obj_dir/Vdut
    