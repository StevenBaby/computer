
import os

import micro as M

dirname = os.path.dirname(__file__)
filename = os.path.join(dirname, "../computer/instruction.ins")

PAS = 0x00  # empty instruction
HLT = 0xFF  # halt instruction

LAI = 0x01
LAR = 0x02
LBI = 0x03
LBR = 0x04
LCI = 0x05
LCR = 0x06
LGI = 0x07
LGR = 0x08
LOI = 0x09
LOR = 0x0A

MAB = 0x10
MAC = 0x11
MAG = 0x12
MAO = 0x13

MBA = 0x14
MBC = 0x15
MBG = 0x16
MBO = 0x17

MCA = 0x18
MCB = 0x19
MCG = 0x1a
MCO = 0x1b

MGA = 0x1c
MGB = 0x1d
MGC = 0x1e
MGO = 0x1f

STA = 0x20
STB = 0X21
STC = 0x22
STG = 0x23
STO = 0x24

ADD = 0x30
SUB = 0x31

JMP = 0x40
JPZ = 0x41
JPC = 0x42


BASIC_INS = {
    HLT: [
        M.HT,
    ],
    PAS: [],
}

LOAD_INS = {
    LAI: [
        M.DO | M.AI,
    ],
    LAR: [
        M.DO | M.MI,
        M.RO | M.AI,
    ],

    LBI: [
        M.DO | M.BI,
    ],
    LBR: [
        M.DO | M.MI,
        M.RO | M.BI,
    ],

    LCI: [
        M.DO | M.CI,
    ],
    LCR: [
        M.DO | M.MI,
        M.RO | M.CI,
    ],

    LGI: [
        M.DO | M.GI,
    ],
    LGR: [
        M.DO | M.MI,
        M.RO | M.GI,
    ],

    LOI: [
        M.DO | M.OI,
    ],
    LOR: [
        M.DO | M.MI,
        M.RO | M.OI,
    ],
}

MOVE_INS = {
    MAB: [
        M.AO | M.BI,
    ],
    MAC: [
        M.AO | M.CI,
    ],
    MAG: [
        M.AO | M.GI,
    ],
    MAO: [
        M.AO | M.OI,
    ],
    MBA: [
        M.BO | M.AI,
    ],
    MBC: [
        M.BO | M.CI,
    ],
    MBG: [
        M.BO | M.GI,
    ],
    MBO: [
        M.BO | M.OI,
    ],
    MCA: [
        M.CO | M.AI,
    ],
    MCB: [
        M.CO | M.BI,
    ],
    MCG: [
        M.CO | M.GI,
    ],
    MCO: [
        M.CO | M.OI,
    ],
    MGA: [
        M.GO | M.AI,
    ],
    MGB: [
        M.GO | M.BI,
    ],
    MGC: [
        M.GO | M.CI,
    ],
    MGO: [
        M.GO | M.OI,
    ],
}

STORE_INS = {
    STA: [
        M.DO | M.MI,
        M.AO | M.RI,
    ],
    STB: [
        M.DO | M.MI,
        M.BO | M.RI,
    ],
    STC: [
        M.DO | M.MI,
        M.CO | M.RI,
    ],
    STG: [
        M.DO | M.MI,
        M.GO | M.RI,
    ],
    STO: [
        M.DO | M.MI,
        M.OO | M.RI,
    ],
}

ALU_INS = {
    ADD: [
        M.LO | M.CI | M.FG
    ],
    SUB: [
        M.LO | M.CI | M.FG | M.SU
    ],
}

JUMP_INS = {
    JMP: [
        M.DO | M.PJ,
    ],
}

INSTRUCTIONS = {}
INSTRUCTIONS.update(BASIC_INS)
INSTRUCTIONS.update(LOAD_INS)
INSTRUCTIONS.update(MOVE_INS)
INSTRUCTIONS.update(STORE_INS)
INSTRUCTIONS.update(ALU_INS)
INSTRUCTIONS.update(JUMP_INS)


def main():
    with open(filename, 'wb') as file:
        zero = 0
        for instruction in range(0x100):
            if instruction not in INSTRUCTIONS:
                steps = M.FETCH + M.NEXT
            elif instruction == HLT:
                steps = M.FETCH + INSTRUCTIONS[instruction]
            else:
                steps = M.FETCH + INSTRUCTIONS[instruction] + M.NEXT

            for var in range(256):

                step = var % 64
                ZF = var & 0b01000000
                CF = var & 0b10000000

                if (CF and instruction == JPC) or (ZF and instruction == JPZ):
                    steps = M.FETCH + INSTRUCTIONS[JMP] + M.NEXT

                if len(steps) <= step:
                    value = zero.to_bytes(4, byteorder='little')
                    file.write(value)
                    continue
                value = steps[step].to_bytes(4, byteorder='little')
                file.write(value)

    print('Compile finished.')


if __name__ == '__main__':
    main()
