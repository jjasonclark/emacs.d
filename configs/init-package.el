(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))


;; ;;------------------------------------------------------------------------------
;; ;; Also use Melpa for some packages built straight from VC
;; ;;------------------------------------------------------------------------------
(add-to-list 'package-archives '("melpa" .
                                 "http://melpa.milkbox.net/packages/"))


(if (not (file-exists-p (concat dotfiles-dir "/elpa")))
    (package-refresh-contents))
(package-initialize)

;; These packages might not need to be listed here, due to load order.
;; But for now let's load these up first so I can override any
;; settings I don't like
(defvar my-packages '(starter-kit
                      starter-kit-lisp
                      starter-kit-eshell
                      starter-kit-bindings
                      starter-kit-ruby
                      starter-kit-js
                      clojure-mode clojure-test-mode
                      cljsbuild-mode
                      crontab-mode
                      less-css-mode
                      markdown-mode
                      yaml-mode
                      marmalade
                      gnuplot
                      haskell-mode
                      erlang
                      grep-a-lot
                      zenburn-theme
                      rinari
                      robe
                      json-mode
                      auto-complete
                      handlebars-mode
                      interaction-log
                      slim-mode
                      scss-mode
                      flymake-sass
                      ))


(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

(provide 'init-package)
