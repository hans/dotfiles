(add-to-list 'load-path "~/.emacs.d/vendor/powerline")
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
                    :background "gray10"
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
   'face (powerline-make-face 'powerline-active1)))

;; Setup powerline theme
(setq-default mode-line-format
              '("%e"
                (:eval
                 (let* ((active (powerline-selected-window-active))
                        (mode-line (if active 'mode-line 'mode-line-inactive))
                        (face1 (if active 'powerline-active1
                                 'powerline-inactive1))
                        (face2 (if active 'powerline-active2
                                 'powerline-inactive2))
                        (separator-left
                         (intern (format "powerline-%s-%s"
                                         powerline-default-separator
                                         (car powerline-default-separator-dir))))
                        (separator-right
                         (intern (format "powerline-%s-%s"
                                         powerline-default-separator
                                         (cdr powerline-default-separator-dir))))
                        (lhs (list
                              (powerline-raw "%*" nil 'l)
                              (powerline-buffer-size nil 'l)

                              (powerline-raw mode-line-mule-info nil 'l)
                              (powerline-buffer-id nil 'l)

                              (when which-function-mode
                                (concat
                                 " ["
                                 (powerline-which-func 'which-func nil)
                                 "]"))


                              (powerline-raw " ")
                              (funcall separator-left mode-line face1)

                              (when (boundp 'erc-modified-channels-object)
                                (powerline-raw erc-modified-channels-object
                                               face1 'l))

                              (major-mode-abbr face1 'l)
                              (powerline-process face1)
                              (minor-modes-abbr face1 'l)
                              (powerline-narrow face1 'l)

                              (powerline-raw " " face1)
                              (funcall separator-left face1 face2)

                              (powerline-vc face2 'r)))
                        (rhs (list
                              (powerline-raw global-mode-string face2 'r)

                              (funcall separator-right face2 face1)

                              (powerline-raw "%4l" face1 'l)
                              (powerline-raw ":" face1 'l)
                              (powerline-raw "%3c" face1 'r)

                              (funcall separator-right face1 mode-line)
                              (powerline-raw " ")

                              (powerline-raw "%6p" nil 'r)

                              (powerline-hud face2 face1))))
                   ;;(message "%s %s" separator-left (funcall 'powerline-wave-left mode-line face1))
                   (concat
                    (powerline-render lhs)
                      (powerline-fill face2 (powerline-width rhs))
                      (powerline-render rhs))))))

;; ;; Flash the center of the powerline a certain color for a given amount of time
;; (defun* flash-powerline (color &optional (time 1))
;;   (let ((old-color powerline-color2)
;;         (color-var (make-local-variable 'powerline-color2)))
;;     (set color-var color)
;;     (sit-for time)
;;     (set color-var old-color)))
