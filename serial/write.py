#!/usr/bin/env python3

import sys
import time
import serial


if __name__ == '__main__':

    if len(sys.argv) < 3:
        print('Expected usage: {0} <port> <filename>'.format(sys.argv[0]))
        sys.exit(1)

    fb = open(sys.argv[2], 'rb')
    ba = bytearray(fb.read())

    ser = serial.Serial(
        port=sys.argv[1],
        baudrate=115200,
        parity='N',
        stopbits=1,
        bytesize=8,
        timeout=None,
        xonxoff=0,
        rtscts=0
    )

    if ser.isOpen():
        ser.close()

    ser.open()
    ser.isOpen()
    
    ser.write(ba)

    ser.close()

    sys.exit(0)