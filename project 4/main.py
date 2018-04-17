import cv2
import numpy as np
import numpy.matlib
import time


# global variables
global color_center

def color_slice(img, color_rad):
    print("Wait a while...")
    start = time.time()
    m,n,c = img.shape
    img2 = img.astype(float)

    for i in range(m):
        for j in range(n):
            if (np.sqrt( sum( (img2[i][j] - color_center)**2 ) ) ) > color_rad:
                img2[i][j] = np.mean(img2[i][j])

    end = time.time()
    print("Done!")
    print("Time: %f" % (end-start))
    return img2.astype(np.uint8)

def color_slice_optimized(img, color_rad, first=False): # computed for the first time
    img2 = img.astype(float)

    m,n,c = img.shape
    global sphere
    sphere = np.array(img2)

    color = np.zeros([m,n,c],np.float)
    color[:,:,0] = color_center[0]
    color[:,:,1] = color_center[1]
    color[:,:,2] = color_center[2]

    sqr_diff = (img2 - color)**2
    sphere[:,:,0] = np.sqrt(np.sum(sqr_diff,axis=2))
    sphere[:,:,1] = np.sqrt(np.sum(sqr_diff,axis=2))
    sphere[:,:,2] = np.sqrt(np.sum(sqr_diff,axis=2))

    mask = sphere > color_rad
    mean_mat = np.mean(img2,axis=2)
    means = np.array(img2)
    means[:,:,0] = mean_mat
    means[:,:,1] = mean_mat
    means[:,:,2] = mean_mat
    img2[mask] = means[mask]

    return img2.astype(np.uint8)

def cyanize_magentize(img):
    m,n,c = img.shape
    cmyk = cv2.cvtColor(img, cv2.COLOR_BGR2YCR_CB)
    img_translation = np.array(cmyk)
    img_translation[:,:,0] = np.roll(cmyk[:,:,0],10,axis=1)
    img_translation[:,:,1] = np.roll(cmyk[:,:,1],-10,axis=1)
    img_translation[:,:,2] = np.roll(cmyk[:,:,2],10,axis=1)

    newImg = img_translation
    return newImg

def show_color(event,x,y,flags,param):
    if (event == cv2.EVENT_LBUTTONDOWN):
        b = param[y][x][0]
        g = param[y][x][1]
        r = param[y][x][2]
        print("B = %d G = %d R = %d" % (b, g, r))

        # start slicing that color
        global color_center
        color_center = [b,g,r]
    
def show_webcam():
    isFirst = True
    cam = cv2.VideoCapture(0)
    cam.set(cv2.CAP_PROP_FRAME_HEIGHT, 480)
    cam.set(cv2.CAP_PROP_FRAME_WIDTH, 640)
    while True:
        ret_val, img = cam.read()
        radius = cv2.getTrackbarPos(trackbar, track_win)
        isSurprise = cv2.getTrackbarPos(suprise_trackbar, track_win)
        if isFirst:
            newImg = color_slice_optimized(img,100,first=True)
            isFirst = False
        else:
            if not isSurprise:
                newImg = color_slice_optimized(img,radius)
            else:
                newImg = cyanize_magentize(img)
        cv2.imshow('Camera', newImg)
        cv2.setMouseCallback('Camera', show_color, img)
        if cv2.waitKey(1) == 27: 
            break  # esc to quit
    cv2.destroyAllWindows()

if __name__ == "__main__":
    img = cv2.imread('parrot.jpg')
    img = cv2.resize(img, (0,0), fx=0.5, fy=0.5)

    # create window for showing image
    window = 'Parrot'
    cv2.namedWindow(window)
    # create window for showing trackbar
    track_win = 'Trackbar window'
    cv2.namedWindow(track_win, cv2.WINDOW_NORMAL)
    cv2.resizeWindow(track_win,500,30)

    # create track bar
    trackbar = 'Sphere radius'
    cv2.createTrackbar(trackbar, track_win, 100, 440, color_slice_optimized)
    suprise_trackbar = 'Surprise: ON/OFF'
    cv2.createTrackbar(suprise_trackbar, track_win, 0, 1, color_slice_optimized)

    # default trackbar
    prev_rad = cv2.getTrackbarPos(trackbar, track_win)
    color_center = [0,0,255]
    newImg = color_slice_optimized(img,prev_rad,first=True)
    cv2.imshow(window, newImg)
    cv2.setMouseCallback(window, show_color, img)

    while(1):
        try:
            color_rad = cv2.getTrackbarPos(trackbar, track_win)
            isSurprise = cv2.getTrackbarPos(suprise_trackbar, track_win)
            if not isSurprise:
                if (color_rad != prev_rad):
                    newImg = color_slice_optimized(img, color_rad)
                    cv2.imshow(window, newImg)
                    cv2.setMouseCallback(window, show_color, img)
                    prev_rad = color_rad
            else:
                newImg = cyanize_magentize(img)
                cv2.imshow(window, newImg)
                cv2.setMouseCallback(window, show_color, img)
            k = cv2.waitKey(1) & 0xFF
        # handle that f*cking error message
        except TypeError:
            print("halo")

        if (k == 27):
            cv2.destroyWindow(window)
            break

    show_webcam()

    cv2.destroyAllWindows()