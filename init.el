;; Must be first for package management
(require 'cask "~/.cask/cask.el")
(cask-initialize)
(require 'pallet)
;; end package management

;; An attempt at more modular Emacs configuration
;; A hybrid of emacs-starter-kit, steve purcell's emacs.d and a little
;; bit of prelude, plus my own thing


(setq dotfiles-dir (file-name-directory
                    (or (buffer-file-name) load-file-name)))

(setq custom-file (concat dotfiles-dir "custom.el"))

;; May not need to have this explicitly
;;(add-to-list 'load-path (expand-file-name "~/.emacs.d"))

;; Configs is where I will store configurations about tools I require
;; like spurcell's work but not all in the emacs.d dir
(add-to-list 'load-path (expand-file-name "~/.emacs.d/configs"))

(when (equal system-type 'darwin)
  (require 'init-mac))

(require 'init-auto-complete)
(require 'init-clojure)
(require 'init-dns)
(require 'init-gnuplot)
(require 'init-grep-a-lot)
(require 'init-magit)

(require 'init-ruby)
;; This is probably needed via emacs-wiki install
;;(require 'init-shell-pop)
(require 'init-smerge)
(require 'init-smex)
(require 'init-tramp)
(require 'init-uniquify)
(require 'init-yaml)
;;(require 'init-web-mode)

;; I might only want this on from time to time
;; (require 'init-interaction-log)

(require 'init-my-defaults)
(require 'init-work)

;; load custom at end
(load custom-file 'noerror)

;; You can keep system- or user-specific customizations here
(setq system-specific-config (concat dotfiles-dir system-name ".el")
      user-specific-config (concat dotfiles-dir user-login-name ".el")
      user-specific-dir (concat dotfiles-dir user-login-name))
(add-to-list 'load-path user-specific-dir)

(if (file-exists-p system-specific-config) (load system-specific-config))
(if (file-exists-p user-specific-config) (load user-specific-config))
(if (file-exists-p user-specific-dir)
  (mapc #'load (directory-files user-specific-dir nil ".*el$")))
