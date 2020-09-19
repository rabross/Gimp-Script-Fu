(define (script-fu-party-animator img drawable frameCount)

  (let* (
     (hue 0)
     (counter 0)
     (new-layer drawable)
     (radian 6.28319)
     (offset 10)
     )

    (while (< counter (- frameCount 1))
       (set! new-layer (car (gimp-layer-copy drawable TRUE)))
       (gimp-image-add-layer img new-layer -1)
       (gimp-drawable-colorize-hsl new-layer hue 100 0)
       (set! counter (+ counter 1))
       (set! hue (* counter (/ 360 frameCount)))

       (gimp-item-transform-translate new-layer (* (cos (* counter (/ radian (+ frameCount 1)))) offset) (* (sin (* counter (/ radian (+ frameCount 1)))) offset))
       )

    (gimp-drawable-colorize-hsl drawable hue 70 0)
    (gimp-item-transform-translate drawable (* (cos (* counter (/ radian frameCount))) offset) (* (sin (* counter (/ radian frameCount))) offset))
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