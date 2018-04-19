import numpy as np
import struct
import cv2
import os


def compress(uncompressed):
    """Compress the image."""
    
    dict_size = 256
    dictionary = {str(i): i for i in range(dict_size)}

    it = np.nditer(uncompressed)

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

    return compressed

def encode(compressed_list,filename):
    """Write list of strings to file in bytes."""

    encoded = struct.pack(">{}I".format(len(compressed_list)), *compressed_list)

    file = open(filename, 'wb')
    file.write(len(compressed_list).to_bytes(3,'big'))
    file.write(encoded)
    file.close()


def decode(filename):
    """Read bytes from file and convert to list of strings."""
    file = open(filename, 'rb')
    encoded = file.read()

    sz = int.from_bytes(encoded[0:3],'big')

    decoded = struct.unpack(">{}I".format(sz), encoded[3:])
    return list(decoded)


def decompress(compressed):
    """Decompress a list"""

    N = compressed.pop()
    M = compressed.pop()


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
        decompressed.append(list(entry))

        p.append(entry[0])
        dictionary[dict_size] = p
        dict_size += 1

        p = list(entry)

    flat_decompressed = flat(decompressed)

    decompressed = np.reshape(np.array(flat_decompressed, dtype=np.uint8), (M,N))

    return decompressed

def flat(alist):
    new_list = []
    for item in alist:
        if isinstance(item, (list, tuple)):
            new_list.extend(flat(item))
        else:
            new_list.append(item)
    return new_list

# MAIN STARTS
# ---------------------------------------

# arr = np.array([[39, 39, 126, 126],
#                 [39, 39, 126, 126],
#                 [39, 39, 126, 126],
#                 [39, 39, 126, 126]])

# compressed = compress(arr)
# print(compressed)
# print()

# encode(compressed, 'test.pku')
# decoded = decode('test.pku')

# print(decompress(decoded))

# print("\nStart compressing image...\n")
# # Start compressing image
# img = cv2.imread("images/1.bmp",0)
# print("Shape: " + str(img.shape))
# print("Original image size: %.2f MB" % (os.path.getsize("images/1.bmp")/1024/1024))
# # cv2.imshow("Original image",img)
# # cv2.waitKey()

# compressed_img = compress(img)
# encode(compressed_img,'1.pku')
# print("Compressed image size: %.2f MB" % (os.path.getsize("1.pku")/1024/1024))

# decoded = decode('1.pku')
# decompressed_img = decompress(decoded)

# print()
# print("Start decompressing the image...")
# print()

# print(type(decompressed_img[0,0]))
# print(len(decompressed_img))
# print(decompressed_img.dtype)
# decompressed_img.astype(np.uint8)
# print(decompressed_img.dtype)

# cv2.imshow("Decompressed image",decompressed_img)
# cv2.waitKey()

















