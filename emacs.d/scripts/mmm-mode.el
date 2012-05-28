(add-to-list 'load-path "~/.emacs.d/vendor/mmm-mode")

(load "mmm-mode")
(require 'mmm-mode)

(setq mmm-global-mode 'maybe)
(mmm-add-mode-ext-class 'html-mode "\\.php\\'" 'html-php)
