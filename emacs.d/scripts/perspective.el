(require 'cl-macs)

(require 'perspective)
(persp-mode 1)

(defvar persp-path-match-alist '()
  "List of associations between perspective names and path-matching strings.
When a file or directory is opened and its path matches with a value in this
alist, the perspective for the corresponding key will be initialized.

This alist may be modified manually, but is probably best left alone: use
defpersp instead, which adds to this alist.")

(defun persp-path-match (path)
  (cl-loop for (persp-name . path-match)
           in persp-path-match-alist
           when (string-match-p path-match path)

           ;; Fetch the perspective by name
           do (let ((persp (gethash persp-name perspectives-hash)))
                ;; Add the buffer to the fetched perspective's buffer list
                (push (current-buffer) (persp-buffers persp)))))

(add-hook 'find-file-hook
          (lambda () (persp-path-match (buffer-file-name))))
(add-hook 'dired-after-readin-hook
          (lambda () (persp-path-match (dired-current-directory))))

(defmacro defpersp (name path-match key
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
                          '(,name-str . ,path-match)))

       (define-key persp-mode-map (kbd ,key) ',funsym)

       (defun ,funsym ()
         (interactive)
         (persp-switch ,name-str)

         ,(if on-persp-init
              `(unless (gethash ,name-str perspectives-hash)
                ;; Perspective has not been activated in this session. Run the
                ;; provided init code.
                ,@on-persp-init))))))

(defpersp irc nil "i"
  (erc))
