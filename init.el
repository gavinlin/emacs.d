
(let ((minver 23))
    (unless (>= emacs-major-version minver)
        (error "Your Emacs is too old -- this config requires v%s or higher" minver)))

(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))

;;--------------------------------------------------------
;; package storage config
;;--------------------------------------------------------
(require 'init-melpa)


;;--------------------------------------------------------
;; general config
;;--------------------------------------------------------
(require 'init-theme)
(require 'init-custom)
(require 'init-smex)
(require 'init-org)
(require 'init-ibus)
(require 'init-c-style)
