
(define (script-fu-deal-with-it img drawable frameCount sunglassesWidth sunglassesPositionX sunglassesPositionY sunglassesPath)

  (let* (
     (next-frame 0)
     (frameSplit (/ frameCount 2))
     (tempSunglassesLayer)
     (tempFaceLayer (car (gimp-layer-copy drawable TRUE)))
     (sunglassesFile (car (file-png-load 1 sunglassesPath sunglassesPath)))
     (sunglassesHeight (* (/ (car (gimp-image-height sunglassesFile)) (car (gimp-image-width sunglassesFile))) sunglassesWidth))
     (sunglassesLayer (car (gimp-file-load-layer 1 img sunglassesPath)))
     (sunglassesPosStep (/ (+ (/ sunglassesHeight 2) sunglassesPositionY) (- frameSplit 1)))
     (sunglassesDestPosX (- sunglassesPositionX (/ sunglassesWidth 2)))
     (sunglassesDestPosY (- 0 sunglassesHeight))
     )

       (set! tempSunglassesLayer (car (gimp-layer-copy sunglassesLayer TRUE)))
       (gimp-image-add-layer img tempSunglassesLayer -1)
       (gimp-layer-scale tempSunglassesLayer sunglassesWidth sunglassesHeight FALSE)
       (gimp-layer-translate tempSunglassesLayer sunglassesDestPosX sunglassesDestPosY)
       (gimp-image-merge-down img tempSunglassesLayer 0)

     (while (< next-frame (- frameSplit 1))

       (gimp-image-add-layer img (car (gimp-layer-copy tempFaceLayer TRUE)) -1)
     
       (set! sunglassesDestPosY (+ sunglassesDestPosY sunglassesPosStep))

       (set! tempSunglassesLayer (car (gimp-layer-copy sunglassesLayer TRUE)))
       (gimp-image-add-layer img tempSunglassesLayer -1)
       (gimp-layer-scale tempSunglassesLayer sunglassesWidth sunglassesHeight FALSE)
       (gimp-layer-translate tempSunglassesLayer sunglassesDestPosX sunglassesDestPosY)
       (gimp-image-merge-down img tempSunglassesLayer 0)

       (set! next-frame (+ next-frame 1))
     )

     (set! next-frame 0)

     (while (< next-frame frameSplit)
       (gimp-image-add-layer img (car (gimp-layer-copy tempFaceLayer TRUE)) -1)
       (set! tempSunglassesLayer (car (gimp-layer-copy sunglassesLayer TRUE)))
       (gimp-image-add-layer img tempSunglassesLayer -1)
       (gimp-layer-scale tempSunglassesLayer sunglassesWidth sunglassesHeight FALSE)
       (gimp-layer-translate tempSunglassesLayer sunglassesDestPosX sunglassesDestPosY)
       (gimp-image-merge-down img tempSunglassesLayer 0)

       (set! next-frame (+ next-frame 1))
     )

     (gimp-image-crop img (car (gimp-image-width img)) (car (gimp-image-height img)) 0 0)
     (gimp-displays-flush)

   ))

(script-fu-register "script-fu-deal-with-it"
            _"Deal with it"
            "Easily deal with it"
            "rabross"
            "rabross"
            "November 2020"
            ""
            SF-IMAGE       "Image"    0
            SF-DRAWABLE    "Drawable" 0
            SF-VALUE       "Frames" "20"
            SF-VALUE       "Desired Sunglasses Width" "256"
            SF-VALUE       "Desired Sunglasses Finish Position X" "100"
            SF-VALUE       "Desired Sunglasses Finish Position Y" "100"
            SF-FILENAME    "Sunglasses Image" "sunglasses.png"
            )
(script-fu-menu-register "script-fu-deal-with-it"
                         "<Toolbox>/Xtns/Languages/Script-Fu/Animation")