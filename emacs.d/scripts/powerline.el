(load "powerline/powerline")
(require 'powerline)
(require 'cl)

(defvar mode-abbr-alist
  '(("Abbrev" . "abbr")
    ("Clojure" . "clj")
    ("Emacs-Lisp" . "el")
    ("JavaScript-IDE" . "js")
    ("Lisp Interaction" . "lisp")
    ("Magit" . "git")
    ("Markdown" . "md")
    ("Paredit" . "par")
    ("Python" . "py")
    ("RE Builder" . "re")
    ("Shell-script" . "sh")))

(defun abbreviate-mode-list-str (mode-list-str)
  (loop for pair in mode-abbr-alist
        do (let ((orig (car pair))
                 (replace (cdr pair)))
             (setq mode-list-str
                   (replace-regexp-in-string orig replace mode-list-str t))))
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

;; Flash the center of the powerline a certain color for a given amount of time
(defun* flash-powerline (color &optional (time 1))
  (let ((old-color powerline-color2)
        (color-var (make-local-variable 'powerline-color2)))
    (set color-var color)
    (sit-for time)
    (set color-var old-color)))
