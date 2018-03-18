import cv2
import numpy as np 


def color_slice(img, color_rad):
    print("Wait a while...")
    m,n,c = img.shape
    color_center = [0,0,255]
    img2 = img.astype(float)

    for i in range(m):
        for j in range(n):
            if (np.sqrt( sum( (img2[i][j] - color_center)**2 ) ) ) > color_rad:
                img2[i][j] = np.mean(img2[i][j])

    print("Done!")
    return img2.astype(np.uint8)

def show_color(event,x,y,flags,param):
    if (event == cv2.EVENT_LBUTTONDOWN):
        b = param[y][x][0]
        g = param[y][x][1]
        r = param[y][x][2]
        print("B = %d G = %d R = %d" % (b, g, r))
        print()

        # SHOW COLOR IN SEPARATE WINDOW
        checker = np.ones((200,200,3),np.uint8)
        checker[:] = [b,g,r]
        cv2.imshow("Checker", checker)
    

if __name__ == "__main__":
    img = cv2.imread('parrot.jpg')

    window = 'Parrot'
    cv2.namedWindow(window)

    # create track bar
    trackbar = 'Sphere radius'
    cv2.createTrackbar(trackbar, window, 100,300, color_slice)

    # default trackbar
    prev_rad = cv2.getTrackbarPos(trackbar, window)
    newImg = color_slice(img,prev_rad)
    resized_newImg = cv2.resize(newImg, (0,0), fx=0.5, fy=0.5)
    cv2.imshow(window, resized_newImg)
    cv2.setMouseCallback(window, show_color, resized_newImg)

    while(1):
        color_rad = cv2.getTrackbarPos(trackbar, window)
        if (color_rad != prev_rad):
            # debugging hardware bug
            try:
                newImg = color_slice(img, color_rad)
            except Exception:
                print("halo")

            # show image
            resized_newImg = cv2.resize(newImg, (0,0), fx=0.5, fy=0.5)
            cv2.imshow(window, resized_newImg)
            cv2.setMouseCallback(window, show_color, resized_newImg)

            prev_rad = color_rad
        k = cv2.waitKey(1) & 0xFF
        if (k == ord('q')):
            break

cv2.destroyAllWindows()