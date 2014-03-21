(add-to-list 'load-path "~/.emacs.d/ibus-el/")
(require 'ibus)
(add-hook 'after-init-hook 'ibus-mode-on)
(ibus-define-common-key ?\C-j t)
(ibus-define-common-key [backspace] t)

(provide 'init-ibus)
