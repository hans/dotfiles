;;; Javascript is fun

(load "js2-mode/js2-mode")
(require 'js2-mode)

(setq-default js2-allow-rhino-new-expr-initializer nil
              js2-global-externs '("setTimeout" "clearTimeout" "setInterval"
                                   "clearInterval" "location" "console" "_"
                                   "jQuery" "$"))
