;; Emacs ERC configuration

(require 'erc)

;; track channels
(require 'erc-track)
(erc-track-mode t)

;; don't track JOIN, NICK, PART, QUIT, or MODE
(setq erc-track-exclude-types '("JOIN" "NICK" "PART" "QUIT" "MODE"
                                "324" "329" "332" "333" "353" "457"))

;; buttonize
(require 'erc-button)

;; log
(require 'erc-log)
(setq erc-log-channels t)
(setq erc-log-channels-directory "~/.irclogs")
(setq erc-hide-timestamps nil)

;; by default, when you join a channel ERC fills the screen with previous messages from a log for that channel if one exists.
;; the following code disables that functionality. see http://www.emacswiki.org/emacs/ErcLogging#toc2
(setq erc-log-insert-log-on-open nil)

;; resize ERC's wrap width when the window is resized
(add-hook 'window-configuration-change-hook
          '(lambda ()
             (setq erc-fill-column (- (window-width) 2))))

;; fill the whole window
(add-hook 'erc-mode-hook (lambda () (auto-fill-mode 1)))