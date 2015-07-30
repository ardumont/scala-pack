;;; scala-pack.el --- Scala

;;; Commentary:

;;; Code:

(use-package whitespace)
(use-package smartscan)

;; ================= ensime

(defvar ensime-root (getenv "ENSIME_ROOT"))

(unless ensime-root
  (message "Warning - You must set a variable ENSIME_ROOT pointing to the root of your ensime installation, for example, ~/applications/ensime to benefit from all the setup.")
  (message "Proceeding with the scala setup..."))

(defvar ensime-rootpath (concat ensime-root "/elisp/"))

(use-package scala-mode2
  :config
  (add-hook 'scala-mode-hook 'smartscan-mode)
  ;; strictly functional style
  (custom-set-variables
   '(scala-indent:default-run-on-strategy scala-indent:eager-strategy)
   '(scala-indent:indent-value-expression t)
   '(scala-indent:align-parameters t)
   '(scala-indent:align-forms t))

  (add-hook 'scala-mode-hook '(lambda ()
                                ;; clean-up whitespace at save
                                (make-local-variable 'before-save-hook)
                                (add-hook 'before-save-hook 'whitespace-cleanup)

                                (make-local-variable 'whitespace-style)
                                (setq whitespace-style '(face, tabs, trailing))

                                ;; turn on highlight. To configure what is highlighted, customize
                                ;; the *whitespace-style* variable. A sane set of things to
                                ;; highlight is: face, tabs, trailing
                                (whitespace-mode)))

  (use-package ensime
    :load-path ensime-rootpath
    :config
    ;; This step causes the ensime-mode to be started whenever
    ;; scala-mode is started for a buffer. You may have to customize this step
    ;; if you're not using the standard scala mode.
    (add-hook 'scala-mode-hook 'ensime-scala-mode-hook)

    (define-key scala-mode-map (kbd "C-c C-z") 'ensime-sbt-switch)
    (define-key scala-mode-map (kbd "C-c C-c z") 'ensime-inf-switch);; TODO find a simpler one

    ;; Alternatively, bind the 'newline-and-indent' command and
    ;; 'scala-indent:insert-asterisk-on-multiline-comment' to RET in
    ;; order to get indentation and asterisk-insertion within multi-line
    ;; comments.
    (define-key scala-mode-map (kbd "RET") (lambda ()
                                             (interactive)
                                             (newline-and-indent)
                                             (scala-indent:insert-asterisk-on-multiline-comment))))
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


  ;; scala utils

  (defun scala/---search-and-replace (pattern-to-search pattern-replace)
    (save-excursion
      (while (re-search-forward pattern-to-search nil t)
        (replace-match pattern-replace nil nil))))

  (defun scala/ignore-test-forward ()
    "Ignore the current test from the current position."
    (interactive)
    (scala/---search-and-replace "test(" "ignore("))

  (defun scala/active-test-forward ()
    "Toggle ignore the current ignored test from the current position."
    (interactive)
    (scala/---search-and-replace "ignore(" "test("))

  (defun scala/switch-log-to-debug ()
    "Switch every log.info( into log.debug("
    (interactive)
    (scala/---search-and-replace "log.info(" "log.debug("))

  (defun scala/switch-log-to-info ()
    "Switch every log.debug( into log.info("
    (interactive)
    (scala/---search-and-replace "log.debug(" "log.info("))

  (define-key scala-mode-map (kbd "C-c C-a a")   'scala/active-test-forward)
  (define-key scala-mode-map (kbd "C-c C-a C-a") 'scala/ignore-test-forward)
  (define-key scala-mode-map (kbd "C-c C-a i")   'scala/switch-log-to-info)
  (define-key scala-mode-map (kbd "C-c C-a C-i") 'scala/switch-log-to-debug))


(provide 'scala-pack)
;;; scala-pack.el ends here
