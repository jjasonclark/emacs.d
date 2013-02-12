;; The load path to the nginx-mode should come from the
;; source_packages dir

(add-to-list 'load-path "/Users/Zev/projects/nginx-mode/")
(autoload 'nginx-mode "nginx-mode" "Major mode for nginx configs" t)
(add-to-list 'auto-mode-alist '("nginx.*.conf$" . nginx-mode))

(provide 'init-nginx)
