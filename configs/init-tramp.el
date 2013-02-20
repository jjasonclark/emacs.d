;; Turn off a lot of tramp methods that I don't use.
;; Mainly I don't want ssh1 to show up first all the time

(setq tramp-methods
      '(("smb"
         (tramp-remote-shell "")
         (tramp-tmpdir "/C$/Temp"))
        ("sudo"
         (tramp-login-program "sudo")
         (tramp-login-args
          (("-u" "%u")
           ("-s")
           ("-H")
           ("-p" "Password:")))
         (tramp-remote-shell "/bin/sh")
         (tramp-remote-shell-args
          ("-c")))
        ("su"
         (tramp-login-program "su")
         (tramp-login-args
          (("-")
           ("%u")))
         (tramp-remote-shell "/bin/sh")
         (tramp-remote-shell-args
          ("-c")))

        ("sshx"
         (tramp-login-program "ssh")
         (tramp-login-args
          (("-l" "%u")
           ("-p" "%p")
           ("-e" "none")
           ("-t" "-t")
           ("%h")
           ("/bin/sh")))
         (tramp-async-args
          (("-q")))
         (tramp-remote-shell "/bin/sh")
         (tramp-remote-shell-args
          ("-c"))
         (tramp-gw-args
          (("-o" "GlobalKnownHostsFile=/dev/null")
           ("-o" "UserKnownHostsFile=/dev/null")
           ("-o" "StrictHostKeyChecking=no")))
         (tramp-default-port 22))
        ("ssh2"
         (tramp-login-program "ssh")
         (tramp-login-args
          (("-l" "%u")
           ("-p" "%p")
           ("-2")
           ("-e" "none")
           ("%h")))
         (tramp-async-args
          (("-q")))
         (tramp-remote-shell "/bin/sh")
         (tramp-remote-shell-args
          ("-c"))
         (tramp-gw-args
          (("-o" "GlobalKnownHostsFile=/dev/null")
           ("-o" "UserKnownHostsFile=/dev/null")
           ("-o" "StrictHostKeyChecking=no")))
         (tramp-default-port 22))
        ("ssh"
         (tramp-login-program "ssh")
         (tramp-login-args
          (("-l" "%u")
           ("-p" "%p")
           ("-e" "none")
           ("%h")))
         (tramp-async-args
          (("-q")))
         (tramp-remote-shell "/bin/sh")
         (tramp-remote-shell-args
          ("-c"))
         (tramp-gw-args
          (("-o" "GlobalKnownHostsFile=/dev/null")
           ("-o" "UserKnownHostsFile=/dev/null")
           ("-o" "StrictHostKeyChecking=no")))
         (tramp-default-port 22))
        ("rsyncc"
         (tramp-login-program "ssh")
         (tramp-login-args
          (("-l" "%u")
           ("-p" "%p")
           ("-o" "ControlPath=%t.%%r@%%h:%%p")
           ("-o" "ControlMaster=yes")
           ("-e" "none")
           ("%h")))
         (tramp-async-args
          (("-q")))
         (tramp-remote-shell "/bin/sh")
         (tramp-remote-shell-args
          ("-c"))
         (tramp-copy-program "rsync")
         (tramp-copy-args
          (("-t" "%k")
           ("-r")))
         (tramp-copy-env
          (("RSYNC_RSH")
           ("ssh -o ControlPath=%t.%%r@%%h:%%p -o ControlMaster=auto")))
         (tramp-copy-keep-date t)
         (tramp-copy-keep-tmpfile t)
         (tramp-copy-recursive t))
        ("rsync"
         (tramp-login-program "ssh")
         (tramp-login-args
          (("-l" "%u")
           ("-p" "%p")
           ("-e" "none")
           ("%h")))
         (tramp-async-args
          (("-q")))
         (tramp-remote-shell "/bin/sh")
         (tramp-remote-shell-args
          ("-c"))
         (tramp-copy-program "rsync")
         (tramp-copy-args
          (("-e" "ssh")
           ("-t" "%k")
           ("-r")))
         (tramp-copy-keep-date t)
         (tramp-copy-keep-tmpfile t)
         (tramp-copy-recursive t))
        ("sftp"
         (tramp-login-program "ssh")
         (tramp-login-args
          (("-l" "%u")
           ("-p" "%p")
           ("-e" "none")
           ("%h")))
         (tramp-async-args
          (("-q")))
         (tramp-remote-shell "/bin/sh")
         (tramp-remote-shell-args
          ("-c"))
         (tramp-copy-program "sftp"))
        ("scpx"
         (tramp-login-program "ssh")
         (tramp-login-args
          (("-l" "%u")
           ("-p" "%p")
           ("-e" "none")
           ("-t" "-t")
           ("%h")
           ("/bin/sh")))
         (tramp-async-args
          (("-q")))
         (tramp-remote-shell "/bin/sh")
         (tramp-remote-shell-args
          ("-c"))
         (tramp-copy-program "scp")
         (tramp-copy-args
          (("-P" "%p")
           ("-p" "%k")
           ("-q")
           ("-r")))
         (tramp-copy-keep-date t)
         (tramp-copy-recursive t)
         (tramp-gw-args
          (("-o" "GlobalKnownHostsFile=/dev/null")
           ("-o" "UserKnownHostsFile=/dev/null")
           ("-o" "StrictHostKeyChecking=no")))
         (tramp-default-port 22))
        ("scpc"
         (tramp-login-program "ssh")
         (tramp-login-args
          (("-l" "%u")
           ("-p" "%p")
           ("-o" "ControlPath=%t.%%r@%%h:%%p")
           ("-o" "ControlMaster=yes")
           ("-e" "none")
           ("%h")))
         (tramp-async-args
          (("-q")))
         (tramp-remote-shell "/bin/sh")
         (tramp-remote-shell-args
          ("-c"))
         (tramp-copy-program "scp")
         (tramp-copy-args
          (("-P" "%p")
           ("-p" "%k")
           ("-q")
           ("-r")
           ("-o" "ControlPath=%t.%%r@%%h:%%p")
           ("-o" "ControlMaster=auto")))
         (tramp-copy-keep-date t)
         (tramp-copy-recursive t)
         (tramp-gw-args
          (("-o" "GlobalKnownHostsFile=/dev/null")
           ("-o" "UserKnownHostsFile=/dev/null")
           ("-o" "StrictHostKeyChecking=no")))
         (tramp-default-port 22))
        ("scp2"
         (tramp-login-program "ssh")
         (tramp-login-args
          (("-l" "%u")
           ("-p" "%p")
           ("-2")
           ("-e" "none")
           ("%h")))
         (tramp-async-args
          (("-q")))
         (tramp-remote-shell "/bin/sh")
         (tramp-remote-shell-args
          ("-c"))
         (tramp-copy-program "scp")
         (tramp-copy-args
          (("-2")
           ("-P" "%p")
           ("-p" "%k")
           ("-q")
           ("-r")))
         (tramp-copy-keep-date t)
         (tramp-copy-recursive t)
         (tramp-gw-args
          (("-o" "GlobalKnownHostsFile=/dev/null")
           ("-o" "UserKnownHostsFile=/dev/null")
           ("-o" "StrictHostKeyChecking=no")))
         (tramp-default-port 22))
        ("scp1"
         (tramp-login-program "ssh")
         (tramp-login-args
          (("-l" "%u")
           ("-p" "%p")
           ("-1")
           ("-e" "none")
           ("%h")))
         (tramp-async-args
          (("-q")))
         (tramp-remote-shell "/bin/sh")
         (tramp-remote-shell-args
          ("-c"))
         (tramp-copy-program "scp")
         (tramp-copy-args
          (("-1")
           ("-P" "%p")
           ("-p" "%k")
           ("-q")
           ("-r")))
         (tramp-copy-keep-date t)
         (tramp-copy-recursive t)
         (tramp-gw-args
          (("-o" "GlobalKnownHostsFile=/dev/null")
           ("-o" "UserKnownHostsFile=/dev/null")
           ("-o" "StrictHostKeyChecking=no")))
         (tramp-default-port 22))
        ("scp"
         (tramp-login-program "ssh")
         (tramp-login-args
          (("-l" "%u")
           ("-p" "%p")
           ("-e" "none")
           ("%h")))
         (tramp-async-args
          (("-q")))
         (tramp-remote-shell "/bin/sh")
         (tramp-remote-shell-args
          ("-c"))
         (tramp-copy-program "scp")
         (tramp-copy-args
          (("-P" "%p")
           ("-p" "%k")
           ("-q")
           ("-r")))
         (tramp-copy-keep-date t)
         (tramp-copy-recursive t)
         (tramp-gw-args
          (("-o" "GlobalKnownHostsFile=/dev/null")
           ("-o" "UserKnownHostsFile=/dev/null")
           ("-o" "StrictHostKeyChecking=no")))
         (tramp-default-port 22))

        ("ftp")))


(eval-after-load 'tramp '(setenv "SHELL" "/bin/bash"))

(provide 'init-tramp)
