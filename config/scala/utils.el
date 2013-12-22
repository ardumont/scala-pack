(defun scala/ignore-test-forward () "Ignore the current tests from the current position."
  (interactive)
  (save-excursion
    (while (re-search-forward "test(" nil t)
      (replace-match "ignore(" nil nil))))

(defun scala/active-test-forward () "Unignore the current ignored tests from the current position"
  (interactive)
  (save-excursion
    (while (re-search-forward "ignore\(" nil t)
      (replace-match "test\(" nil nil))))
