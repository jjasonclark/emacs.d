emacs.d
=======

This is a set of Emacs configuration files.
It attempts to setup a slightly cleaner structure for installing and 
configuring packages.  All custom configurations go in the config/ directory.
This is an attempt to reduce the line count on the init.el and group related
settings into related files.

### Setup Instructions

1. Create the file `~/.emacs.d/config/init-work.el` with the following contents

    ```
    (provide 'init-work)
    ```
