;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Manuel Argüelles"
      user-mail-address "manuel.arguelles@work.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;; (setq doom-font (font-spec :family "JetBrains Mono" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "JetBrains Mono" :size 12 :weight 'semi-light)
;;       doom-unicode-font (font-spec :family "JetBrains Mono" :size 12 :weight 'semi-light)
;;       doom-serif-font (font-spec :family "JetBrains Mono" :size 12 :weight 'semi-light))

;; (setq doom-font (font-spec :family "DejaVu Sans Mono" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "DejaVu Sans" :size 12 :weight 'semi-light)
;;       doom-unicode-font (font-spec :family "DejaVu Sans" :size 12 :weight 'semi-light)
;;       doom-serif-font (font-spec :family "DejaVu Serif" :size 12 :weight 'semi-light))

;; (setq doom-font (font-spec :family "JetBrains Mono" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "DejaVu Sans" :size 12 :weight 'semi-light)
;;       doom-unicode-font (font-spec :family "DejaVu Sans" :size 12 :weight 'semi-light)
;;       doom-serif-font (font-spec :family "DejaVu Serif" :size 12 :weight 'semi-light))

;; (setq doom-font (font-spec :family "JetBrains Mono" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "DejaVu Sans" :size 12 :weight 'semi-light)
;;       doom-unicode-font (font-spec :family "JetBrains Mono" :size 12 :weight 'semi-light)
;;       doom-serif-font (font-spec :family "DejaVu Serif" :size 12 :weight 'semi-light))

;; (setq doom-font (font-spec :family "JetBrains Mono" :size 12 :weight 'light)
;;       doom-variable-pitch-font (font-spec :family "DejaVu Sans" :size 13)
;;       doom-unicode-font (font-spec :family "JetBrains Mono" :size 12 :weight 'light)
;;       doom-serif-font (font-spec :family "DejaVu Serif" :size 13))

;; (setq doom-font (font-spec :family "Source Code Pro" :size 12)
;;       doom-variable-pitch-font (font-spec :family "Source Sans3" :size 12)
;;       doom-unicode-font (font-spec :family "Source Code Pro" :size 12)
;;       doom-serif-font (font-spec :family "Source Serif4" :size 12))

(setq doom-font (font-spec :family "Fira Code" :size 12)
      doom-variable-pitch-font (font-spec :family "DejaVu Sans" :size 13)
      doom-unicode-font (font-spec :family "Fira Code" :size 12)
      doom-serif-font (font-spec :family "DejaVu Serif" :size 13))

;; (setq doom-font (font-spec :family "Hack" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "DejaVu Sans" :size 13.0))

;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-vibrant)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type nil)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Documents/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(add-to-list 'load-path "/usr/local/share/emacs/site-lisp/mu4e/")

;; LSP
(after! lsp-clangd
  (setq lsp-clients-clangd-executable "clangd-17")
  (setq lsp-clients-clangd-args '("-j=3"
                                  "--background-index"
                                  "--clang-tidy"
                                  "--log=verbose"
                                  "--completion-style=detailed"
                                  "--header-insertion=never"
                                  "--header-insertion-decorators=0"
                                  "--malloc-trim"
                                  "--query-driver=/**/*"))
  (set-lsp-priority! 'clangd 2)
  (lsp-register-client
   (make-lsp-client :new-connection (lsp-tramp-connection '("clangd-14" "-j=3" "--background-index" "--clang-tidy" "--log=verbose" "--completion-style=detailed"  "--header-insertion=never" "--header-insertion-decorators=0" "--query-driver=/**/*"))
                    :major-modes '(c-mode c++-mode)
                    :remote? t
                    :server-id 'clangd-remote)))

;; Org mode

(setq org-want-todo-bindings t
      org-contacts-files '("~/Documents/org/contacts.org"))

;; reload org files automatically
(add-hook 'org-mode-hook 'auto-revert-mode)

;; refresh images
(add-hook 'org-babel-after-execute-hook
          (lambda ()
            (when org-inline-image-overlays
              (org-redisplay-inline-images))))

(after! org
  ;; preserve uid, ignore todo and body
  (setq org-icalendar-store-UID t)
  (setq org-icalendar-include-body nil)
  (setq org-icalendar-include-todo nil)

  (setq org-agenda-files (list "inbox.org" "agenda.org" "notes.org" "projects.org"))
  (setq org-agenda-hide-tags-regexp ".")
  (setq org-agenda-prefix-format
        '((agenda . " %i %-12:c%?-12t% s")
          (todo   . " ")
          (tags   . " %i %-12:c")
          (search . " %i %-12:c")))

  (setq org-capture-templates
        '(("i" "Inbox" entry (file "inbox.org")
           "* TODO %?\nEntered on %U")
          ("@" "Inbox [link]" entry (file "inbox.org")
           "* TODO Process \"%a\" %?\nEntered on %U")
          ("m" "Meeting" entry (file+headline "agenda.org" "Future")
           "* %? :meeting:\n%^T")
          ("n" "Note" entry (file "notes.org")
           "* Note (%a)\nEntered on %U\n\n%?")
          ("l" "Log entry" entry (file+olp+datetree "log.org")
           "* %U\n%?" :empty-lines 1)
          ))

  (setq org-refile-targets
        '(("projects.org" :regexp . "\\(?:\\(?:Note\\|Task\\)s\\)")))
  (setq org-refile-use-outline-path 'file)
  (setq org-outline-path-complete-in-steps nil)

  (setq org-todo-keywords
        '((sequence "TODO(t)" "NEXT(n)" "HOLD(h)" "|" "DONE(d)")))

  (defun log-todo-next-creation-date (&rest ignore)
    "Log NEXT creation time in the property drawer under the key 'ACTIVATED'"
    (when (and (string= (org-get-todo-state) "NEXT")
               (not (org-entry-get nil "ACTIVATED")))
      (org-entry-put nil "ACTIVATED" (format-time-string "[%Y-%m-%d]"))))

  (add-hook 'org-after-todo-state-change-hook #'log-todo-next-creation-date)

  (setq org-agenda-custom-commands
        '(("g" "Get Things Done (GTD)"
           ((agenda ""
                    ((org-agenda-skip-function
                      '(org-agenda-skip-entry-if 'deadline))
                     (org-deadline-warning-days 0)))
            (todo "NEXT"
                  ((org-agenda-skip-function
                    '(org-agenda-skip-entry-if 'deadline))
                   (org-agenda-prefix-format "  %i %-12:c [%e] ")
                   (org-agenda-overriding-header "\nTasks\n")))
            (agenda nil
                    ((org-agenda-entry-types '(:deadline))
                     (org-agenda-format-date "")
                     (org-deadline-warning-days 7)
                     (org-agenda-skip-function
                      '(org-agenda-skip-entry-if 'notregexp "\\* NEXT"))
                     (org-agenda-overriding-header "\nDeadlines")))
            (tags-todo "inbox"
                       ((org-agenda-prefix-format "  %?-12t% s")
                        (org-agenda-overriding-header "\nInbox\n")))
            (tags "CLOSED>=\"<today>\""
                  ((org-agenda-overriding-header "\nCompleted today\n")))))))

  (setq org-log-done 'time)
  )

(with-eval-after-load "ox-latex"
  (add-to-list 'org-latex-classes
               '("mimosis"
                 "\\documentclass{mimosis}
  [NO-DEFAULT-PACKAGES]
  [PACKAGES]
  [EXTRA]"
                 ("\\chapter{%s}" . "\\addchap{%s}")
                 ("\\section{%s}" . "\\section*{%s}")
                 ("\\subsection{%s}" . "\\subsection*{%s}")
                 ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                 ("\\paragraph{%s}" . "\\paragraph*{%s}")
                 ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))
  )

;; Mail

(setq mu4e-compose--org-msg-toggle-next nil)
(setq +mu4e-backend nil)
(after! mu4e
  (setq mml-smime-use 'openssl)
  (setq smime-keys '(("manuel.arguelles@work.com" "~/.doom.d/smime/keycert.pem" nil)))
  (setq mu4e-icalendar-diary-file "~/Documents/org/diary")
  (setq gnus-blocked-images "http")
  (setq mu4e-view-show-addresses t)
  (setq mu4e-change-filenames-when-moving t)
  (setq message-citation-line-format "On %b %d, %Y, at %H:%M, %f wrote:\n"
        message-citation-line-function 'message-insert-formatted-citation-line)
  (setq mu4e-context-policy 'pick-first)
  (setq mu4e-compose-context-policy 'pick-first)

  (setq mu4e-contexts
        `( ,(make-mu4e-context
             :name "work"
             :match-func (lambda(msg)
                           (when msg
                             (string-prefix-p "/work" (mu4e-message-field msg :maildir))))
             :enter-func (lambda()
                           (setq mu4e-maildir-shortcuts
                                 '(("/work/Inbox" . ?i)
                                   ("/work/sent"  . ?s)
                                   ("/work/trash" . ?t)
                                   ("/work/draft" . ?d)))
                           (setq message-send-mail-function 'smtpmail-send-it
                                 smtpmail-smtp-server "localhost"
                                 smtpmail-smtp-user "manuel.arguelles@work.com"
                                 smtpmail-stream-type 'nil
                                 smtpmail-smtp-service 1025))
             :vars '((mu4e-trash-folder . "/work/trash")
                     (mu4e-sent-folder  . "/work/sent")
                     (mu4e-drafts-folder . "/work/draft")
                     (user-mail-address . "manuel.arguelles@work.com")
                     (user-full-name . "Manuel Argüelles"))
             )
           ))

  (setq starttls-use-gnutls t)
  (setq smtpmail-debug-info t)
  (setq smtpmail-debug-verb t)
  (setq mu4e-get-mail-command "~/bin/sync_mail.sh"
        mu4e-update-interval 1800)

  ;; set attachment directory
  (setq mu4e-attachment-dir "~/Downloads")

  ;; set interesting filter
  (setq mu4e-alert-interesting-mail-query
        (concat
         "flag:unread "
         "AND NOT flag:trashed "
         "AND NOT maildir:/work/spam "
         "AND NOT maildir:/work/trash"))

  (setq mu4e-org-contacts-file "~/Documents/org/contacts.org")
  (add-to-list 'mu4e-headers-actions
               '("org-contact-add" . mu4e-action-add-org-contact) t)
  (add-to-list 'mu4e-view-actions
               '("org-contact-add" . mu4e-action-add-org-contact) t))

(after! elfeed
  (setq elfeed-search-filter "@2-days-ago +unread")
  (add-hook 'elfeed-search-mode-hook #'elfeed-update))

(after! lsp-volar
  (setq lsp-volar-take-over-mode nil))

(after! plantuml
  (setq plantuml-default-exec-mode 'jar))

(after! ox
  (require 'ox-extra)
  (ox-extras-activate '(ignore-headlines)))

(use-package! org-ref
  ;; this bit is highly recommended: make sure Org-ref is loaded after Org
  :after org

  ;; Put any Org-ref commands here that you would like to be auto loaded:
  ;; you'll be able to call these commands before the package is actually loaded.
;;  :commands
;;  (org-ref-cite-hydra/body
;;   org-ref-bibtex-hydra/body)
;;
;;  ;; if you don't need any autoloaded commands, you'll need the following
;;  ;; :defer t
;;
;;  ;; This initialization bit puts the `orhc-bibtex-cache-file` into `~/.doom/.local/cache/orhc-bibtex-cache
;;  ;; Not strictly required, but Org-ref will pollute your home directory otherwise, creating the cache file in ~/.orhc-bibtex-cache
;;  :init
;;  (let ((cache-dir (concat doom-cache-dir "org-ref")))
;;    (unless (file-exists-p cache-dir)
;;      (make-directory cache-dir t))
;;    (setq orhc-bibtex-cache-file (concat cache-dir "/orhc-bibtex-cache"))))
  :init
  (setq bibtex-completion-bibliography '("~/Documents/article.bib"))
)
