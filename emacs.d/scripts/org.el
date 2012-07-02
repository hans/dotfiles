(add-hook 'org-mode-hook 'turn-on-auto-fill)

(setq org-directory "~/org/"
      org-default-notes-file (concat org-directory "notes.org")
      org-M-RET-may-split-line nil
      org-todo-keywords '((sequence "TODO" "IN PROGRESS" "DONE")))

(define-key global-map (kbd "C-c c") 'org-capture)
