;; ibuffer customization

(setq ibuffer-saved-filter-groups
      '(("default"
         ("dev" (or (mode . php-mode)
                    (mode . html-mode)
                    (mode . css-mode)
                    (mode . js-mode)
                    (mode . coffee-mode)
                    (mode . ruby-mode)
                    (mode . clojure-mode)
                    (mode . lisp-mode)))
         ("git" (name . "\*magit"))
         ("org" (mode . org-mode))
         ("erc" (mode . erc-mode))
         ("dotfiles" (filename . "Projects\/dotfiles")))))

(add-hook 'ibuffer-mode-hook
          (lambda ()
            (ibuffer-auto-mode 1)
            (ibuffer-switch-to-saved-filter-groups "default")))

;; Don't clutter the ibuffer list with empty filter groups!
(setq ibuffer-show-empty-filter-groups nil)

;; Yup.
(setq ibuffer-expert t)
