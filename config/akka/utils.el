(defun akka/clean-debug-log () "Clean some akka debug log."
  (interactive)
  (akka/--clean-debug-log-remove-debug)
  (akka/--clean-debug-log-align))

(defun akka/--clean-debug-log-remove-debug () "Just clean the logs up."
  (save-excursion
    (goto-char (point-min))
    (while (re-search-forward "\\\[DEBUG\\\] .*\n" nil t)
      (replace-match "" nil nil))))

(defun akka/--clean-debug-log-align () "Just align the remaining logs"
  (align-regexp (point-min) (point-max)  "\\(\\s-*\\) - "))
