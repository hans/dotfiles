(require 'perspective)
(persp-mode 1)

(defmacro defpersp (name path-match key &rest body)
  "Define a perspective with a name NAME which loads when a file that matches
PATH-MATCH is opened. Set up a keybinding to load the perspective manually by
pressing `C-x p KEY`. Run BODY when the perspective loads."
  (let ((funsym (intern (concat "persp/" (symbol-name name))))
        (key (concat "C-x p " key)))
    ;; Define perspective trigger key
    `(progn
       (define-key persp-mode-map (kbd ,key) ',funsym)

       (defun ,funsym ()
         (persp-switch ,(symbol-name name))
         ,@body))))
