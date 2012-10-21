;;; ob-sml.el --- org-babel functions for SML evaluation

;; Copyright (C) 2012  Hans Engel

;; Author: Hans Engel
;; Keywords: literate programming, reproducible research
;; Homepage: http://orgmode.org
;; Version: 0.01

;;; License:

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Commentary:

;; This file is not intended to ever be loaded by org-babel, rather it
;; is a template for use in adding new language support to Org-babel.
;; Good first steps are to copy this file to a file named by the
;; language you are adding, and then use `query-replace' to replace
;; all strings of "template" in this file with the name of your new
;; language.

;; If you have questions as to any of the portions of the file defined
;; below please look to existing language support for guidance.

;; If you are planning on adding a language to org-babel we would ask
;; that if possible you fill out the FSF copyright assignment form
;; available at http://orgmode.org/request-assign-future.txt as this
;; will make it possible to include your language support in the core
;; of Org-mode, otherwise unassigned language support files can still
;; be included in the contrib/ directory of the Org-mode repository.

;;; Requirements:

;; Use this section to list the requirements of this language.  Most
;; languages will require that at least the language be installed on
;; the user's system, and the Emacs major mode relevant to the
;; language be installed as well.

;;; Code:
(require 'comint)

(require 'ob)
(require 'ob-comint)

;; Provides SML comint mode (`run-sml')
(require 'sml-proc)

;; optionally define a file extension for this language
(add-to-list 'org-babel-tangle-lang-exts '("sml" . "sml"))

;; optionally declare default header arguments for this language
(defvar org-babel-default-header-args:sml '())

;; Signals end of evaluation
(defvar org-babel-sml-eoe "\"org-babel-sml-eoe\"")
(defvar org-babel-sml-eoe-response (format "val it = %s : string"
                                           org-babel-sml-eoe))

;; ;; This function expands the body of a source code block by doing
;; ;; things like prepending argument definitions to the body, it should
;; ;; be called by the `org-babel-execute:sml' function below.
;; (defun org-babel-expand-body:sml (body params &optional processed-params)
;;   "Expand BODY according to PARAMS, return the expanded body."
;;   (require 'inf-sml)
;;   (let ((vars (nth 1 (or processed-params (org-babel-process-params params)))))
;;     (concat
;;      (mapconcat ;; define any variables
;;       (lambda (pair)
;;         (format "%s=%S"
;;                 (car pair) (org-babel-sml-var-to-sml (cdr pair))))
;;       vars "\n") "\n" body "\n")))

;; This is the main function which is called to evaluate a code
;; block.
;;
;; This function will evaluate the body of the source code and
;; return the results as emacs-lisp depending on the value of the
;; :results header argument
;; - output means that the output to STDOUT will be captured and
;;   returned
;; - value means that the value of the last statement in the
;;   source code block will be returned
;;
;; The most common first step in this function is the expansion of the
;; PARAMS argument using `org-babel-process-params'.
;;
;; Please feel free to not implement options which aren't appropriate
;; for your language (e.g. not all languages support interactive
;; "session" evaluation).  Also you are free to define any new header
;; arguments which you feel may be useful -- all header arguments
;; specified by the user will be available in the PARAMS variable.
(defun org-babel-execute:sml (body params)
  "Execute a block of Sml code with org-babel.  This function is
called by `org-babel-execute-src-block'"
  (message "executing Sml source code block")
  (let* ((use-session (cdr (assoc :session params)))
         (vars (mapcar #'cdr (org-babel-get-header params :var)))
         ;; either OUTPUT or VALUE which should behave as described above
         (result-type (cdr (assoc :result-type params)))
         ;; expand the body with `org-babel-expand-body:sml'
         (full-body (org-babel-expand-body:generic
                     body params (org-babel-variable-assignments:sml params)))
         (foo (print full-body))
         ;; set the session if the session variable is non-nil
         (session (org-babel-sml-initiate-session use-session params))

         (raw (org-babel-comint-with-output
                  (session org-babel-sml-eoe t full-body)
                (insert (org-babel-trim full-body))
                (comint-send-input nil t)

                ;; insert sentinel
                (insert (concat org-babel-sml-eoe "\;"))
                (comint-send-input nil t)))
         (poo (print raw))
         (results (cdr (member org-babel-sml-eoe-response
                               (reverse (mapcar #'org-babel-trim raw))))))
    (org-babel-reassemble-table
     (cond
      ((equal result-type 'output)
       (mapconcat #'identity (reverse (cdr results)) "\n"))
      ((equal result-type 'value)
       (org-babel-sml-table-or-string (car results))))
     (org-babel-pick-name (cdr (assoc :colname-names params))
                          (cdr (assoc :colname-names params)))
     (org-babel-pick-name (cdr (assoc :rowname-names params))
                          (cdr (assoc :rowname-names params))))))

(defun org-babel-sml-initiate-session (&optional session params)
  "Intiate an SML session.
If there is not a current inferior-process-buffer in SESSION
then create one. Return the initialized session."
  (or (get-buffer "*sml*")
     (save-window-excursion
       (run-sml "sml" "")
       (sleep-for 0.25)
       (current-buffer))))

(defun sml-load-filename (filename)
  "Load an ML file by string filename into the current inferior ML
process.

This command uses the ML command template `sml-use-command' to construct
the command to send to the ML process\; a trailing \"\;\\n\" will be added
automatically."
  (with-current-buffer (sml-proc-buffer)
    ;; Check if buffer needs saved. Should (save-some-buffers) instead?
    (comint-check-source filename)
    (setq sml-prev-dir/file
          (cons (file-name-directory filename)
                (file-name-nondirectory filename)))
    (sml-send-string (format sml-use-command filename) nil nil)))

(defun org-babel-load-session:sml (session body params)
  "Load BODY into SESSION."
  (save-window-excursion
    (let* ((buffer (org-babel-prep-session:sml session params))
           (load-file (concat (org-babel-temp-file "sml-load-") ".sml")))
      (with-temp-buffer
        (insert body) (write-file load-file)
        (print load-file)
        (sml-mode) (sml-load-filename load-file))
      buffer)))

;; This function should be used to assign any variables in params in
;; the context of the session environment.
(defun org-babel-prep-session:sml (session params)
  "Prepare SESSION according to the header arguments specified in PARAMS."
  (save-window-excursion
    (let ((buffer (org-babel-sml-initiate-session session)))
      (org-babel-comint-in-buffer buffer
        (mapc (lambda (line)
                (insert line)
                (comint-send-input nil t))
              (org-babel-variable-assignments:sml params)))
      (current-buffer))))

(defun org-babel-variable-assignments:sml (params)
  "Return list of SML statements assigning the block's variables."
  (mapcar (lambda (pair)
            (format "val %s = %s"
                    (car pair)
                    (org-babel-sml-var-to-sml (cdr pair))))
          (mapcar #'cdr (org-babel-get-header params :var))))

(defun org-babel-sml-var-to-sml (var)
  "Convert an elisp var into a string of sml source code
specifying a var of the same value."
  (if (listp var)
      (concat "[" (mapconcat #'org-babel-sml-var-to-sml var ", ") "]")
    (format "%S" var)))

(defun org-babel-sml-table-or-string (results)
  "If the results look like a table, then convert them into an
Emacs-lisp table, otherwise return the results as a string."
  (org-babel-script-escape results))

(provide 'ob-sml)
;;; ob-sml.el ends here
