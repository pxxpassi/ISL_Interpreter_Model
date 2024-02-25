import cv2
from cvzone.HandTrackingModule import HandDetector
from cvzone.ClassificationModule import Classifier
import numpy as np
import math
import time

cap = cv2.VideoCapture(0)
detector = HandDetector(maxHands=2, detectionCon=0.8)  # Adjust detection confidence here
classifier = Classifier("ModelB/keras_model.h5", "ModelB/labels.txt")
offset = 20
imgSize = 300
folder = "Data5/OK"
counter = 0
labels = ["A" , "B" , "C" , "D" , "E" , "F", "G", "H" ]
while True:
    success, img = cap.read()
    imgOutput = img.copy()
    hands, img = detector.findHands(img)

    if hands:
        if len(hands) == 1:
            hand = hands[0]
        elif len(hands) == 2:
            # Combine information from both hands
            hand1, hand2 = hands
            # Calculate the bounding box that fits both hands
            x_min = min(hand1['bbox'][0], hand2['bbox'][0])
            y_min = min(hand1['bbox'][1], hand2['bbox'][1])
            x_max = max(hand1['bbox'][0] + hand1['bbox'][2], hand2['bbox'][0] + hand2['bbox'][2])
            y_max = max(hand1['bbox'][1] + hand1['bbox'][3], hand2['bbox'][1] + hand2['bbox'][3])

            # Draw the bounding box
            cv2.rectangle(imgOutput, (x_min, y_min), (x_max, y_max), (255, 0, 255), 4)

            # Use the combined bounding box to crop and process the image
            imgWhite = np.ones((imgSize, imgSize, 3), np.uint8) * 255
            imgCrop = img[y_min - offset:y_max + offset, x_min - offset:x_max + offset]
            imgCropShape = imgCrop.shape

            # Resize and place the cropped image in the center of imgWhite
            imgResize = cv2.resize(imgCrop, (imgSize, imgSize))
            imgWhite[:imgSize, :] = imgResize

            prediction, index = classifier.getPrediction(imgWhite, draw=False)
            print(prediction, index)

            # Display the cropped and resized images
            cv2.putText(imgOutput, labels[index], (x_min + 10, y_min - 10),
                        cv2.FONT_HERSHEY_SIMPLEX, 1, (255, 255, 255), 2)

            cv2.imshow("ImageCrop", imgCrop)
            cv2.imshow("ImageWhite", imgWhite)

    cv2.imshow("Image", imgOutput)

    key = cv2.waitKey(1)
    if key == ord("s"):
        counter += 1
        cv2.imwrite(f'{folder}/Image_{time.time()}.jpg', imgWhite)
        print(counter)
    elif key == ord("q"):  # Press 'q' key to exit the loop
        break

cap.release()
cv2.destroyAllWindows()
