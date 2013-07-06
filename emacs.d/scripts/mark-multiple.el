;; mark-multiple -- Mark repeated code, like variable names, very
;; quickly.

;;; Commentary:
;; See http://www.youtube.com/watch?v=r2o9HYi7DOY

;;; Code:

(require 'multiple-cursors)
(require 'mc-mark-more)

;; Nice hotkeys
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)

;; SGML (and descendants) tag renaming
(require 'sgml-mode)
(eval-after-load 'sgml-mode-map
  (define-key sgml-mode-map (kbd "C-c C-r") 'mc/mark-sgml-tag-pair))

(provide 'mark-multiple)
;; mark-multiple.el ends here
