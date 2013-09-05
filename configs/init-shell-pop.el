(require 'shell-pop)
(shell-pop-set-internal-mode "ansi-term")
(shell-pop-set-internal-mode-shell "/bin/bash")
(global-set-key [f11] 'shell-pop)

(provide 'init-shell-pop)
