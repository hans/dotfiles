(add-to-list 'load-path "~/.emacs.d/vendor")

(setq custom-file "~/.emacs.d/scripts/custom.el")
(load custom-file 'noerror)

(load "packages")
(load "scripts/defuns")

;; Load all necessary packages first, then load all customization scripts in the
;; directory at ./scripts

(load "packages")
(load-dir "~/.emacs.d/scripts")
