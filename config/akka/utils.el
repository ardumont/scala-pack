(defun akka/clean-info-log () "Clean akka info log."
  (interactive)
  (akka/--clean-info-log-remove-debug)
  (akka/--log-align))

(defun akka/clean-debug-log () "Clean akka debug log."
  (interactive)
  (akka/--clean-debug-log-remove-debug)
  (akka/--log-align))

(defun akka/--clean-log-with-pattern (pattern) "Just clean all the logs from the current buffer"
  (save-excursion
    (goto-char (point-min))
    (while (re-search-forward pattern nil t)
      (replace-match "" nil nil))))

(defun akka/--clean-debug-log-remove-debug () "Just clean the logs up."
  (akka/--clean-log-with-pattern "\\\[DEBUG\\\] .*\n"))

(defun akka/--clean-info-log-remove-debug () "Just clean the logs up."
    (akka/--clean-log-with-pattern "\\\[INFO\\\] .*\n"))

(defun akka/--log-align () "Just align the remaining logs"
  (align-regexp (point-min) (point-max)  "\\(\\s-*\\) - "))
