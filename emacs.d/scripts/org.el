(load-library "reftex")

(add-hook 'org-mode-hook
	  (lambda ()
	    (turn-on-auto-fill)

	    ;; Disable electric-indent-mode in Org buffers
	    (set (make-local-variable 'electric-indent-functions)
		 (list (lambda (arg) 'no-indent)))

	    (org-mode-reftex-setup)))

(setq org-directory "~/org/"
      org-default-notes-file (concat org-directory "notes.org")
      org-M-RET-may-split-line nil
      org-todo-keywords '((sequence "TODO" "IN PROGRESS" "DONE"))
      org-src-fontify-natively t

      ;; Org manual 11.7.1
      org-pretty-entities t
      org-entities-user
        '(("implies" "\\implies" t "&rArr;" "=>" "=>" "⇒"))

      org-export-latex-listings t
      org-export-latex-minted-options '(("frame" "lines") ("fontsize" "\\footnotesize")
                                        ("linenos" ""))

      org-babel-confirm-evaluate nil)

(define-key global-map (kbd "C-c c") 'org-capture)

(defun org-mode-reftex-setup ()
  (and (buffer-file-name)
       (file-exists-p (buffer-file-name))
       (reftex-parse-all))

  (define-key org-mode-map (kbd "C-c )") 'reftex-citation)

  (setq reftex-default-bibliography '("default.bib")))

;; org-babel

(org-babel-do-load-languages
 'org-babel-load-languages
 '( (clojure . t)
    (haskell . t)
    (python . t)
    (sh . t)
    (ruby . t)
    (js . t)))
