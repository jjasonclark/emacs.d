(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(ac-config-default)
;; don't show the complete while typing
(setq ac-auto-start nil)
(global-set-key "\M-]" 'auto-complete)

(provide 'init-auto-complete)
