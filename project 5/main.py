import numpy as np
import struct
import cv2
import os


def compress(uncompressed):
    """Compress the image."""
    
    dict_size = 256
    dictionary = {str(i): i for i in range(dict_size)}

    it = np.nditer(uncompressed)
    print("Last ten elements: " + str(uncompressed.flatten()[-20:]))

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

    # append M, N sizes of image to compressed
    compressed.append(M)
    compressed.append(N)

    # print("Dictionary:")
    # for key,value in dictionary.items():
    #     print("%s: %d" % (key,value))

    # print(len(dictionary))

    return compressed

def encode(compressed_list,filename):
    """Write list of strings to file in bytes."""

    encoded = struct.pack(">{}L".format(len(compressed_list)), *compressed_list)

    file = open(filename, 'wb')
    file.write(len(compressed_list).to_bytes(3,'big'))
    file.write(encoded)
    file.close()


def decode(filename):
    """Read bytes from file and convert to list of strings."""
    file = open(filename, 'rb')
    encoded = file.read()

    sz = int.from_bytes(encoded[0:3],'big')
    # print(sz)

    decoded = struct.unpack(">{}L".format(sz), encoded[3:])
    return list(decoded)


def decompress(compressed):
    """Decompress a list"""

    dict_size = 256
    dictionary = {i: [i] for i in range(dict_size)}

    decompressed = []
    p = [compressed.pop(0)] # p == w
    decompressed.append(list(p)) # decompressed == result

    for k in compressed:
        if k in dictionary:
            entry = dictionary[k]
        elif k == dict_size:
            p2 = list(p)
            p2.append([p[0]])
            entry = p2
        else:
            raise ValueError('Bad compressed k: %s' % k)
        # print("Entry: "+ str(entry))
        decompressed.append(list(entry))
        # print("Decompressed: " + str(decompressed))

        p.append(entry[0])
        dictionary[dict_size] = p
        dict_size += 1

        p = list(entry)
        # print("p: " + str(p))
        # print()
    # print()

    flat_decompressed = []
    for inner_list in decompressed:
        for each in inner_list:
            flat_decompressed.append(each)

    print("Last ten elements: " + str(flat_decompressed[-20:]))

    M = flat_decompressed.pop()
    N = flat_decompressed.pop()
    print(len(flat_decompressed))
    # print(M,N)

    decompressed = np.reshape(flat_decompressed, (M,N))
    # print(type(decompressed))

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

print("\nStart compressing image...\n")
# Start compressing image
img = cv2.imread("images/1.bmp",0)
print("Shape: " + str(img.shape))
print("Original image size: %.2f MB" % (os.path.getsize("images/1.bmp")/1024/1024))
# cv2.imshow("Original image",img)
# cv2.waitKey()

compressed_img = compress(img)
encode(compressed_img,'1.pku')
print("Compressed image size: %.2f MB" % (os.path.getsize("1.pku")/1024/1024))

decoded = decode('1.pku')
decompressed_img = decompress(decoded)

print(type(decompressed_img))
print(len(decompressed_img))

# cv2.imshow("Decompressed image",decompressed_img)
# cv2.waitKey()

















