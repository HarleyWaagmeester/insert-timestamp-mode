;; emacs
;; Search for the first occurrence of ":::" and append a date string there.
;; Don't use this mode with the insert-timestamp-mode.el file because it will write the date into the source code.

;; M-x insert-timestamp-mode will toggle this mode on and off.

(setq insert-timestamp nil)
(defun insert-timestamp-mode ()
  (interactive)
  (cond (insert-timestamp       (progn (setq insert-timestamp nil) (message "insert-timestamp-mode is disabled")))
        ((not insert-timestamp) (progn (setq insert-timestamp t)   (message "insert-timestamp-mode is enabled")))))  

(defun insert-time-stamp ()
  (interactive)
  (if insert-timestamp
      (save-current-buffer
        (save-excursion
          (goto-char(point-min))
          (search-forward ":::")
          (kill-line)
          ;;      (insert(current-time-string))
	  (insert (shell-command-to-string "echo -n $(date -u)"))
          (insert "\"")))))

(add-hook 'before-save-hook 'insert-time-stamp)
(provide 'insert-timestamp-mode)
