;; Load all packages

(require 'package)

(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)

(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)

(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

(defvar required-packages
  '(s dash rfringe popup php-mode mmm-mode js2-mode sml-mode
    ob-sml clojure-mode coffee-mode color-theme haml-mode
    ack-and-a-half haskell-mode magit markdown-mode mustache-mode
    notify paredit scala-mode yaml-mode yasnippet
    yasnippet-bundle j-mode ace-jump-mode expand-region
    zenburn-theme ido-ubiquitous smooth-scroll flx-ido
    python-mode go-mode nrepl solarized-theme git-messenger
    flycheck multiple-cursors powerline projectile)
  "Packages which should be installed upon launch")

(dolist (p required-packages)
  (when (not (package-installed-p p))
    (package-install p)))
