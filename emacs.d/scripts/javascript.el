;;; Javascript is fun

(load "js2-mode/js2-mode")
(load "js2-mode/js2-imenu-extras")
(require 'js2-mode)
(require 'js2-imenu-extras)

(setq-default js2-allow-rhino-new-expr-initializer nil
              js2-global-externs '("setTimeout" "clearTimeout" "setInterval"
                                   "clearInterval" "location" "console" "_"
                                   "jQuery" "$"))

(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
