
(define (script-fu-deal-with-it img drawable frame-count sunglassesWidth sunglassesPositionX sunglassesPositionY sunglassesPath)

  (let* (
     (next-frame 0)
     (temp)
     (sunglassesFile (car (file-png-load 1 sunglassesPath sunglassesPath)))
     (sunglassesHeight (* (/ (car (gimp-image-height sunglassesFile)) (car (gimp-image-width sunglassesFile))) sunglassesWidth))
     (sunglassesLayer (car (gimp-file-load-layer 1 img sunglassesPath)))
     )

        ;;; add glasses
        ;;; end position
       (set! temp (car (gimp-layer-copy sunglassesLayer TRUE)))
       (gimp-image-add-layer img temp -1)
       (gimp-layer-scale temp sunglassesWidth sunglassesHeight FALSE)
       (gimp-layer-translate temp (- sunglassesPositionX (/ sunglassesWidth 2)) (- sunglassesPositionY (/ sunglassesHeight 2)))

    (while (< next-frame (- frame-count 1))

        ;;;add face
       (gimp-image-add-layer img (car (gimp-layer-copy drawable TRUE)) -1)
     
        ;;;add glasses
       (set! temp (car (gimp-layer-copy sunglassesLayer TRUE)))
       (gimp-image-add-layer img temp -1)
       (gimp-layer-scale temp sunglassesWidth sunglassesHeight FALSE)

       (set! next-frame (+ next-frame 1))
    )

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
            SF-VALUE "Frames" "2"
            SF-VALUE "sunglassesWidth" "256"
            SF-VALUE "sunglassesPositionX" "100"
            SF-VALUE "sunglassesPositionY" "100"
            SF-FILENAME "Sunglasses" "sunglasses.png"
            )
(script-fu-menu-register "script-fu-deal-with-it"
                         "<Toolbox>/Xtns/Languages/Script-Fu/Animation")