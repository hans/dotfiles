;;; Generic emacs settings I cannot live without

;; Use command as the meta key
(setq ns-command-modifier (quote meta))

;; Don't show the startup screen
(setq inhibit-startup-message t)

;; "y or n" instead of "yes or no"
(fset 'yes-or-no-p 'y-or-n-p)

;; Highlight regions and add special behaviors to regions.
;; "C-h d transient" for more info
(setq transient-mark-mode t)

;; Display line and column numbers
(setq line-number-mode    t)
(setq column-number-mode  t)

;; Emacs gurus don't need no stinking scroll bars
(when (fboundp 'toggle-scroll-bar)
  (toggle-scroll-bar -1))

;; Explicitly show the end of a buffer
(set-default 'indicate-empty-lines t)

;; Line-wrapping
(set-default 'fill-column 80)

;; Prevent the annoying beep on errors
;; (setq visible-bell t)

;; Make sure all backup files only live in one place
(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))

;; Gotta see matching parens
;; Highlight both parens if they are visible. If only one is visible, highlight
;; the entire expression they contain.
(show-paren-mode t)
(setq show-paren-style 'mixed)

;; Don't truncate lines
(setq truncate-lines t)
(setq truncate-partial-width-windows nil)

;; For emacsclient
(server-start)

;; Trailing whitespace is unnecessary
(add-hook 'before-save-hook (lambda () (delete-trailing-whitespace)))

;; Trash can support
(setq delete-by-moving-to-trash t)

;; `brew install aspell --lang=en` (instead of ispell)
(setq-default ispell-program-name "aspell")
(setq ispell-list-command "list")
(setq ispell-extra-args '("--sug-mode=ultra"))

;; Hide the menu bar
(menu-bar-mode 0)

;; Electric pair: Auto-insert pair characters
;; ex. when you type (, ) is inserted after the cursor
(electric-pair-mode t)

;; Electric layout mode
(electric-layout-mode t)

;; Better names for buffers of same filename
;; If you open both ~/foo/a.sh and ~/Desktop/a.sh, the buffer names will be
;; 'foo/a.sh' and 'Desktop/a.sh' rather than 'a.sh' and 'a.sh<2>'.
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)
(setq uniquify-separator "/")
(setq uniquify-after-kill-buffer-p t)    ; rename after killing uniquified
(setq uniquify-ignore-buffers-re "^\\*") ; don't muck with special buffers

;; Preserve screen position of cursor when scrolling
(setq scroll-preserve-screen-position t)

;; Pressing C-n when the point is at the end of the buffer will insert newlines
(setq next-line-add-newlines t)

;; Don't auto-save so often - it makes Tramp editing difficult!
(setq auto-save-interval 10000)

;; zap-up-to-char, forward-to-word, backward-to-word, etc
(require 'misc)

;; Replace selected regions just by typing; kill by pressing DEL (matches usual
;; GUI behavior)
(delete-selection-mode 1)

;; Don't blink cursor
(blink-cursor-mode -1)
