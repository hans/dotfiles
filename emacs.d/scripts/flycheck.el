;;; flycheck --- on-the-fly syntax checking

;;; Commentary:

;;; Code:

(require 'flycheck)

(add-hook 'after-init-hook #'global-flycheck-mode)

(provide 'flycheck)
;;; flycheck.el ends here
