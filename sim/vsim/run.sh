#!/bin/bash
set -e

RED="\033[0;31m"
GREEN="\033[0;32m"
BLUE="\033[0;34m"
YELLOW="\033[1;33m"
NC="\033[0m"

rm -rf $BASEDIR/sim/vsim/output/*

if [ ! -d "$BASEDIR/sim/vsim/work" ]; then
  mkdir $BASEDIR/sim/vsim/work
fi

rm -rf $BASEDIR/sim/vsim/work/*

cd $BASEDIR/sim/vsim/work

start=`date +%s`

$VLIB .

$VLOG -sv -svinputport=relaxed $BASEDIR/verilog/conf/configure.sv \
                    $BASEDIR/verilog/rtl/constants.sv \
                    $BASEDIR/verilog/rtl/functions.sv \
                    $BASEDIR/verilog/rtl/wires.sv \
                    $BASEDIR/verilog/rtl/alu.sv \
                    $BASEDIR/verilog/rtl/agu.sv \
                    $BASEDIR/verilog/rtl/bcu.sv \
                    $BASEDIR/verilog/rtl/lsu.sv \
                    $BASEDIR/verilog/rtl/csr_alu.sv \
                    $BASEDIR/verilog/rtl/div.sv \
                    $BASEDIR/verilog/rtl/mul.sv \
                    $BASEDIR/verilog/rtl/predecoder.sv \
                    $BASEDIR/verilog/rtl/postdecoder.sv \
                    $BASEDIR/verilog/rtl/register.sv \
                    $BASEDIR/verilog/rtl/csr.sv \
                    $BASEDIR/verilog/rtl/compress.sv \
                    $BASEDIR/verilog/rtl/buffer.sv \
                    $BASEDIR/verilog/rtl/forwarding.sv \
                    $BASEDIR/verilog/rtl/fetch_stage.sv \
                    $BASEDIR/verilog/rtl/execute_stage.sv \
                    $BASEDIR/verilog/rtl/arbiter.sv \
                    $BASEDIR/verilog/rtl/ccd.sv \
                    $BASEDIR/verilog/rtl/clint.sv \
                    $BASEDIR/verilog/rtl/tim.sv \
                    $BASEDIR/verilog/rtl/pmp.sv \
                    $BASEDIR/verilog/rtl/cpu.sv \
                    $BASEDIR/verilog/rtl/rom.sv \
                    $BASEDIR/verilog/rtl/sram.sv \
                    $BASEDIR/verilog/rtl/spi.sv \
                    $BASEDIR/verilog/rtl/uart_rx.sv \
                    $BASEDIR/verilog/rtl/uart_tx.sv \
                    $BASEDIR/verilog/rtl/soc.sv \
                    $BASEDIR/verilog/tb/testbench.sv

cp $BASEDIR/riscv/$PROGRAM.riscv $BASEDIR/sim/vsim/output/$PROGRAM.riscv

FILE=$BASEDIR/sim/vsim/output/$PROGRAM

${RISCV}/bin/riscv32-unknown-elf-nm -A ${FILE}.riscv | grep -sw 'tohost' | sed -e 's/.*:\(.*\) D.*/\1/' > ${FILE}.host
${RISCV}/bin/riscv32-unknown-elf-objcopy -O binary ${FILE}.riscv ${FILE}.bin
$PYTHON $BASEDIR/py/bin2dat.py --input ${FILE}.riscv --address 0x0 --offset 0x100000
cp ${FILE}.dat sram.dat
cp ${FILE}.host host.dat
if [ "$DUMP" = "1" ]
then
  $VSIM -c testbench -do "add wave -recursive *; run -all" +MAXTIME=$MAXTIME +REGFILE=${FILE}.reg +CSRFILE=${FILE}.csr +MEMFILE=${FILE}.mem +FREGFILE=${FILE}.freg +FILENAME=${FILE}.vcd -wlf ${FILE}.wlf
else
  $VSIM -c testbench -do "run -all" +MAXTIME=$MAXTIME
fi

end=`date +%s`
echo Execution time was `expr $end - $start` seconds.
