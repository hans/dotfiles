(require 'coffee-mode)

(add-hook 'coffee-mode-hook
          (lambda ()
            ;; Tab width never gets set right ... grr
            (setq tab-width 2)

            ;; let coffee-mode handle indenting
            (electric-indent-mode -1)

            ;; Compile on save
            (when (file-exists-p (buffer-file-name))
               (coffee-cos-mode +1))))
