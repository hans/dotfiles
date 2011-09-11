(add-to-list 'load-path "~/.emacs.d/vendor")

(setq custom-file "~/.emacs.d/scripts/custom.el")
(load custom-file 'noerror)

(load "scripts/env")
(load "scripts/global")
(load "scripts/defuns")
(load "scripts/bindings")
(load "scripts/package")
(load "scripts/tabs")
(load "scripts/disabled")
(load "scripts/fonts")
(load "scripts/utf-8")
(load "scripts/scratch")
;(load "scripts/grep")	    ;; Disabled for now. ack > grep
(load "scripts/diff")
(load "scripts/ido")
(load "scripts/dired")
(load "scripts/recentf")
(load "scripts/rectangle")
(load "scripts/flymake")
(load "scripts/javascript")
(load "scripts/mac")
(load "scripts/erc")

(vendor 'color-theme)
(vendor 'filladapt)
(vendor 'full-ack      'ack 'ack-same 'ack-find-same-file 'ack-find-file 'ack-interactive)
(vendor 'magit         'magit-status)
(vendor 'markdown-mode 'markdown-mode)
(vendor 'csv-mode      'csv-mode)
(vendor 'yaml-mode     'yaml-mode)
(vendor 'coffee-mode)
(vendor 'php-mode)
(vendor 'haskell-mode  'haskell-mode)
(vendor 'mustache-mode)
(vendor 'scala-mode)
(vendor 'clojure-mode)
(vendor 'slime)
(vendor 'haml-mode)

(vendor 'yasnippet)
(vendor 'mode-line-bell)
(vendor 'notify)

(load "scripts/lisp")
