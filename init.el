(setq *TEMPORARY-PACKAGE-ARCHIVES* package-archives)

(install-packs '(scala-mode2) (add-to-list '*TEMPORARY-PACKAGE-ARCHIVES* '("melpa" . "http://melpa.milkbox.net/packages/") t))

;; ================= scala-mode2

(require 'scala-mode2)

;; strictly functional style
(setq scala-indent:default-run-on-strategy scala-indent:eager-strategy)
(setq scala-indent:indent-value-expression t)
(setq scala-indent:align-parameters t)
(setq scala-indent:align-forms t)

(add-hook 'scala-mode-hook '(lambda ()
  (require 'whitespace)

  ;; clean-up whitespace at save
  (make-local-variable 'before-save-hook)
  (add-hook 'before-save-hook 'whitespace-cleanup)

  (make-local-variable 'whitespace-style)
  (setq whitespace-style '(face, tabs, trailing))

  ;; turn on highlight. To configure what is highlighted, customize
  ;; the *whitespace-style* variable. A sane set of things to
  ;; highlight is: face, tabs, trailing
  (whitespace-mode)))

;; ================= ensime

;; you need to setup your environment to have a variable name ENSIME_ROOT
(setq ensime-root (getenv "ENSIME_ROOT"))

;; a basic check and warning in case of problem
(if (not ensime-root)
  (message "Warning - You must set a variable ENSIME_ROOT pointing to the root of your ensime installation, for example, ~/applications/ensime to benefit from all the setup.")
  (progn
    (message "Proceeding with the scala setup...")
    ;; Load the ensime lisp code...
    (add-to-list 'load-path (concat ensime-root "/elisp/"))
    (require 'ensime)

    ;; This step causes the ensime-mode to be started whenever
    ;; scala-mode is started for a buffer. You may have to customize this step
    ;; if you're not using the standard scala mode.
    (add-hook 'scala-mode-hook 'ensime-scala-mode-hook)))

;; Load bindings config
(live-load-config-file "bindings.el")
(live-load-config-file "akka/utils.el")
(live-load-config-file "scala/utils.el")
