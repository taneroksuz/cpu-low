#!/bin/bash
set -e

start=`date +%s`

${VERIBLE}-verilog-format --inplace ${BASEDIR}/verilog/conf/configure.sv \
                                    ${BASEDIR}/verilog/rtl/constants.sv \
                                    ${BASEDIR}/verilog/rtl/functions.sv \
                                    ${BASEDIR}/verilog/rtl/wires.sv \
                                    ${BASEDIR}/verilog/rtl/alu.sv \
                                    ${BASEDIR}/verilog/rtl/agu.sv \
                                    ${BASEDIR}/verilog/rtl/bcu.sv \
                                    ${BASEDIR}/verilog/rtl/lsu.sv \
                                    ${BASEDIR}/verilog/rtl/csr_alu.sv \
                                    ${BASEDIR}/verilog/rtl/div.sv \
                                    ${BASEDIR}/verilog/rtl/mul.sv \
                                    ${BASEDIR}/verilog/rtl/predecoder.sv \
                                    ${BASEDIR}/verilog/rtl/postdecoder.sv \
                                    ${BASEDIR}/verilog/rtl/register.sv \
                                    ${BASEDIR}/verilog/rtl/csr.sv \
                                    ${BASEDIR}/verilog/rtl/compress.sv \
                                    ${BASEDIR}/verilog/rtl/buffer.sv \
                                    ${BASEDIR}/verilog/rtl/forwarding.sv \
                                    ${BASEDIR}/verilog/rtl/fetch_stage.sv \
                                    ${BASEDIR}/verilog/rtl/execute_stage.sv \
                                    ${BASEDIR}/verilog/rtl/arbiter.sv \
                                    ${BASEDIR}/verilog/rtl/cdc.sv \
                                    ${BASEDIR}/verilog/rtl/clint.sv \
                                    ${BASEDIR}/verilog/rtl/tim.sv \
                                    ${BASEDIR}/verilog/rtl/cpu.sv \
                                    ${BASEDIR}/verilog/rtl/rom.sv \
                                    ${BASEDIR}/verilog/rtl/ram.sv \
                                    ${BASEDIR}/verilog/rtl/spi.sv \
                                    ${BASEDIR}/verilog/rtl/uart_rx.sv \
                                    ${BASEDIR}/verilog/rtl/uart_tx.sv \
                                    ${BASEDIR}/verilog/rtl/soc.sv \
                                    ${BASEDIR}/verilog/tb/testbench.sv

end=`date +%s`
echo Execution time was `expr $end - $start` seconds.