;; Emacs ERC configuration

(require 'erc)

(setq-default
 erc-default-server "irc.freenode.net"
 erc-nick "hansengel"
 erc-user-full-name "Hans Engel"

 ;; load modules
 erc-modules '(autojoin button completion irccontrols list log match
                        move-to-prompt netsplit networks noncommands
                        readonly ring stamp track)

 ;; change prompt to >
 erc-prompt ">"

 ;; auto-reconnect
 erc-server-auto-reconnect t

 ;; track channels
 erc-track-mode t

 ;; don't track JOIN, NICK, PART, QUIT, or MODE
 erc-track-exclude-types '("JOIN" "NICK" "PART" "QUIT" "MODE"
                           "324" "329" "332" "333" "353" "457")

 ;; log
 erc-log-channels t
 erc-log-channels-directory "~/.irclogs"
 ;; automatically write to log files when parting channels
 erc-save-buffer-on-part t
 erc-hide-timestamps nil

 ;; by default, when you join a channel ERC fills the screen with previous messages from a log for that channel if one exists.
 ;; the following code disables that functionality. see http://www.emacswiki.org/emacs/ErcLogging#toc2
 erc-log-insert-log-on-open nil)

;; auto-save log files on emacs exit
(defadvice save-buffers-kill-emacs (before save-logs (arg) activate)
  (save-some-buffers t (lambda () (when (and (eq major-mode 'erc-mode)
                                             (not null buffer-file-name))))))

;; fill the whole window
(add-hook 'erc-mode-hook (lambda () (auto-fill-mode 1)))

;; show notifications (via notify.el) when my nick is mentioned
(add-hook 'erc-text-matched-hook
          (lambda (match-type nick message)
            (unless (posix-string-match "^\\** *Users on #" message)
              (notify "ERC" (concat "You were mentioned in "
                                    (buffer-name (current-buffer)))))))
