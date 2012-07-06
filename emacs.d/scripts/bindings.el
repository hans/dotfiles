;;; Global key bindings

;; --- File navigation --- ;;

;; Find stuff
(global-set-key [(f2)]              'ack-and-a-half)
(global-set-key [(control f2)]      'ack-and-a-half-same)
(global-set-key [(meta f2)]         'find-name-dired)

;; Refresh-like
(global-set-key [(f5)]         'revert-buffer)
(global-set-key [(control f5)] 'toggle-read-only)

;; Version control and change related
(global-set-key [(f9)] (lambda ()
                         (interactive)
                         (magit-status default-directory)))

;; --- Window manipulation --- ;;

(global-set-key [(control kp-6)] 'enlarge-window-horizontally)
(global-set-key [(control kp-4)] 'shrink-window-horizontally)
(global-set-key [(control kp-8)] 'enlarge-window)
(global-set-key [(control kp-2)] 'shrink-window)
(global-set-key (kbd "M-3") 'split-window-horizontally) ; was digit-argument
(global-set-key (kbd "M-2") 'split-window-vertically) ; was digit-argument
(global-set-key (kbd "M-1") 'delete-other-windows) ; was digit-argument
(global-set-key (kbd "M-0") 'delete-window) ; was digit-argument

;; --- Window navigation ---

;; Move cursor from window to window with Shift + arrow key.
(require 'windmove)
(windmove-default-keybindings 'shift)

;; Move to other window
(global-set-key (kbd "M-o") 'other-window) ; was facemenu-keymap
;; Replace dired's M-o
(add-hook 'dired-mode-hook (lambda () (define-key dired-mode-map (kbd "M-o") 'other-window))) ; was dired-omit-mode
;; Replace ibuffer's M-o
(add-hook 'ibuffer-mode-hook (lambda () (define-key ibuffer-mode-map (kbd "M-o") 'other-window))) ; was ibuffer-visit-buffer-1-window

;; --- Buffer manipulation --- ;;

;; Easier buffer killing
(global-set-key (kbd "M-k") 'kill-this-buffer)

;; --- Buffer navigation --- ;;

;; ibuffer > list-buffers
(global-set-key (kbd "C-x C-b") 'ibuffer)

;; Cycle through buffers
(global-set-key (kbd "<C-tab>") 'bury-buffer)

;; --- Text manipulation --- ;;

(global-set-key (kbd "RET") 'newline-and-indent)
(global-set-key (kbd "C-h") 'backward-delete-char)

;; Indenting and alignment
(global-set-key [(f8)]         'indent-region)
(global-set-key [(control f8)] 'align)
(global-set-key [(shift f8)]   'align-current)
(global-set-key [(meta f8)]    'align-regexp)

;; Comment region
(global-set-key (kbd "M-;") 'comment-or-uncomment-region-or-line)

;; Kill lines more intelligently. Keep the dumb command too.
(global-set-key (kbd "C-k") 'kill-and-join-forward)
(global-set-key (kbd "C-S-k") 'kill-line)

;; Toggle between single and double quotes
(global-set-key (kbd "C-\"") 'toggle-quotes)

;; --- Text navigation -- ;;

;; Find matching parens
(global-set-key (kbd "C-'") 'match-paren)

;; Mark entire buffer
(global-set-key (kbd "M-a") 'mark-whole-buffer)

;; C-a should jump to the first non-whitespace char.
;; M-m should jump to the actual start of the line.
(global-set-key (kbd "C-a") 'back-to-indentation)
(global-set-key (kbd "M-m") 'move-beginning-of-line)

;; expand-region
(global-set-key (kbd "C-=") 'er/expand-region)
(global-set-key (kbd "C-c q") 'er/mark-outside-quotes)
(global-set-key (kbd "C-c Q") 'er/mark-inside-quotes)

;; imenu
(global-set-key (kbd "C-j") 'imenu)

;; jump to line (I don't use screen recentering)
(global-set-key (kbd "C-l") 'goto-line)

;; jump to head chars
(global-set-key (kbd "C-c SPC") 'ace-jump-mode)

;; --- Etc. commands --- ;;

(global-set-key (kbd "<f1>") 'help-command)

;; Keyboard macros
(global-set-key [(shift f4)] 'kmacro-start-macro-or-insert-counter)

;; Repeat the last command that was typed into the minibuffer
(global-set-key [(control z)] 'repeat-complex-command) ; was suspend-frame
