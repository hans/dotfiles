;; So hardcore.

(vendor 'hardcore-mode)
(require 'hardcore-mode)
(global-hardcore-mode)

;; Bind C-h to backspace
(define-key key-translation-map [?\C-h] [?\C-?])
(global-set-key (kbd "<f1>") 'help-command)
