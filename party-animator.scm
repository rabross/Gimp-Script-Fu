
(define (script-fu-party-animator img drawable frameCount)

  (define (angle frame frameCount)
    (let (
      (radian 6.28319))
      (* frame (/ radian frameCount))
    ))

  (define (offsetX angle offset)
      (* (cos angle) offset))

  (define (offsetY angle offset)
      (* (sin angle) offset))

  (let* (
     (hue 0)
     (counter 0)
     (nextAngle 0)
     (new-layer drawable)
     (offset 10)
     )

    (while (< counter (- frameCount 1))
       (set! new-layer (car (gimp-layer-copy drawable TRUE)))
       (gimp-image-add-layer img new-layer -1)
       (gimp-drawable-colorize-hsl new-layer hue 100 0)
       (set! counter (+ counter 1))
       (set! hue (* counter (/ 360 frameCount)))
       (set! nextAngle (angle counter (+ frameCount 1)))
       (gimp-item-transform-translate new-layer (offsetX nextAngle offset) (offsetY nextAngle offset))
       )

       (set! nextAngle (angle counter frameCount))
    (gimp-drawable-colorize-hsl drawable hue 70 0)
    (gimp-item-transform-translate drawable (offsetX nextAngle offset) (offsetY nextAngle offset))
    (gimp-displays-flush)
    ))

(script-fu-register "script-fu-party-animator"
            _"Party Animator ..."
            "Easily puts party in your picture"
            "rabross"
            "rabross"
            "September 2020"
            ""
            SF-IMAGE       "Image"    0
            SF-DRAWABLE    "Drawable" 0
            SF-VALUE       "Frames" "12"
            )
(script-fu-menu-register "script-fu-party-animator"
                         "<Toolbox>/Xtns/Languages/Script-Fu/Animation")