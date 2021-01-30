# coding=utf-8

import os
import re

import pin
import assembly as ASM

dirname = os.path.dirname(__file__)

inputfile = os.path.join(dirname, 'program.asm')
outputfile = os.path.join(dirname, 'program.bin')

annotation = re.compile(r"(.*?);.*")

codes = []
marks = {}

OP2 = {
    'MOV': ASM.MOV,
    'ADD': ASM.ADD,
    'SUB': ASM.SUB,
    'CMP': ASM.CMP,
    'AND': ASM.AND,
    'OR': ASM.OR,
    'XOR': ASM.XOR,
}

OP1 = {
    'INC': ASM.INC,
    'DEC': ASM.DEC,
    'NOT': ASM.NOT,
    'JMP': ASM.JMP,
    'JO': ASM.JO,
    'JNO': ASM.JNO,
    'JZ': ASM.JZ,
    'JNZ': ASM.JNZ,
    'JP': ASM.JP,
    'JNP': ASM.JNP,
    'PUSH': ASM.PUSH,
    'POP': ASM.POP,
    'CALL': ASM.CALL,
    'INT': ASM.INT,
}

OP0 = {
    'NOP': ASM.NOP,
    'RET': ASM.RET,
    'IRET': ASM.IRET,
    'STI': ASM.STI,
    'CLI': ASM.CLI,
    'HLT': ASM.HLT,
}

OP2SET = set(OP2.values())
OP1SET = set(OP1.values())
OP0SET = set(OP0.values())

REGISTERS = {
    "A": pin.A,
    "B": pin.B,
    "C": pin.C,
    "D": pin.D,
    "SS": pin.SS,
    "SP": pin.SP,
    "CS": pin.CS,
}


class Code(object):

    TYPE_CODE = 1
    TYPE_LABEL = 2

    def __init__(self, number, source: str):
        self.numer = number
        self.source = source.upper()
        self.op = None
        self.dst = None
        self.src = None
        self.type = self.TYPE_CODE
        self.index = 0
        self.prepare_source()

    def get_op(self):
        if self.op in OP2:
            return OP2[self.op]
        if self.op in OP1:
            return OP1[self.op]
        if self.op in OP0:
            return OP0[self.op]
        raise SyntaxError(self)

    def get_am(self, addr):
        global marks
        if not addr:
            return None, None
        if addr in marks:
            return pin.AM_INS, marks[addr].index * 3
        if addr in REGISTERS:
            return pin.AM_REG, REGISTERS[addr]
        if re.match(r'^[0-9]+$', addr):
            return pin.AM_INS, int(addr)
        if re.match(r'^0X[0-9A-F]+$', addr):
            return pin.AM_INS, int(addr, 16)
        match = re.match(r'^\[([0-9]+)\]$', addr)
        if match:
            return pin.AM_DIR, int(match.group(1))
        match = re.match(r'^\[(0X[0-9A-F]+)\]$', addr)
        if match:
            return pin.AM_DIR, int(match.group(1), 16)
        match = re.match(r'^\[(.+)\]$', addr)
        if match and match.group(1) in REGISTERS:
            return pin.AM_RAM, REGISTERS[match.group(1)]
        raise SyntaxError(self)

    def prepare_source(self):
        if self.source.endswith(':'):
            self.type = self.TYPE_LABEL
            self.name = self.source.strip(':')
            return

        tup = self.source.split(',')
        if len(tup) > 2:
            raise SyntaxError(self)
        if len(tup) == 2:
            self.src = tup[1].strip()

        tup = re.split(r" +", tup[0])
        if len(tup) > 2:
            raise SyntaxError(self)
        if len(tup) == 2:
            self.dst = tup[1].strip()

        self.op = tup[0].strip()

    def compile_code(self):
        op = self.get_op()

        amd, dst = self.get_am(self.dst)
        ams, src = self.get_am(self.src)

        if src is not None and (amd, ams) not in ASM.INSTRUCTIONS[2][op]:
            raise SyntaxError(self)
        if src is None and dst and amd not in ASM.INSTRUCTIONS[1][op]:
            raise SyntaxError(self)
        if src is None and dst is None and op not in ASM.INSTRUCTIONS[0]:
            raise SyntaxError(self)

        amd = amd or 0
        ams = ams or 0
        dst = dst or 0
        src = src or 0

        if op in OP2SET:
            ir = op | (amd << 2) | ams
        elif op in OP1SET:
            ir = op | amd
        else:
            ir = op

        return [ir, dst, src]

    def __repr__(self):
        return f'[{self.numer}] - {self.source}'


class SyntaxError(Exception):

    def __init__(self, code: Code, *args, **kwargs):
        super().__init__(*args, **kwargs)
        self.code = code


def compile_program():
    global codes
    global marks

    with open(inputfile, encoding='utf8') as file:
        lines = file.readlines()

    for index, line in enumerate(lines):
        source = line.strip()
        if ';' in source:
            match = annotation.match(source)
            source = match.group(1)
        if not source:
            continue
        code = Code(index + 1, source)
        codes.append(code)

    code = Code(index + 2, 'HLT')
    codes.append(code)

    result = []

    current = None
    for var in range(len(codes) - 1, -1, -1):
        code = codes[var]
        if code.type == Code.TYPE_CODE:
            current = code
            result.insert(0, code)
            continue
        if code.type == Code.TYPE_LABEL:
            marks[code.name] = current
            continue
        raise SyntaxError(code)

    for index, var in enumerate(result):
        var.index = index

    with open(outputfile, 'wb') as file:
        for code in result:
            values = code.compile_code()
            for value in values:
                result = value.to_bytes(1, byteorder='little')
                file.write(result)


def main():
    try:
        compile_program()
    except SyntaxError as e:
        print(f'Syntax error at {e.code}')
        return

    print('compile program.asm finished!!!')


if __name__ == '__main__':
    main()
