import os
import re

import micro as M
import instruction as INS

dirname = os.path.dirname(__file__)
filename = os.path.join(dirname, "program.asm")
output = os.path.join(dirname, "../computer/program.out")

lines = []

with open(filename) as file:
    for line in file:
        line = line.strip()

        line = re.split('@', line, maxsplit=2)[0]
        if not line:
            continue
        tup = re.split(' +', line)
        if len(tup) > 2:
            print('instruction to long')
            exit(1)
        if len(tup) == 1:
            tup.append("0")

        ins, data = tup

        if data.startswith('0x'):
            data = int(data, 16)
        elif data.startswith('0b'):
            data = int(data, 2)
        else:
            data = int(data)

        if not hasattr(INS, ins):
            print(f"instruction {ins} not found.")
            exit(1)
        ins = getattr(INS, ins)
        if type(ins) is not int:
            print(f"instruction {ins} not found.")
            exit(1)

        lines.append([ins, data])

with open(output, 'wb') as file:
    for ins, data in lines:
        ins = ins.to_bytes(1, byteorder='little')
        data = data.to_bytes(1, byteorder='little')

        file.write(ins)
        file.write(data)

print('Compile finished.')
