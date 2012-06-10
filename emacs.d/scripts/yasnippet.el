;;; Snippets make typing fun

(require 'dropdown-list)

(yas/initialize)

(yas/load-directory "~/.emacs.d/snippets")

(setq yas/prompt-functions '(yas/dropdown-prompt
                             yas/ido-prompt
                             yas/completing-prompt))

;; Replace yasnippets's TAB
(add-hook 'yas/minor-mode-hook
          (lambda () (define-key yas/minor-mode-map
                       (kbd "TAB") 'smart-tab))) ; was yas/expand
