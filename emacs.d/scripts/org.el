(require 'org)
(require 'org-latex)
(load-library "reftex")

(add-hook 'org-mode-hook
	  (lambda ()
	    (turn-on-auto-fill)

	    ;; Disable electric-indent-mode in Org buffers
	    (set (make-local-variable 'electric-indent-functions)
           (list (lambda (arg) 'no-indent)))

	    ;; (add-to-list 'org-export-latex-packages-alist '("" "minted"))

      (add-to-list 'org-latex-classes
                   '("ieee"
                     "\\usepackage{IEEEconf,IEEEtran} \\documentclass[12pt,journal]{IEEEtran}"
                     ("\\section{%s}" . "\\section*{%s}")
                     ("\\subsection{%s}" . "\\subsection*{%s}")
                     ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                     ("\\paragraph{%s}" . "\\paragraph*{%s}")
                     ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

	    (org-mode-reftex-setup)

      ;; Pretend that latex environments are just paragraphs while
      ;; filling
      (defadvice org-element-type (after org-element-type-latex-fix
                                         'disable)
        (when (eq 'latex-environment ad-return-value)
          (setq ad-return-value 'paragraph)))
      (defadvice org-fill-paragraph (around org-fill-paragraph-with-latex)
        (ad-enable-advice 'org-element-type 'after
                          'org-element-type-latex-fix)
        ad-do-it
        (ad-disable-advice 'org-element-type 'after
                           'org-element-type-latex-fix))))


(setq org-directory "~/org/"
      org-default-notes-file (concat org-directory "notes.org")
      org-M-RET-may-split-line nil
      org-todo-keywords '((sequence "TODO" "IN PROGRESS" "DONE"))
      org-src-fontify-natively t

      ;; Org manual 11.7.1
      org-pretty-entities t
      org-entities-user
        '(("implies" "\\implies" t "&rArr;" "=>" "=>" "⇒"))

      org-export-latex-listings 'minted
      org-export-latex-minted-options '(("frame" "lines") ("fontsize" "\\footnotesize")
                                        ("linenos" ""))

      ;; LaTeX previews
      org-format-latex-options
        (plist-put org-format-latex-options :background "White")

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
    (js . t)
    (dot . t)))

;; Minted requires that LaTeX always receive a `--shell-escape' option.
;; We need to hack this into the dvipng fragment export. Let's override
;; `create-...-with-dvipng'.
(defun org-create-formula-image-with-dvipng (string tofile options buffer)
  "This calls dvipng."
  (require 'org-latex)
  (let* ((tmpdir (if (featurep 'xemacs)
		     (temp-directory)
		   temporary-file-directory))
	 (texfilebase (make-temp-name
		       (expand-file-name "orgtex" tmpdir)))
	 (texfile (concat texfilebase ".tex"))
	 (dvifile (concat texfilebase ".dvi"))
	 (pngfile (concat texfilebase ".png"))
	 (fnh (if (featurep 'xemacs)
                  (font-height (face-font 'default))
                (face-attribute 'default :height nil)))
	 (scale (or (plist-get options (if buffer :scale :html-scale)) 1.0))
	 (dpi (number-to-string (* scale (floor (* 0.9 (if buffer fnh 140.))))))
	 (fg (or (plist-get options (if buffer :foreground :html-foreground))
		 "Black"))
	 (bg (or (plist-get options (if buffer :background :html-background))
		 "Transparent")))
    (if (eq fg 'default) (setq fg (org-dvipng-color :foreground)))
    (if (eq bg 'default) (setq bg (org-dvipng-color :background)))
    (with-temp-file texfile
      (insert (org-splice-latex-header
	       org-format-latex-header
	       ;; org-export-latex-default-packages-alist
	       ;; org-export-latex-packages-alist t
	       org-format-latex-header-extra))
      (insert "\n\\begin{document}\n" string "\n\\end{document}\n")
      (require 'org-latex)
      (org-export-latex-fix-inputenc))
    (let ((dir default-directory))
      (condition-case nil
	  (progn
	    (cd tmpdir)

      ;; CHANGED: Add `--shell-escape' option
	    (call-process "latex" nil nil nil "--shell-escape" texfile))
	(error nil))
      (cd dir))
    (if (not (file-exists-p dvifile))
	(progn (message "Failed to create dvi file from %s" texfile) nil)
      (condition-case nil
	  (if (featurep 'xemacs)
	      (call-process "dvipng" nil nil nil
			    "-fg" fg "-bg" bg
			    "-T" "tight"
			    "-o" pngfile
			    dvifile)
	    (call-process "dvipng" nil nil nil
			  "-fg" fg "-bg" bg
			  "-D" dpi
			  ;;"-x" scale "-y" scale
			  "-T" "tight"
			  "-o" pngfile
			  dvifile))
	(error nil))
      (if (not (file-exists-p pngfile))
	  (if org-format-latex-signal-error
	      (error "Failed to create png file from %s" texfile)
	    (message "Failed to create png file from %s" texfile)
	    nil)
	;; Use the requested file name and clean up
	(copy-file pngfile tofile 'replace)
	(loop for e in '(".dvi" ".tex" ".aux" ".log" ".png" ".out") do
	      (if (file-exists-p (concat texfilebase e))
		  (delete-file (concat texfilebase e))))
	pngfile))))
