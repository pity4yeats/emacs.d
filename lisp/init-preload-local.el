;;; init-preload-local.el --- Summary
;;; Commentary:
;;; Code:

(setq-default fill-column 80)
(defun my-c++-mode-hook ()
  (setq c-basic-offset 8)
  (c-set-offset 'substatement-open 0))
(add-hook 'c++-mode-hook 'my-c++-mode-hook)
(setq-default c-basic-offset 8)

(global-set-key (kbd "M-o") 'switch-window)

(provide 'init-preload-local)
;;; init-preload-local.el ends here
