;; Mark repeated code, like variable names, very quickly.
;; See http://www.youtube.com/watch?v=r2o9HYi7DOY

(load "multiple-cursors/multiple-cursors")

;; Nice hotkeys

(load "multiple-cursors/mc-mark-more")

(global-set-key (kbd "C-<") 'mark-previous-like-this)
(global-set-key (kbd "C->") 'mark-next-like-this)

;; SGML (and descendants) tag renaming

(require 'sgml-mode)

(eval-after-load 'sgml-mode-map
  (define-key sgml-mode-map (kbd "C-c C-r") 'mc/mark-sgml-tag-pair))
