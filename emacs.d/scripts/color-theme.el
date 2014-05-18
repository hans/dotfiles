;;; Pretty colors

(defun get-tuple-from-plist (the-plist)
    (when the-plist
      (cons (car the-plist) (cadr the-plist))))

(defun plist-to-alist (the-plist)
  (let (alist '())
    (while the-plist
      (add-to-list 'alist (get-tuple-from-plist the-plist))
      (setq the-plist (cddr the-plist)))
    alist))

(require 'color-theme)

(setq color-theme-is-global t)
(setq color-theme-is-cumulative t)

(load-theme 'solarized-dark t)

;; (vendor 'color-theme-railscasts)
;; (color-theme-railscasts)

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
