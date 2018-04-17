import numpy as np
import struct


def compress(uncompressed):
    """Compress the image."""
    
    dict_size = 256
    dictionary = {str(i): i for i in range(dict_size)}

    iterator = np.nditer(uncompressed)
    p = str(next(iterator))
    compressed = []
    M,N = uncompressed.shape # MxN - size of the image

    for c in iterator:
        c = str(c)
        pc = p + "-" + c
        if pc in dictionary:
            p = pc
        else:
            compressed.append(dictionary[p])
            dictionary[pc] = dict_size
            dict_size += 1
            p = c
    if p:
        compressed.append(dictionary[p])

    # print("Dictionary:")
    # for key,value in dictionary.items():
    #     print("%s: %d" % (key,value))

    return compressed

def encode(compressed_list,filename):
    """Write list of strings to file in bytes."""

    encoded = struct.pack(">{}H".format(len(compressed_list)), *compressed_list)

    file = open(filename, 'wb')
    file.write(len(compressed_list).to_bytes(2,'big'))
    file.write(encoded)
    file.close()


def decode(filename):
    """Read bytes from file and convert to list of strings."""
    file = open(filename, 'rb')
    encoded = file.read()

    sz = int.from_bytes(encoded[0:2],'big')
    # print(sz)

    decoded = struct.unpack(">{}H".format(sz), encoded[2:])
    return list(decoded)


def decompress(compressed):
    """Decompress a list"""

    dict_size = 256
    dictionary = {i: str(i) for i in range(dict_size)}

    decompressed = []
    p = [compressed.pop(0)]
    decompressed.append(p)

    for k in compressed:
        if k in dictionary:
            entry = dictionary[k]
        elif k == dict_size:
            entry = list(p)
            entry.append(p)
        else:
            raise ValueError('Bad compressed k: %s' % k)
        decompressed.append(entry)

        p.append(int(entry))
        dictionary[dict_size] = p
        dict_size += 1

        p = int(entry)
    print()

    return decompressed


arr = np.array([[39, 39, 126, 126],
                [39, 39, 126, 126],
                [39, 39, 126, 126],
                [39, 39, 126, 126]])

compressed = compress(arr)
print(compressed)
print()

encode(compressed, 'test.pku')
decoded = decode('test.pku')

print(decompress(decoded))

