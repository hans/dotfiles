; Syntax highlighting
(require 'font-lock)
(global-font-lock-mode t)

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

; no toolbar
(custom-set-variables '(tool-bar-mode nil) '(inhibit-startup-screen t))

; auto-indent
(global-set-key [return] 'newline-and-indent)
(defun set-minibuffer-newline ()
  (local-set-key [return] 'minibuffer-complete-and-exit))
(add-hook 'minibuffer-setup-hook 'set-minibuffer-newline)
