import cv2
from cvzone.HandTrackingModule import HandDetector
import numpy as np
import math
import time

cap = cv2.VideoCapture(0)
detector = HandDetector(maxHands=2)  # Update maxHands to 2 for detecting two hands
offset = 20
imgSize = 300
folder = "Data5/VERY GOOD"
counter = 0

while True:
    success, img = cap.read()
    hands, img = detector.findHands(img)

    if hands:
        if len(hands) == 1:
            # Only one hand detected, use its information for processing
            hand = hands[0]
            x, y, w, h = hand['bbox']
            imgWhite = np.ones((imgSize, imgSize, 3), np.uint8) * 255
            imgCrop = img[y - offset:y + h + offset, x - offset:x + w + offset]

            # Resize and place the cropped image in the center of imgWhite (similar to your original logic)
            imgResize = cv2.resize(imgCrop, (imgSize, imgSize))
            imgWhite[:imgSize, :] = imgResize

            cv2.imshow("ImageCrop", imgCrop)
            cv2.imshow("ImageWhite", imgWhite)

        elif len(hands) == 2:
            # Combine bounding boxes of both hands to create a single bounding box
            bbox1 = hands[0]['bbox']
            bbox2 = hands[1]['bbox']

            x_min = min(bbox1[0], bbox2[0])
            y_min = min(bbox1[1], bbox2[1])
            x_max = max(bbox1[0] + bbox1[2], bbox2[0] + bbox2[2])
            y_max = max(bbox1[1] + bbox1[3], bbox2[1] + bbox2[3])

            # Ensure the combined bounding box is within the image boundaries
            x_min = max(0, x_min - offset)
            y_min = max(0, y_min - offset)
            x_max = min(img.shape[1], x_max + offset)
            y_max = min(img.shape[0], y_max + offset)

            imgWhite = np.ones((imgSize, imgSize, 3), np.uint8) * 255
            imgCrop = img[y_min:y_max, x_min:x_max]

            # Resize and place the cropped image in the center of imgWhite (similar to your original logic)
            imgResize = cv2.resize(imgCrop, (imgSize, imgSize))
            imgWhite[:imgSize, :] = imgResize

            cv2.imshow("ImageCrop", imgCrop)
            cv2.imshow("ImageWhite", imgWhite)

    cv2.imshow("Image", img)

    key = cv2.waitKey(1)
    if key == ord("s"):
        counter += 1
        cv2.imwrite(f'{folder}/Image_{time.time()}.jpg', imgWhite)
        print(counter)

    elif key == 27:  # Press 'Esc' key to exit the loop
        break

cap.release()
cv2.destroyAllWindows()
