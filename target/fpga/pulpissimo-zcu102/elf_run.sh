#!/bin/bash

trap "exit" INT TERM
trap "kill 0" EXIT


SCRIPTDIR=$(dirname $0)
UART_TTY=${PULP_ZCU102_UART_TTY:=/dev/ttyUSB2}
UART_BAUDRATE=${PULP_ZCU102_UART_BAUDRATE:=115200}

#Execute gdb and connect to openocd via pipe
sudo /usr/local/bin/openocd -f $SCRIPTDIR/openocd-zcu102-digilent-jtag-hs2.cfg &
/opt/riscv/bin/riscv32-unknown-elf-gdb -x $SCRIPTDIR/elf_run.gdb $1 &
sleep 3
sudo minicom -D $UART_TTY -b $UART_BAUDRATE


