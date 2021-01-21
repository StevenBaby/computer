import os

dirname = os.path.dirname(os.path.abspath(__file__))

with open(os.path.join(dirname, 'test.bin'), 'wb') as file:
    for var in range(256):
        value = f'{var}'
        value = int(value, base=16)
        file.write(value.to_bytes(2, byteorder='little'))
