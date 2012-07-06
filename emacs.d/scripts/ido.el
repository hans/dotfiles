;;; Interactive do, find-file and iswitchb replacement with fuzzy/flex matching.

(ido-mode t)
(setq ido-enable-prefix nil
      ido-enable-flex-matching t
      ido-enable-last-directory-history nil ; forget latest selected directory names
      ido-create-new-buffer 'prompt
      ido-default-file-method 'raise-frame)

(require 'ido-ubiquitous)
(ido-ubiquitous-mode 1)
