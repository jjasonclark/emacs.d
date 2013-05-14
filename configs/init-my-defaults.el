;; turn off viz bell that starter-kit turns on.
(setq visible-bell nil)

;; from http://blog.tuxicity.se/elisp/emacs/2010/03/26/rename-file-and-buffer-in-emacs.html
(defun rename-file-and-buffer ()
  "Renames current buffer and file it is visiting."
  (interactive)
  (let ((name (buffer-name))
        (filename (buffer-file-name)))
    (if (not (and filename (file-exists-p filename)))
        (message "Buffer '%s' is not visiting a file!" name)
      (let ((new-name (read-file-name "New name: " filename)))
        (cond ((get-buffer new-name)
               (message "A buffer named '%s' already exists!" new-name))
              (t
               (rename-file name new-name 1)
               (rename-buffer new-name)
               (set-visited-file-name new-name)
               (set-buffer-modified-p nil)))))))

(global-set-key (kbd "C-c r") 'rename-file-and-buffer)


;; Get rid of annoying warning about needing to make directory
(add-hook 'before-save-hook
          '(lambda ()
             (or (file-exists-p (file-name-directory buffer-file-name))
                 (make-directory (file-name-directory buffer-file-name) t))))


;; From http://trey-jackson.blogspot.com/2009/06/emacs-tip-31-kill-other-buffers-of-this.html
(global-set-key (kbd "C-x K") 'kill-other-buffers-of-this-file-name)
(defun kill-other-buffers-of-this-file-name (&optional buffer)
  "Kill all other buffers visiting files of the same base name."
  (interactive "bBuffer to make unique: ")
  (setq buffer (get-buffer buffer))
  (cond ((buffer-file-name buffer)
         (let ((name (file-name-nondirectory (buffer-file-name buffer))))
           (loop for ob in (buffer-list)
                 do (if (and (not (eq ob buffer))
                             (buffer-file-name ob)
                             (let ((ob-file-name (file-name-nondirectory (buffer-file-name ob))))
                               (or (equal ob-file-name name)
                                   (string-match (concat name "\\.~.*~$") ob-file-name))) )
                        (kill-buffer ob)))))
        (default (message "This buffer has no file name."))))


;; Sudo tools

(setq tramp-default-method "ssh")
(defun sudo-edit (&optional arg)
  (interactive "p")
  (if arg
      (find-file (concat "/sudo:root@localhost:" (ido-read-file-name "File: ")))
    (find-alternate-file (concat "/sudo:root@localhost:" buffer-file-name))))

;; It appears I need to allow ssh into localhost and with root?!?
(defun sudo-edit-current-file ()
  (interactive)
  (find-alternate-file (concat "/sudo:root@localhost:" (buffer-file-name (current-buffer)))))

(global-set-key (kbd "C-c C-r") 'sudo-edit-current-file)

;; Fix indentation for buffer
(defun fix-read-only-indentation ()
  "Fix the indentation of a read only file.  For now you have to
remember to not save this change if you have write access to the
file"
  (interactive)
  (toggle-read-only)
  (indent-region (point-min) (point-max)))



;;http://blog.plover.com/prog/revert-all.html
;; Could rewrite this to be more functional
(defun revert-all-buffers ()
  "Refreshes all open buffers from their respective files"
  (interactive)
  (let* ((list (buffer-list))
         (buffer (car list)))
    (while buffer
      (when (and (buffer-file-name buffer)
                 (not (buffer-modified-p buffer)))
        (set-buffer buffer)
        (revert-buffer t t t))
      (setq list (cdr list))
      (setq buffer (car list))))
  (message "Refreshed open files"))

;;http://blog.tuxicity.se/elisp/emacs/2010/11/16/delete-file-and-buffer-in-emacs.html
(defun delete-this-buffer-and-file ()
  "Removes file connected to current buffer and kills buffer."
  (interactive)
  (let ((filename (buffer-file-name))
        (buffer (current-buffer))
        (name (buffer-name)))
    (if (not (and filename (file-exists-p filename)))
        (error "Buffer '%s' is not visiting a file!" name)
      (when (yes-or-no-p "Are you sure you want to remove this file? ")
        (delete-file filename)
        (kill-buffer buffer)
        (message "File '%s' successfully removed" filename)))))


;;http://www.emacswiki.org/emacs/CopyAndPaste
(defun path-to-clipboard ()
  "Copy the current file's path to the clipboard.

  If the current buffer has no file, copy the buffer's default directory."
  (interactive)
  (let ((path (expand-file-name (or (buffer-file-name) default-directory))))
    (set-clipboard-contents-from-string path)
    (message "%s" path)))

(defun set-clipboard-contents-from-string (str)
  "Copy the value of string STR into the clipboard."
  (let ((x-select-enable-clipboard t))
    (x-select-text str)))


(defun colorize-rails-log ()
  "Setup the ansi log color"
  (interactive)
  ;; prevent running this on non log files!
  (if (string-match ".log$" buffer-file-name)
      (ansi-color-apply-on-region (point-min) (point-max))))



;;; https://gist.github.com/1034475
;;; Prevent acidental iconify/suspend.
(when (window-system)
  (defun smart-iconify-or-deiconify-frame ()
    "Present a confirmation before suspending/iconifying."
    (interactive)
    (if (yes-or-no-p (format "Are you sure you want to iconify/deiconify Emacs? "))
        (iconify-frame)))
  ;; Rebinding C-z to the new function.
  (global-set-key (kbd "C-z") 'smart-iconify-or-deiconify-frame)
  ;; Rebinding C-x C-z to the new function. Overrides suspend-frame.
  (global-set-key (kbd "C-x C-z") 'smart-iconify-or-deiconify-frame))

;;; Auto revert any files that have changed since I viewed it.
;;; Warns when I've made changes and the backend has changed
(global-auto-revert-mode t)

(global-auto-revert-mode nil)


;; http://stackoverflow.com/questions/2550474/is-it-possible-to-auto-regenerate-and-load-tags-table-in-emacs-rather-than-having
(setq tags-revert-without-query t)



(defun cleanup-timers-on-killed-buffers ()
  (interactive)
  (mapc (lambda (timer) (cancel-timer timer))
        (remove-if-not
         (lambda (timer) (string-equal "(#<killed buffer>)" (prin1-to-string (aref timer 6))))
         timer-list)))

(run-with-idle-timer 60 t 'cleanup-timers-on-killed-buffers)


;; From http://emacs-fu.blogspot.jp/2010/03/cleaning-up-buffers-automatically.html
(require 'midnight)



(global-font-lock-mode 1)

;; always end a file with a newline
(setq require-final-newline t)

;; no need for backup-files in this day and age?
(setq make-backup-files nil)


(global-set-key "\M-g" 'goto-line)
(global-set-key [(control tab)]  'indent-relative)

;; no more overwrite!
(global-set-key [insert] nil)

;; Kill annoying <C-next> scroll-left key, make same as page down
;; Mainly to work around bad mac habits
(global-set-key [(control next)] 'scroll-up)
(global-set-key [(control prior)] 'scroll-down)

; C-Shift-backspace is the native one for this
(global-set-key [(control shift k)] 'kill-whole-line)

;; Can't stand the gnome file dialog
(setq use-file-dialog nil)


(defun zev-sc-status ()
  "Call the proper status call if current buffer's dir has .svn"
  (interactive)
  (let ((dirname (file-name-directory buffer-file-name)))
    (if (file-exists-p (concat dirname "/.svn"))
        (svn-status dirname)
      (magit-status dirname))
    )
  )


;; overload this
(defun zev-grep-find (command-args)
  "Run grep via find, with user-specified args COMMAND-ARGS.
Collect output in a buffer.
While find runs asynchronously, you can use the \\[next-error] command
to find the text that grep hits refer to.

This command uses a special history list for its arguments, so you can
easily repeat a find command."
  (interactive
   (progn
     (grep-compute-defaults)
     (if grep-find-command
         (let* ((find-str (funcall zev-grep-find-command))
                (point-pos (length find-str)))
           (list (read-from-minibuffer "Run find (like this): "
                                       (cons find-str point-pos) nil nil
                                       'grep-find-history)))
       ;; No default was set
       (read-string
        "compile.el: No `grep-find-command' command available. Press RET.")
       (list nil))))
  (when command-args
    (let ((null-device nil))		; see grep
      (grep command-args))))

(setq zev-grep-command "grep -n -E ")
(setq zev-grep-find-command (lambda ()
                          (let ((fmt-str (zev-find-mode-str)))
                            (format "%s %s -regex '%s' -print0 | xargs -0 -e %s '%s'"
                                    find-program (discover-current-project) fmt-str zev-grep-command (or (thing-at-point 'sexp) "")))))

;; Trying to get this to quote the symbol..
;; (setq grep-find-command (lambda ()
;;                           (let ((fmt-str (zev-find-mode-str)))
;;                             (format "%s %s -regex '%s' -print0 | xargs -0 -e %s %s"
;;                                     find-program (discover-current-project) fmt-str grep-command (concat "\"" (thing-at-point 'sexp) "\"")))))


(defun zev-find-mode-str ()
  "find args based on mode"
  (cond
   ((eq major-mode 'sh-mode) ".*\\.sh\\|.*\\.zsh$")
   ((eq major-mode 'c-mode) ".*\\.c\\|.*\\.h$")
   ((eq major-mode 'c++-mode) ".*\\.cpp\\|.*\\.c\\|.*\\.h$")
   ((eq major-mode 'conf-space-mode) ".*\\.conf\\|.*\\.cnf\\$")
   ((eq major-mode 'php-mode) ".*\\.php")
   ((eq major-mode 'puppet-mode) ".*\\.pp$\\|.*\\.rb$\\|.*\\.erb$")
   ((eq major-mode 'emacs-lisp-mode) ".*\\.el")
   ((eq major-mode 'nagios-mode) ".*\\.cfg")
   ((eq major-mode 'erlang-mode) ".*\\.erl")
   ((eq major-mode 'clojure-mode) ".*\\.cljs?")
   ((eq major-mode 'conf-colon-mode) ".*\\.conf")
   ((eq major-mode 'crontab-mode) ".*\\.crontab")
   ((eq major-mode 'handlebars-mode) ".*\\.handlebars")
   (t ".*\\.rb$\\|.*\\.rhtml\\|.*\\.js\\|.*\\.xbuilder\\|.*\\.rake\\|.*\\.erb$")
   ) )



(defun insert-url-at-point-into-buffer ()
  "Takes url at point and inserts content into new buffer"
  (interactive)
  (let ((url (ffap-url-at-point)))
    (shell-command (format "curl --silent '%s'" url) (generate-new-buffer (format "*curl %s*" url)))))


(defun blame-from-stable ()
  "Makes a git blame of current file from stable"
  (interactive)
  (let* ((buff-file-name (buffer-file-name (current-buffer)))
        (cd-dir (file-name-directory buff-file-name))
        (file-name-nondirectory buff-file-name))
    (shell-command (format "cd %s && git blame stable %s" cd-dir file-name-nondirectory) (generate-new-buffer (format "*git-blame stable:%s*" file-name-nondirectory)))))

(global-set-key [f5] 'revert-buffer)
(global-set-key [f6] 'zev-sc-status)
(global-set-key [f2] 'zev-grep-find)

;; From http://nflath.com/2009/10/emacs-settings/ some other good stuff in there too.
(setq temporary-file-directory "~/.emacs.d/tmp/")

;; use spaces instead of tabs
(setq-default indent-tabs-mode nil)

;; don't let `next-line' add new lines in buffer
(setq next-line-add-newlines nil)

;; get rid of yes-or-no questions - y or n is enough
(defalias 'yes-or-no-p 'y-or-n-p)

;; auto-fill is default for text-mode
;;(add-hook 'text-mode-hook
;;     'auto-fill-mode)

;; open unknown in text mode
(setq default-major-mode 'text-mode)

;; Shift arrows to move around easier
(windmove-default-keybindings)

(setq author "Zev Blut")

;; auto set 755 on #! files
(add-hook 'after-save-hook
          'executable-make-buffer-file-executable-if-script-p)


(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Get rid of annoying warning about needing to make directory
(add-hook 'before-save-hook
          '(lambda ()
             (or (file-exists-p (file-name-directory buffer-file-name))
                 (make-directory (file-name-directory buffer-file-name) t))))


(put 'narrow-to-region 'disabled nil)


(put 'scroll-left 'disabled nil)


(load-theme 'zenburn 'NO-CONFIRM)

;; I like having the menu bar
(menu-bar-mode t)


;; sgml-mode of starter kit has auto-fill on somehow
(add-hook 'sgml-mode-hook 'turn-off-auto-fill)

;; Turn off starter-kit's ffap when opening files with find-file
;; No more pinging Tonga!
(setq ido-use-filename-at-point nil)

;; Not using abbrev file so that causes issues where it removes
;; completion.  Playing around with other options
(setq hippie-expand-try-functions-list '(try-complete-file-name
                                         try-expand-dabbrev
                                         try-expand-dabbrev-all-buffers
                                         try-expand-dabbrev-from-kill
                                         try-expand-list
                                         try-expand-line
                                         try-complete-lisp-symbol-partially
                                         try-complete-lisp-symbol))


(provide 'init-my-defaults)
