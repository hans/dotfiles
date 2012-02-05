;; Mark repeated code, like variable names, very quickly.
;; See http://www.youtube.com/watch?v=r2o9HYi7DOY

(load "mark-multiple/mark-multiple")

;; Nice hotkeys

(load "mark-multiple/mark-more-like-this")
(require 'mark-more-like-this)
(global-set-key (kbd "C-<") 'mark-previous-like-this)
(global-set-key (kbd "C->") 'mark-next-like-this)

;; SGML (and descendants) tag renaming

(require 'sgml-mode)
(load "mark-multiple/rename-sgml-tag")
(require 'rename-sgml-tag)

(eval-after-load 'sgml-mode-map
  (define-key sgml-mode-map (kbd "C-c C-r") 'rename-sgml-tag))
