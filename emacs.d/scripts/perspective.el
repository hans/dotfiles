(require 'cl-macs)

(require 'perspective)
(persp-mode 1)

(defvar persp-path-match-alist '()
  "List of associations between perspective names and path-matching information.
When a file or directory is opened and its path matches with a value in this
alist, the perspective for the corresponding key will be initialized.

Each value in the alist is a list, the first value of which is a string used to
match paths and the second value of which is a lambda which is run when files
which match the path are first opened.

There is no need to include a call to open the perspective in said lambda: this
is done automatically.

This alist may be modified manually, but is probably best left alone: use
defpersp instead, which adds to this alist.")

(defun persp-path-match (path)
    (cl-loop for (persp-name . path-match)
           in persp-path-match-alist
           when (string-match-p (car path-match) path)

           ;; Fetch the perspective by name
           do (progn
                (persp-switch persp-name)
                (let ((persp (gethash persp-name perspectives-hash))
                      (on-match (cadr path-match)))
                  ;; Run an on-match hook if it is set
                  (if on-match
                      (funcall on-match))

                  ;; Add the buffer to the fetched perspective's buffer list
                  (push (current-buffer) (persp-buffers persp))))))

(add-hook 'find-file-hook
          (lambda () (persp-path-match (buffer-file-name))))
(add-hook 'dired-after-readin-hook
          (lambda () (persp-path-match (dired-current-directory))))

(defmacro* defpersp (name path-match key
                          &optional &key on-persp-init on-path-match)
  "Define a perspective with a name NAME. Set up a keybinding to load the
perspective manually by pressing `C-x p KEY`. Run ON-PERSP-INIT when the
perspective loads and ON-PATH-MATCH whenever a file is opened which matches
PATH_MATCH."
  (let* ((name-str (symbol-name name))
         (funsym (intern (concat "persp/" name-str)))
         (key (concat "C-x p " key)))
    ;; Define perspective trigger key
    `(progn
       ,(if (stringp path-match)
            `(add-to-list 'persp-path-match-alist
                          '(,name-str . (,path-match
                                         (lambda ()
                                           ,@on-path-match)))))

       (define-key persp-mode-map (kbd ,key) ',funsym)

       (defun ,funsym ()
         (interactive)

         ,(if on-persp-init
              `(unless (gethash ,name-str perspectives-hash)
                 ;; Perspective has not been activated in this session. Run the
                 ;; provided init code.
                 ,@on-persp-init))

         (persp-switch ,name-str)))))

;; Define main perspective
(defpersp main nil "m")
