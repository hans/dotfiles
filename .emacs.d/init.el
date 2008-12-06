; Syntax highlighting
(require 'font-lock)

; TextMate Minor Mode
(add-to-list 'load-path "~/.emacs.d/vendor/textmate.el")
(load-file "~/.emacs.d/vendor/textmate.el")
(textmate-mode)

; Insert tabs only
(global-set-key (kbd "TAB") 'self-insert-command)
(setq-default indent-tabs-mode t)

; Color theme
(require 'color-theme)
(color-theme-initialize)
(color-theme-gray30)

; YASnippet
(load-file "~/.emacs.d/vendor/yasnippet.el")
(yas/initialize)
(yas/load-directory "~/.emacs.d/snippets/")

; magit
(load-file "~/.emacs.d/vendor/magit.elc")