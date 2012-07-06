;;; Javascript is fun

(setq-default
 ;; Don't rebind C-a / C-e for me, thanks
 js2-rebind-eol-bol-keys nil
 js2-basic-offset 2
 js2-allow-rhino-new-expr-initializer nil

 ;; Extra global variables
 js2-global-externs '("setTimeout" "clearTimeout" "setInterval"
                      "clearInterval" "location" "console" "_"
                      "jQuery" "$"))

(load "js2-mode/js2-mode")
(load "js2-mode/js2-imenu-extras")
(require 'js2-mode)
(require 'js2-imenu-extras)

(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
