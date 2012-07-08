(load "powerline/powerline")
(require 'powerline)

(set-face-attribute 'mode-line nil
                    :background "grey18"
                    :box nil)

(defpowerline perspective
  (propertize
   (if persp-curr
       (concat "("
               (substring (persp-name persp-curr) 0 1)
               ")")
     "")
   'face (powerline-make-face color1)))

(setq-default
 mode-line-format
 (list "%e"
       '(:eval (concat
                (powerline-rmw            'left   nil  )
                (powerline-buffer-id      'left   nil  powerline-color1  )
                (powerline-perspective    'left powerline-color1)
                (powerline-major-mode     'left        powerline-color1  )
                (powerline-minor-modes    'left        powerline-color1  )
                (powerline-narrow         'left        powerline-color1  powerline-color2  )
                (powerline-vc             'center                        powerline-color2  )
                (powerline-make-fill                                     powerline-color2  )
                (powerline-row            'right       powerline-color1  powerline-color2  )
                (powerline-make-text      ":"          powerline-color1  )
                (powerline-column         'right       powerline-color1  )
                (powerline-percent        'right  nil  powerline-color1  )
                (powerline-make-text      "  "    nil  )))))
