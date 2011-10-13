;; Load all packages

(require 'package)

(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)

(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

(defvar required-packages
  '(clojure-mode clojure-test-mode coffee-mode color-theme flymake-cursor
                 full-ack haml-mode haskell-mode magit markdown-mode
                 mustache-mode notify paredit php-mode scala-mode slime
                 slime-repl swank-clojure yaml-mode yasnippet yasnippet-bundle)
  "Packages which should be installed upon launch")

(dolist (p required-packages)
  (when (not (package-installed-p p))
    (package-install p)))
