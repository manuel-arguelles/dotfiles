(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(desktop-save-mode 0)
(column-number-mode t)

(setq gc-cons-threshold 100000000)

(setq inhibit-startup-message t)
(setq compilation-scroll-output t)

(defalias 'yes-or-no-p 'y-or-n-p)

(global-set-key (kbd "C-x k") 'kill-this-buffer)

;; show unncessary whitespace that can mess up your diff
(add-hook 'prog-mode-hook
          (lambda () (interactive)
            (setq show-trailing-whitespace 1)))

;; disable backup files
(setq make-backup-files nil)

;; use space to indent by default
(setq-default indent-tabs-mode nil)

;; set appearance of a tab that is represented by 4 spaces
(setq-default tab-width 2)

;; setup GDB
(setq
 ;; use gdb-many-windows by default
 gdb-many-windows t

 ;; Non-nil means display source file containing the main routine at startup
 gdb-show-main t
 )

;; zenburn theme
(use-package zenburn-theme
  :ensure t
  :load-path "themes"
  :init
  :config
  (load-theme 'zenburn t)
  )

(set-default-font "Terminus-12")
(add-to-list 'default-frame-alist '(font . "Terminus-12"))

(use-package company
  :init
  (global-company-mode 1)
  (delete 'company-semantic company-backends))

(use-package projectile
  :init
  (projectile-global-mode)
  (setq projectile-enable-caching t)
  (setq projectile-globally-ignored-directories
        (append '("build" "_CPack_Packages" ".ccls-cache") projectile-globally-ignored-directories))
  (global-set-key (kbd "C-c o") 'projectile-find-other-file))

(provide 'setup-general)
