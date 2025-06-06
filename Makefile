default: simulate

export VERILATOR ?= verilator
export VERIBLE ?= verible
export PYTHON ?= python3
export SERIAL ?= /dev/ttyUSB0
export BASEDIR ?= $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
export BENCHMARK ?= benchmark

export QUARTUS ?= quartus
export VIVADO ?= vivado

export JTAGCONFIG ?= jtagconfig

export XVLOG ?= xvlog
export XELAB ?= xelab
export XSIM ?= xsim
export VLIB ?= vlib
export VLOG ?= vlog
export VSIM ?= vsim

export SYNTHESIS ?= 0# "1" on, "0" off

export PROGRAM ?= coremark
export SRAM_SIZE ?= 0x80000# Altera -> 0x80000, Xilinx -> 0x40000

export RISCV ?= /opt/rv32imc
export ARCH ?= rv32imc_zicsr_zifencei
export ABI ?= ilp32

export MAXTIME ?= 10000000
export DUMP ?= 0# "1" on, "0" off

compile:
	benchmark/riscv-tests.sh
	benchmark/coremark.sh
	benchmark/whetstone.sh
	benchmark/free-rtos.sh
	benchmark/isa.sh
	benchmark/rom.sh

parse:
	check/run.sh

verilator:
	sim/verilator/run.sh

vsim:
	sim/vsim/run.sh

xsim:
	sim/xsim/run.sh

quartus:
	fpga/quartus/run.sh

vivado:
	fpga/vivado/run.sh

program:
	serial/transfer.sh

tool:
	tools/install-riscv.sh
	tools/install-verible.sh
	tools/install-verilator.sh
