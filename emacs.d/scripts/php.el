;; Use nxhtml-mode for php

(load-file "~/.emacs.d/vendor/nxhtml/autostart.el")
(add-to-list 'auto-mode-alist '("\\.php$" . nxhtml-mode))
