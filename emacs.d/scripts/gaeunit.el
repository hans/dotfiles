(vendor 'gaeunit-mode)

(defun maybe-flash-powerline (&rest args)
  (if (fboundp 'flash-powerline)
      (funcall #'flash-powerline args)))

(add-hook 'gaeunit-tests-success-hook (lambda () (maybe-flash-powerline "green4")))
(add-hook 'gaeunit-tests-failure-hook (lambda () (maybe-flash-powerline "red")))
