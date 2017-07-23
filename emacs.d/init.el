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
(ensure-installed 'zenburn-theme
		  'flyspell
		  'php-mode
		  'git-commit
		  'markdown-mode
		  'tempo
		  'irony
		  'company-irony
		  'xcscope)

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
  (load-theme 'zenburn t))

;; Font
;; Should already be set on X resources/defaults
;;(set-face-attribute 'default nil :font "Terminus-12")
(set-default-font "Terminus-12")

;; Desktop mode
(desktop-save-mode 0)

;; Show the column number
(column-number-mode t)

;; Disable toolbar and menubar and scroll
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

;; Backup files
(setq make-backup-files nil)

;; Dont show the GNU splash screen
(setq inhibit-startup-message t)

;; Show trailing white spaces
(setq-default show-trailing-whitespace t)

;; Confirm exit
(setq confirm-kill-emacs 'y-or-n-p)

;; Mode defs
(add-to-list 'auto-mode-alist '("\\.php" . php-mode))
(add-to-list 'auto-mode-alist '("mutt-.*" . mail-mode))
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))

;; Hooks
(add-hook 'after-init-hook 'global-company-mode)

(add-hook 'flyspell-mode
	  (lambda()
	    (setq flyspell-issue-welcome-flag nil)
	    (setq flyspell-issue-message-flag nil)
	    )
	  )

(add-hook 'c-mode-common-hook
	  (lambda()
	    (c-set-style "k&r")
	    (setq tab-width 8
		  indent-tabs-mode nil
		  c-basic-offset 2
		  fill-column 80)
	    (flyspell-prog-mode)
	    (show-paren-mode t)
	    (irony-mode t)
	    )
	  )

(defun my-c-lineup-inclass (langelem)
  (let ((inclass (assoc 'inclass c-syntactic-context)))
    (save-excursion
      (goto-char (c-langelem-pos inclass))
      (if (or (looking-at "struct")
	      (looking-at "typedef struct"))
	  '+
	'++))))

(add-hook 'c++-mode-hook
	  (lambda()
	    (c-set-style "stroustrup")
	    (setq indent-tabs-mode nil
		  c-basic-offset 4
		  fill-column 116)
	    (c-set-offset 'access-label '-)
;;	    (c-set-offset 'innamespace 0)
	    (c-set-offset 'inclass 'my-c-lineup-inclass)
	    (c-set-offset 'case-label '+)
	    )
	  )

(add-hook 'sh-mode-hook
	  (lambda()
	    (setq indent-tabs-mode nil)
	    )
	  )

(add-hook 'text-mode-hook
	  (lambda()
	    (setq fill-column 80)
	    (flyspell-mode 1)
	    (auto-fill-mode 1)
	    )
	  )

(add-hook 'mail-mode-hook
	  (lambda ()
	    (setq fill-column 76
		  confirm-kill-emacs nil)
	    (flyspeel-mode 1)
	    (auto-fill-mode 1)
	    )
	  )

(add-hook 'markdown-mode-hook
	  (lambda ()
	    (setq fill-column 116)
	    )
	  )

(global-git-commit-mode t)

;; Org mode
(load-file "~/.emacs.d/org.el")

;; Windows manager urgency hint
(load-file "~/.emacs.d/urgency.el")

;; replace the `completion-at-point' and `complete-symbol' bindings in
;; irony-mode's buffers by irony-mode's function
(defun my-irony-mode-hook ()
  (define-key irony-mode-map [remap completion-at-point]
    'irony-completion-at-point-async)
  (define-key irony-mode-map [remap complete-symbol]
    'irony-completion-at-point-async))
(add-hook 'irony-mode-hook 'my-irony-mode-hook)
(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)

(eval-after-load 'company
  '(add-to-list 'company-backends 'company-irony))

;; (optional) adds CC special commands to `company-begin-commands' in order to
;; trigger completion at interesting places, such as after scope operator
;;     std::|
(add-hook 'irony-mode-hook 'company-irony-setup-begin-commands)

(global-set-key (kbd "C-<tab>") 'company-dabbrev)
(global-set-key (kbd "M-<tab>") 'company-complete)
(put 'upcase-region 'disabled nil)

(cscope-setup)
(put 'downcase-region 'disabled nil)
