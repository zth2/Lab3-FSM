#!/bin/bash

#open file for vbuddy
~/Documents/iacLAB-0/lab0-devtools/tools/attach_usb.sh

# cleanup
rm -rf obj_dir
rm -f verilated.vcd

# Translate Verilog -> C++ including testbench
# verilator   -Wall --trace \
#             -cc f1_fsm.sv \
#             --exe f1_fsm_tb.cpp \
#             --prefix "Vf1_fsm" \
#             -o Vf1_fsm \
#             -CFLAGS "-isystem /opt/homebrew/Cellar/googletest/1.15.2/include"\
#             -LDFLAGS "-L/opt/homebrew/Cellar/googletest/1.15.2/lib -lgtest -lgtest_main -lpthread" \

verilator   -Wall --cc --trace f1_fsm.sv --exe f1_fsm_tb.cpp

# Build C++ project with automatically generated Makefile
make -j -C obj_dir/ -f Vf1_fsm.mk Vf1_fsm

# Run executable simulation file
./obj_dir/Vf1_fsm