;; clojure-mode

(setq swank-clojure-jar-path "~/.clojure/clojure.jar"
      swank-clojure-extra-classpaths (list
                                      "~/.clojure/clojure-contrib.jar"
                                      "~/.clojure/src/clj/clojure"))

(eval-after-load "slime"
  '(progn (slime-setup '(slime-repl))))
