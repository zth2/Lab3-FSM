#include "gtest/gtest.h"
#include "Vf1_fsm.h"
#include "verilated.h"
#include "verilated_vcd_c.h"
#include "vbuddy.cpp"

int main(int argc, char **argv, char **env){

    int i;
    int clk;

    Verilated::commandArgs(argc, argv);
    Vf1_fsm* top = new Vf1_fsm;
    Verilated::traceEverOn(true);
    VerilatedVcdC* tfp = new VerilatedVcdC;
    top->trace (tfp, 99);
    tfp->open ("waveform.vcd");

    if(vbdOpen()!=1) return(-1);
    vbdHeader("L3T2: ");
    vbdSetMode(1);

    top->clk = 1;
    top->rst = 0;
    top->en = 1;

    for(i = 0; i < 1000000; i++){

        for(clk = 0; clk < 2; clk++){

            tfp->dump (2*i+clk);
            top->clk = !top->clk;
            top->eval ();
        }

        top->en = vbdFlag();

        vbdBar(top->data_out & 0xFF);
        
        //Finishes when simulation is done or when q is pressed.
        if((Verilated::gotFinish()) || (vbdGetkey()=='q')){
            exit(0);
        }
        
    }

    vbdClose();
    tfp->close();
    exit(0);
}
