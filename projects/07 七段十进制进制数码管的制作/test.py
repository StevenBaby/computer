import os

dirname = os.path.dirname(os.path.abspath(__file__))

with open(os.path.join(dirname, 'test.bin'), 'wb') as file:
    for var in range(256):
        var = str(var)
        var = int(var, base=16)
        byte = var.to_bytes(2, byteorder='little')
        file.write(byte)
