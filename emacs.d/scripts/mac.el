;;; Cocoa!

;; Hide the tool bar
(when (fboundp 'tool-bar-mode)
  (tool-bar-mode 0))

;; Slow down the mouse wheel acceleration
(when (boundp 'mouse-wheel-scroll-amount)
  (setq mouse-wheel-scroll-amount '(0.01)))

;; Copy and paste to Mac clipboard when copying / yanking
;; http://www.lingotrek.com/2010/12/integrate-emacs-with-mac-os-x-clipboard.html
(defun mac-copy ()
  (shell-command-to-string "pbpaste"))
(defun mac-paste (text &optional push)
  (let ((process-connection-type nil))
    (let ((proc (start-process "pbcopy" "*Messages*" "pbcopy")))
      (process-send-string proc text)
      (process-send-eof proc))))

(setq interprogram-cut-function 'mac-paste)
(setq interprogram-paste-function 'mac-copy)

;; Cocoa Emacs: M-RET to toggle fullscreen
(when (fboundp 'ns-toggle-fullscreen)
  (global-set-key (kbd "M-RET") 'ns-toggle-fullscreen))

;; Prevent anti aliasing
;; (setq mac-allow-anti-aliasing nil)

;; Mac-style key-binding mode.  Aquamacs-like
;; (mac-key-mode)

;; Full screen mode
;; (mac-hide-menu-bar)
;; (mac-show-menu-bar)
