;;
;; Org mode
;;

(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-cb" 'org-iswitchb)

;; set maximum indentation for description lists
(setq org-list-description-max-indent 5)

;; prevent demoting heading also shifting text inside sections
(setq org-adapt-indentation nil)

(setq org-agenda-files '("~/Documents/org"))

;; reload org files automatically
(add-hook 'org-mode-hook 'auto-revert-mode)

;; set priority range from A to C with default A
(setq org-highest-priority ?A)
(setq org-lowest-priority  ?C)
(setq org-default-priority ?A)

;; preserve uid, ignore todo and body
(setq org-icalendar-store-UID t)
(setq org-icalendar-include-body nil)
(setq org-icalendar-include-todo nil)

;; set colours for priorities
(setq org-priority-faces '((?A . (:foreground "#F0DFAF" :weight bold))
                           (?B . (:foreground "LightSteelBlue"))
                           (?C . (:foreground "OliveDrab"))))

;; open agenda in current window
(setq org-agenda-window-setup (quote current-window))

;; capture todo items using C-c c t
(define-key global-map (kbd "C-c c") 'org-capture)

(setq org-capture-templates
      '(("t" "todo" entry (file+headline "~/Documents/org/todo.org" "Tasks")
         "* TODO [#A] %?\nSCHEDULED: %(org-insert-time-stamp (org-read-date nil t \"+0d\"))\n%a\n")))

;; open agenda in current window
(setq org-agenda-window-setup (quote current-window))

;; warn me of any deadlines in next 7 days
(setq org-deadline-warning-days 7)

;; show me tasks scheduled or due in next fortnight
(setq org-agenda-span (quote fortnight))

;; don't show tasks as scheduled if they are already shown as a deadline
(setq org-agenda-skip-scheduled-if-deadline-is-shown t)

;; don't give awarning colour to tasks with impending deadlines
;; if they are scheduled to be done
(setq org-agenda-skip-deadline-prewarning-if-scheduled (quote pre-scheduled))

;; don't show tasks that are scheduled or have deadlines in the
;; normal todo list
(setq org-agenda-todo-ignore-deadlines (quote all))
(setq org-agenda-todo-ignore-scheduled (quote all))

;; sort tasks in order of when they are due and then by priority
(setq org-agenda-sorting-strategy
      (quote
       ((agenda deadline-up priority-down)
        (todo priority-down category-keep)
        (tags priority-down category-keep)
        (search category-keep))))


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

;; PlantUML
(require 'ob-plantuml)

;; syntax highlight code blocks
(setq org-src-fontify-natively t)

(add-to-list
 'org-src-lang-modes '("plantuml" . plantuml))

(setq plantuml-jar-path "/usr/share/plantuml/plantuml.jar"
      org-plantuml-jar-path "/usr/share/plantuml/plantuml.jar"
      plantuml-output-type "utxt"
      org-confirm-babel-evaluate nil)


;; Babel
(with-eval-after-load 'org
  (org-babel-do-load-languages
   'org-babel-load-languages '((plantuml . t))))

(provide 'setup-org)
