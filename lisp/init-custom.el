
;;--------------------
;; basic preferences
;;--------------------
(setq-default
	blink-cursor-delay 0
	blink-cursor-interval 0.4
    buffers-menu-max-size 30
	inhibit-startup-screen t
	case-fold-search t
	normal-erase-is-backspace t
    column-number-mode t
	grep-highlight-matches t
	grep-scroll-output t
	indent-tabs-mode nil	
    tab-width 4
    truncate-lines nil
	truncate-partial-width-windows nil
    make-backup-files nil
)

;; font setting
(custom-set-faces
    '(default ((t (:family "YaheiMonaco" :foundry "microsoft" :slant normal :weight normal :height 113 :width normal)))))


;;set default encoding to utf-8
(setq-default buffer-file-coding-system 'utf-8)
(setq save-buffer-coding-system 'utf-8)
(setq coding-system-for-write 'utf-8)

(fset 'yes-or-no-p 'y-or-n-p)


(setq-default fci-rule-column 80)
(setq fci-handle-truncate-lines nil)

(define-globalized-minor-mode global-fci-mode fci-mode (lambda () (fci-mode 1)))
(global-fci-mode 1)
(defun auto-fci-mode (&optional unused)
  (if (> (window-width) fci-rule-column)
    (fci-mode 1)
    (fci-mode 0))
  )
(add-hook 'after-change-major-mode-hook 'auto-fci-mode)
(add-hook 'window-configuration-change-hook 'auto-fci-mode)

;; enable yas
(yas-global-mode 1)

;; enable smartparens
(require 'smartparens-config)
(smartparens-global-mode 1)

;; enable evil 
(evil-mode 1)

(require 'auto-complete-config)
(ac-config-default)

(provide 'init-custom)
