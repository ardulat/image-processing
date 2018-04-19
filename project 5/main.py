import cv2
import numpy as np
import os
import lzw


def robt310_maratkhan_compress(input_filename,output_filename):

    img = cv2.imread(input_filename,0)
    print("Original image size: %.2f MB" % (os.path.getsize(input_filename)/1024/1024))

    compressed_img = lzw.compress(img)
    lzw.encode(compressed_img,output_filename)
    print("Compressed image size: %.2f MB" % (os.path.getsize(output_filename)/1024/1024))

    return

def robt310_maratkhan_decompress(input_filename,output_filename):

    decoded = lzw.decode(input_filename)
    decompressed_img = lzw.decompress(decoded)

    cv2.imwrite(output_filename,decompressed_img)

    return

if __name__ == "__main__":

    for i in range(1, 17):
        input_filename = "images/%d.bmp" % i
        # create directory for compressed
        if not os.path.exists("compressed"):
            os.mkdir("compressed")
        output_filename = "compressed/%d.pku" % i
        robt310_maratkhan_compress(input_filename,output_filename)

        input_filename = "compressed/%d.pku" % i
        if not os.path.exists("decompressed"):
            os.mkdir("decompressed")        
        output_filename = "decompressed/%d_decompressed.bmp" % i
        robt310_maratkhan_decompress(input_filename,output_filename)