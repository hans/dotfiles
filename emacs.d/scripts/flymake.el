;;; Flymake

(require 'flymake)

(add-hook 'php-mode-hook (lambda () (flymake-mode 1)))
