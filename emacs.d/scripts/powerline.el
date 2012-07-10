(load "powerline/powerline")
(require 'powerline)
(require 'cl-macs)

(defvar mode-abbr-alist
  '(("Clojure" . "clj")
    ("Emacs-Lisp" . "el")
    ("JavaScript-IDE" . "js")
    ("Lisp Interaction" . "lisp")
    ("Magit" . "git")
    ("Markdown" . "md")
    ("Paredit" . "par")
    ("RE Builder" . "re")
    ("Shell-script" . "sh")))

(defun abbreviate-mode-list-str (mode-list-str)
  (cl-loop for (orig . replace)
           in mode-abbr-alist
           do (setq mode-list-str
                    (replace-regexp-in-string orig replace mode-list-str t)))
  mode-list-str)

(set-face-attribute 'mode-line nil
                    :background "grey18"
                    :box nil)

(defpowerline major-mode-abbr
  (propertize (abbreviate-mode-list-str (format-mode-line mode-name))))

(defpowerline minor-modes-abbr
  (propertize (replace-regexp-in-string
               "^ *" ""
               (abbreviate-mode-list-str (format-mode-line minor-mode-alist)))))

(defpowerline perspective
  (propertize
   (if persp-curr
       (concat "("
               (substring (persp-name persp-curr) 0 2)
               ")")
     "")
   'face (powerline-make-face color1)))

(setq-default
 mode-line-format
 (list "%e"
       '(:eval (concat
                (powerline-rmw            'left   nil  )
                (powerline-buffer-id      'left   nil  powerline-color1  )
                (powerline-perspective    'left powerline-color1)
                (powerline-major-mode-abbr 'left        powerline-color1  )
                (powerline-minor-modes-abbr 'left        powerline-color1  )
                (powerline-narrow         'left        powerline-color1  powerline-color2  )
                (powerline-vc             'center                        powerline-color2  )
                (powerline-make-fill                                     powerline-color2  )
                (powerline-row            'right       powerline-color1  powerline-color2  )
                (powerline-make-text      ":"          powerline-color1  )
                (powerline-column         'right       powerline-color1  )
                (powerline-percent        'right  nil  powerline-color1  )
                (powerline-make-text      "  "    nil  )))))
