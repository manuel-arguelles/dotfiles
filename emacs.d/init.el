;; setup marmalade package repo
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/"))
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)

(package-initialize)

(unless package-archive-contents (package-refresh-contents))

(defun ensure-installed (&rest packages)
  "Checks if packages are installed, installs if not"
  (cond ((consp packages)
         (when (not (package-installed-p (car packages)))
           (package-install (car packages)))
         (apply 'ensure-installed (cdr packages)))))

 ;; packages I use
(ensure-installed 'assemblage-theme
		  'flyspell
		  'php-mode)

;; Spell check dictionary
(defun fd-switch-dictionary()
  (interactive)
  (let* ((dic ispell-current-dictionary)
         (change (if (string= dic "es") "en" "es")))
    (ispell-change-dictionary change)
    (message "Dictionary switched from %s to %s" dic change)))
(global-set-key (kbd "<f8>") 'fd-switch-dictionary)

;; Color theme
(when (display-graphic-p)
  (load-theme 'assemblage t))

;; Font
;; Should already be set on X resources/defaults
;;(set-face-attribute 'default nil :font "Terminus-12")

;; Desktop mode
(desktop-save-mode 0)

;; Show the column number
(column-number-mode t)

;; Disable toolbar and menubar
(tool-bar-mode -1)
(menu-bar-mode -1)

;; Backup files
(setq make-backup-files nil)

;; Dont show the GNU splash screen
(setq inhibit-startup-message t)

;; Mode defs
(add-to-list 'auto-mode-alist '("\\.php" . php-mode))


;; Hooks

(add-hook 'flyspell-mode
	  (lambda()
	    (setq flyspell-issue-welcome-flag nil)
	    (setq flyspell-issue-message-flag nil)
	    )
	  )

(add-hook 'c-mode-common-hook
	  (lambda()
	    (c-set-style "k&r")
	    (setq tab-width 4
		  ident-tabs-mode nil)
	    (setq c-basic-offset 4)
	    (flyspell-prog-mode)
	    (show-paren-mode t)
	    )
	  )
				       
(add-hook 'text-mode-hook
	  (lambda()
	    (flyspell-mode 1)
	    )
	  )
