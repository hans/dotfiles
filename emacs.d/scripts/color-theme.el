;;; Pretty colors

(color-theme-initialize)

(setq color-theme-is-global t)
(setq color-theme-is-cumulative t)

(vendor 'color-theme-railscasts)
(color-theme-railscasts)

;; (vendor 'color-theme-arjen)
;; (color-theme-arjen)

;; (color-theme-reset-faces)

;; Color-schemes that I thought were pleasing to the eye.  Most others are
;; pretty ugly.

;; Dark Backgrounds
;; (color-theme-dark-laptop)
;; (color-theme-clarity)
;; (color-theme-goldenrod)
;; (color-theme-billw)

;; Light Backgrounds
;; (color-theme-sitaramv-nt)
;; (color-theme-pierson)
;; (color-theme-rotor)
;; (color-theme-emacs-21)
;; (color-theme-gtk-ide)

(set-face-foreground 'region "white")
(set-face-background 'region "slategray")

(blink-cursor-mode)
(set-cursor-color "orange")
