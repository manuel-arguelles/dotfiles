(use-package ivy
  :ensure t
  :diminish (ivy-mode . "")
  :config
  (ivy-mode 1)
  (setq ivy-use-virutal-buffers t)
  (setq enable-recursive-minibuffers t)
  (setq ivy-height 10)
  (setq ivy-initial-inputs-alist nil)
  (setq ivy-count-format "%d/%d ")
  (setq ivy-re-builders-alist
        `((t . ivy--regex-ignore-order)))
  (setq projectile-completion-system 'ivy)
  (use-package counsel-projectile
    :ensure t)
  )

(use-package counsel
  :ensure t
  :bind (("M-x" . counsel-M-x)
         ("\C-x \C-f" . counsel-find-file)
         ("\C-x f" . counsel-git)
         ("\C-c g" . counsel-git-grep))
  )

(use-package swiper
  :ensure t
  :bind (("\C-s" . swiper))
  )

(provide 'setup-ivy)
