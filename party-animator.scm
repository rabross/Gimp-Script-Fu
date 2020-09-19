(define (script-fu-party-animator img drawable)

  (let* (
     (frameCount 10)
     (hue 0)
     (counter 0)
     (new-layer drawable)
     )

    (while (< counter (- frameCount 1))
       (set! new-layer (car (gimp-layer-copy drawable TRUE)))
       (gimp-image-add-layer img new-layer -1)
       (gimp-drawable-colorize-hsl new-layer hue 100 0)
       (set! counter (+ counter 1))
       (set! hue (* counter (/ 360 frameCount)))
       )

    (gimp-drawable-colorize-hsl drawable hue 70 0)
    (gimp-displays-flush)))

(script-fu-register "script-fu-party-animator"
            _"Party Animator ..."
            "Easily puts party in your picture"
            "rabross"
            "rabross"
            "September 2020"
            ""
            SF-IMAGE       "Image"    0
            SF-DRAWABLE    "Drawable" 0
            )
(script-fu-menu-register "script-fu-party-animator"
                         "<Toolbox>/Xtns/Languages/Script-Fu/Animation")