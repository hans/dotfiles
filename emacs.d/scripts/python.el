;; ipython
(setq py-python-command "ipython") ; bug?
(require 'ipython)

;; Use python-mode instead of built-in python package
(require 'python-mode)
(setq python-indent-offset 4)

;; ipython is really helpful and reloads the built-in python.el for us.
;; Kill it with fire.
(if (featurep 'python)
    (unload-feature 'python)) ;; DIE!!!!!!!!
(autoload 'python-mode "python-mode" "Python Mode." t)

;; This is ridiculous.. :P
(defun ipy-shell ()
  (interactive)
  (let ((py-shell-name "ipython")
        (py-python-command-args '("-i" "--colors=LightBG")))
    (py-shell)))
