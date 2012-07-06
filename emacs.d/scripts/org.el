(add-hook 'org-mode-hook
          (lambda ()
            (turn-on-auto-fill)

            ;; Disable electric-indent-mode in Org buffers
            (set (make-local-variable 'electric-indent-functions)
                 (list (lambda (arg) 'no-indent)))))

(setq org-directory "~/org/"
      org-default-notes-file (concat org-directory "notes.org")
      org-M-RET-may-split-line nil
      org-todo-keywords '((sequence "TODO" "IN PROGRESS" "DONE"))
      org-src-fontify-natively t)

(define-key global-map (kbd "C-c c") 'org-capture)
