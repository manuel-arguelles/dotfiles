(defun activity-set-urgency ()
  (x-urgency-hint (selected-frame) t))

(defun x-urgency-hint (frame arg &optional source)
  (let* ((wm-hints (append (x-window-property
			    "WM_HINTS" frame "WM_HINTS" source nil t) nil))
	 (flags (car wm-hints)))
    (setcar wm-hints
	    (if arg
		(logior flags #x100)
	      (logand flags (lognot #x100))))
    (x-change-window-property "WM_HINTS" wm-hints frame "WM_HINTS" 32 t)))

(setq ring-bell-function 'activity-set-urgency)
