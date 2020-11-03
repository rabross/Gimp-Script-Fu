
(define (script-fu-party-animator-gifs img drawable)

  (let* (
     (layerList (vector->list(cadr(gimp-image-get-layers img))))
     (layerCount (length layerList))
     (stepHue (/ 360 layerCount))
     (nextHue 0)
     )

    (for-each
      (lambda (layerId)
        (gimp-drawable-colorize-hsl layerId nextHue 100 0)
        (set! nextHue (+ nextHue stepHue))
      ) layerList   
    )
    
    (gimp-displays-flush)
    ))

(script-fu-register "script-fu-party-animator-gifs"
            _"Party Animator for gifs..."
            "Easily puts party in your picture"
            "rabross"
            "rabross"
            "November 2020"
            ""
            SF-IMAGE       "Image"    0
            SF-DRAWABLE    "Drawable" 0
            )
(script-fu-menu-register "script-fu-party-animator-gifs"
                         "<Toolbox>/Xtns/Languages/Script-Fu/Animation")