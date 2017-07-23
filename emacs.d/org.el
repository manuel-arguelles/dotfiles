;;
;; Org mode
;;

(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

(setq org-agenda-files (quote ("~/Documents/org")))

(setq org-use-fast-todo-selection t)
(setq org-treat-S-cursor-todo-selection-as-state-change nil)

(add-hook 'org-mode-hook 'auto-revert-mode)

(setq org-todo-keywords
      (quote ((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d)")
	      (sequence "WAITING(w@/!)" "HOLD(h@/!)" "|" "CANCELLED(c@/!)" "PHONE" "MEETING"))))

(setq org-todo-keyword-faces
      (quote (("TODO" :foreground "red" :weight bold)
	      ("NEXT" :foreground "blue" :weight bold)
	      ("DONE" :foreground "forest green" :weight bold)
	      ("WAITING" :foreground "orange" :weight bold)
	      ("HOLD" :foreground "magenta" :weight bold)
	      ("CANCELLED" :foreground "forest green" :weight bold)
	      ("MEETING" :foreground "forest green" :weight bold)
	      ("PHONE" :foreground "forest green" :weight bold))))

(setq org-todo-state-tags-triggers
      (quote (("CANCELLED" ("CANCELLED" . t))
	      ("WAITING" ("WAITING" . t))
	      ("HOLD" ("WAITING") ("HOLD" . t))
	      (done ("WAITING") ("HOLD"))
	      ("TODO" ("WAITING") ("CANCELLED") ("HOLD"))
	      ("NEXT" ("WAITING") ("CANCELLED") ("HOLD"))
	      ("DONE" ("WAITING") ("CANCELLED") ("HOLD")))))

(setq org-directory "~/Documents/org")
(setq org-default-notes-file "~/Documents/org/refile.org")

;; I use C-c c to start capture mode
(global-set-key (kbd "C-c c") 'org-capture)

;; Capture templates for: TODO tasks, Notes, appointments, phone calls, meetings, and org-protocol
(setq org-capture-templates
      (quote (("t" "todo" entry (file "~/Documents/org/refile.org")
	       "* TODO %?\n%U\n%a\n" :clock-in t :clock-resume t)
	      ("r" "respond" entry (file "~/Documents/org/refile.org")
	       "* NEXT Respond to %:from on %:subject\nSCHEDULED: %t\n%U\n%a\n" :clock-in t :clock-resume t :immediate-finish t)
	      ("n" "note" entry (file "~/Documents/org/refile.org")
	       "* %? :NOTE:\n%U\n%a\n" :clock-in t :clock-resume t)
	      ("j" "Journal" entry (file+datetree "~/Documents/org/diary.org")
	       "* %?\n%U\n" :clock-in t :clock-resume t)
	      ("w" "org-protocol" entry (file "~/Documents/org/refile.org")
	       "* TODO Review %c\n%U\n" :immediate-finish t)
	      ("m" "Meeting" entry (file "~/Documents/org/refile.org")
	       "* MEETING with %? :MEETING:\n%U" :clock-in t :clock-resume t)
	      ("p" "Phone call" entry (file "~/Documents/org/refile.org")
	       "* PHONE %? :PHONE:\n%U" :clock-in t :clock-resume t)
	      ("h" "Habit" entry (file "~/Documents/org/refile.org")
	       "* NEXT %?\n%U\n%a\nSCHEDULED: %(format-time-string \"%<<%Y-%m-%d %a .+1d/3d>>\")\n:PROPERTIES:\n:STYLE: habit\n:REPEAT_TO_STATE: NEXT\n:END:\n"))))

;; Dairy
(appt-activate)
(setq diary-file "~/Documents/org/diary"
      org-agenda-include-diary t
      view-diary-entries-initially t
      mark-diary-entries-in-calendar t
      number-of-diary-entries 7
      appt-display-duration 60)
(add-hook 'diary-display-hook 'fancy-diary-display)
(add-hook 'today-visible-calendar-hook 'calendar-mark-today)

(org-agenda-to-appt)
