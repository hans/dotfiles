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

      org-export-latex-listings t
      org-export-latex-minted-options '(("frame" "lines") ("fontsize" "\\footnotesize")
                                        ("linenos" ""))

      org-babel-confirm-evaluate nil

      ;; Styled HTML export
      org-export-html-style "<style type=\"text/css\">
html, body { height: 100%; }
body { background-color: #fafafa; font: 19px 'Baskerville'; color: #222;
       line-height: 25px; }
h1, h2, h3, h4, h5, h6 { color: #333; margin: 15px 0 0 0; font-weight: normal; }
h1 { font-size: 36px; line-height: 46px; }
h2 { font-size: 30px; line-height: 48px; }
h3 { font-size: 24px; line-height: 32px; }
dt { margin: 6px 0; }
a { color: #840000; text-decoration: none; }
a:hover { color: #aa0000; }
pre, blockquote { border-left: 1px solid #ccc; margin: 0 0 20px 30px;
                  padding-left: 20px; overflow: auto; }
pre, tt, code { font-family: monospace; font-size: 17px; }
sup { font-size: 14px; line-height: 10px; }
#content { max-width: 650px; margin: 40px auto; padding-bottom: 20px;
           border-bottom: 1px solid #ccc; }
footer { margin: 100px auto; text-align: center; color: #666; font-size: 17px;
         width: 650px; }
footer a { color: #888; }
footer a:hover { color: #aaa; }
</style>"

      ;; Be sure to set `org-export-html-postamble-format' so that the below
      ;; setting is worth it!
      org-export-html-postamble t)

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
