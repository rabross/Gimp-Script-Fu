
(define (script-fu-party-animator img drawable frame-count offset)

  (define (angle frame frame-count)
    (let (
      (radian 6.28319))
      (* frame (/ radian frame-count))
    ))

  (define (offsetX angle offset)
      (* (cos angle) offset))

  (define (offsetY angle offset)
      (* (sin angle) offset))

  (let* (
     (next-hue 0)
     (next-frame 0)
     (next-angle 0)
     (new-layer drawable)
     (cur-width  (car (gimp-image-width img)))
     (cur-height (car (gimp-image-height img)))
     )

    (while (< next-frame (- frame-count 1))
       (set! new-layer (car (gimp-layer-copy drawable TRUE)))
       (set! next-frame (+ next-frame 1))
       (set! next-hue (* next-frame (/ 360 frame-count)))
       (set! next-angle (angle next-frame frame-count))
       (gimp-image-add-layer img new-layer -1)
       (gimp-drawable-colorize-hsl new-layer next-hue 100 0)
       (gimp-item-transform-translate new-layer (offsetX next-angle offset) (offsetY next-angle offset))
       )

    (gimp-drawable-colorize-hsl drawable 0 100 0)
    (gimp-item-transform-translate drawable (offsetX 0 offset) (offsetY 0 offset))
    
    (gimp-image-crop img cur-width cur-height 0 0)
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
            SF-ADJUSTMENT  "Offset"  '(10 1 1000 1 10 0 0)
            )
(script-fu-menu-register "script-fu-party-animator"
                         "<Toolbox>/Xtns/Languages/Script-Fu/Animation")