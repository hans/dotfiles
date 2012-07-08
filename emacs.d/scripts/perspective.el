(require 'perspective)
(persp-mode 1)

(defmacro defpersp (name path-match key &rest body)
  "Define a perspective with a name NAME which loads when a file that matches
PATH-MATCH is opened. Set up a keybinding to load the perspective manually by
pressing `C-x p KEY`. Run BODY when the perspective loads."
  (let* ((name-str (symbol-name name))
        (funsym (intern (concat "persp/" name-str)))
        (key (concat "C-x p " key)))
    ;; Define perspective trigger key
    `(progn
       (define-key persp-mode-map (kbd ,key) ',funsym)

       (defun ,funsym ()
         (interactive)
         (persp-switch ,name-str)
         (unless (gethash ,name-str perspectives-hash)
           ;; Perspective has not been activated in this session. Run the
           ;; provided init code.
           ,@body)))))

(defpersp irc nil "i"
  (erc))
