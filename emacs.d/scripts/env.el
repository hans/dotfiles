;;; Environment variables

(setq exec-path (cons "~/.bin" (cons "/usr/local/bin" exec-path)))
(setenv "PATH" (concat "~/.bin:/usr/local/bin:" (getenv "PATH")))
