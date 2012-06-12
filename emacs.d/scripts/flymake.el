;;; Flymake

(require 'flymake)

;;; Override the default Flymake tempfile generator.
;;; By default, Flymake creates temporary files in place - in the same
;;; directory as that of the actual file being tested. This makes using
;;; Flymake over Tramp difficult, if not impossible, because Flymake keeps
;;; reconnecting to the server to upload the test script and then run the
;;; binary.
;;;
;;; Let's create the temp file in a temp dir instead.
;;; Thanks http://blog.urth.org/2011/06/flymake-versus-the-catalyst-restarter.html

(defun flymake-create-temp-inplace (file-name prefix)
  (unless (stringp file-name)
    (error "Invalid file-name"))
  (or prefix
      (setq prefix "flymake"))
  (let* ((name (concat
                (file-name-nondirectory
                 (file-name-sans-extension file-name))
                "_" prefix))
         (ext (concat "." (file-name-extension file-name)))
         (temp-name (make-temp-file name nil ext)))
    (flymake-log 3 "create-temp-inplace: file=%s temp=%s" file-name temp-name)
    temp-name))

;;; Run the syntax-checking binary locally as well.
;;; (This code is exactly the same as Flymake core's, except for a change from
;;; the start-file-process function to start-process.)

(defun flymake-start-syntax-check-process (cmd args dir)
  "Start syntax check process."
  (let* ((process nil))
    (condition-case err
        (progn
          (when dir
            (let ((default-directory dir))
              (flymake-log 3 "starting process on dir %s" default-directory)))
          (setq process (apply 'start-process
                               "flymake-proc" (current-buffer) cmd args))
          (set-process-sentinel process 'flymake-process-sentinel)
          (set-process-filter process 'flymake-process-filter)
          (push process flymake-processes)

          (setq flymake-is-running t)
          (setq flymake-last-change-time nil)
          (setq flymake-check-start-time (flymake-float-time))

          (flymake-report-status nil "*")
          (flymake-log 2 "started process %d, command=%s, dir=%s"
                       (process-id process) (process-command process)
                       default-directory)
          process)
      (error
       (let* ((err-str (format "Failed to launch syntax check process '%s' with args %s: %s"
                               cmd args (error-message-string err)))
              (source-file-name buffer-file-name)
              (cleanup-f (flymake-get-cleanup-function source-file-name)))
         (flymake-log 0 err-str)
         (funcall cleanup-f)
         (flymake-report-fatal-status "PROCERR" err-str))))))

;;; PHP
(add-hook 'php-mode-hook (lambda () (flymake-mode 1)))

;;; Javascript (JSHint with Node.js)

(defun flymake-jshint-init ()
  (let* ((temp-file (flymake-init-create-temp-buffer-copy
                      'flymake-create-temp-inplace))
         (local-file (file-relative-name
                       temp-file
                       (file-name-directory buffer-file-name))))
    (list "/usr/local/bin/jshint" (list local-file))))

(provide 'flymake-jshint)
(require 'flymake-jshint)
(add-hook 'js-mode-hook (lambda () (flymake-mode 1)))

;;; CSS
;;; Uses the Python cssutils module. To install:
;;;
;;;     easy_install cssutils

(defun flymake-css-init ()
  (let* ((temp-file (flymake-init-create-temp-buffer-copy
                     'flymake-create-temp-inplace))
         (local-file (file-relative-name
                      temp-file
                      (file-name-directory buffer-file-name))))
    (list "cssparse" (list local-file))))

(add-hook 'css-mode-hook (lambda () (flymake-mode t)))

(setq flymake-allowed-file-name-masks
      (cons
       ;; JS
       '(".+\\.js$"
         flymake-jshint-init
         flymake-simple-cleanup
         flymake-get-real-file-name)

       ;; CSS
       (cons
        '("\\.css$" flymake-css-init)
        flymake-allowed-file-name-masks)))

(setq flymake-err-line-patterns
      (cons
       ;; JS
       '("^\\(.+\\): line \\([[:digit:]]+\\), col \\([[:digit:]]+\\), \\(.+\\)$" 1 2 3 4)

       ;; CSS
       (cons
        '("\\(.*\\) \\[\\([0-9]+\\):\\([0-9]+\\): \\(.*\\)\\]"
          nil 2 3 1)
        flymake-err-line-patterns)))

;; RFringe: Display number and location of flymake errors/warnings on the fringe
;; Load custom .el in .emacs.d/vendor
(load "rfringe")
(require 'rfringe)
