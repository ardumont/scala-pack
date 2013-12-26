(defun scala/---search-and-replace (pattern-to-search pattern-replace)
  (save-excursion
    (while (re-search-forward pattern-to-search nil t)
      (replace-match pattern-replace nil nil))))

(defun scala/ignore-test-forward () "Ignore the current tests from the current position."
  (interactive)
  (scala/---search-and-replace "test(" "ignore("))

(defun scala/active-test-forward () "Unignore the current ignored tests from the current position"
  (interactive)
    (scala/---search-and-replace "ignore(" "test("))

(defun scala/switch-log-to-debug () "Switch every log.info( into log.debug("
  (interactive)
  (scala/---search-and-replace "log.info(" "log.debug("))

(defun scala/switch-log-to-info () "Switch every log.debug( into log.info("
  (interactive)
  (scala/---search-and-replace "log.debug(" "log.info("))

(define-key scala-mode-map (kbd "C-c C-a a")   'scala/active-test-forward)
(define-key scala-mode-map (kbd "C-c C-a C-a") 'scala/ignore-test-forward)
(define-key scala-mode-map (kbd "C-c C-a i")   'scala/switch-log-to-info)
(define-key scala-mode-map (kbd "C-c C-a C-i") 'scala/switch-log-to-debug)
