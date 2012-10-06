;;; Environment variables

(setq path-extras '("~/.bin" "/usr/local/bin" "/usr/texbin" "/usr/local/share/python")
      exec-path (nconc path-extras exec-path))

(setenv "PATH" (concat (mapconcat 'identity path-extras ":")
                       ":"
                       (getenv "PATH")))
