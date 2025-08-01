#!/bin/bash
set -e

export QUARTUS_MULTITHREADING=OFF

RED="\033[0;31m"
GREEN="\033[0;32m"
BLUE="\033[0;34m"
YELLOW="\033[1;33m"
NC="\033[0m"

cd ${BASEDIR}/fpga/vivado

if [ "$SYNTHESIS" = "1" ]
then
  $VIVADO -nojournal -mode batch -source synthesis.tcl
fi

$VIVADO -nojournal -mode batch -source program.tcl