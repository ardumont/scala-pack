;; Place your bindings here.

;; For example:
(define-key scala-mode-map (kbd "C-c C-z") 'ensime-sbt-switch)
(define-key scala-mode-map (kbd "C-c C-c z") 'ensime-inf-switch);; TODO find a simpler one

;; Alternatively, bind the 'newline-and-indent' command and
;; 'scala-indent:insert-asterisk-on-multiline-comment' to RET in
;; order to get indentation and asterisk-insertion within multi-line
;; comments.
(define-key scala-mode-map
  (kbd "RET") '(lambda ()
                 (interactive)
                 (newline-and-indent)
                 (scala-indent:insert-asterisk-on-multiline-comment)))
