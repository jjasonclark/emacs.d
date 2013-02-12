
(require 'grep-a-lot)
;;(grep-a-lot-setup-keys)
(defun grep-a-lot-setup-keys()
  "Define some key bindings for navigating multiple
grep search results buffers."
  (define-key esc-map "p]" 'grep-a-lot-goto-next)
  (define-key esc-map "p[" 'grep-a-lot-goto-prev)
  (define-key esc-map "p-" 'grep-a-lot-pop-stack)
  (define-key esc-map "p_" 'grep-a-lot-clear-stack)
  (define-key esc-map "p=" 'grep-a-lot-restart-context))

(provide 'init-grep-a-lot)
