;;; Cocoa!

(when (eq 'darwin system-type)

  ;; Hide the tool bar
  (when (fboundp 'tool-bar-mode)
    (tool-bar-mode 0))

  ;; Slow down the mouse wheel acceleration
  (when (boundp 'mouse-wheel-scroll-amount)
    (setq mouse-wheel-scroll-amount '(0.01)))

  ;; Don't open files from Finder, etc. in new frames
  (setq ns-pop-up-frames nil))

;; Prevent anti aliasing
;; (setq mac-allow-anti-aliasing nil)

;; Mac-style key-binding mode.  Aquamacs-like
;; (mac-key-mode)

;; Full screen mode
;; (mac-hide-menu-bar)
;; (mac-show-menu-bar)
