(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(add-to-list 'ac-modes 'enh-ruby-mode)
(add-to-list 'ac-modes 'web-mode)
(ac-config-default)
;; don't show the complete while typing
(setq ac-auto-start nil)
(setq ac-ignore-case nil)
(global-set-key "\M-]" 'auto-complete)

(provide 'init-auto-complete)
