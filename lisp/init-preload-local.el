;;; init.el --- Xiaoman's configuration -*- lexical-binding: t -*-
;;; Commentary:

;; This file is xiaoman's personal configuration.

;;; Code:

;; Enable orgmode template shortcuts.
(require 'org-tempo)

;; (global-set-key (kbd "C-c C-e") 'eval-region)

;; (setq package-archives '(("gnu" . "http://mirrors.ustc.edu.cn/elpa/gnu/")
;;                          ("melpa" . "http://mirrors.ustc.edu.cn/elpa/melpa/")
;;                          ("nongnu" . "http://mirrors.ustc.edu.cn/elpa/nongnu/")
;;                          ("org" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/org/")))

;; Globalized column width.
(setq-default fill-column 80)

;; Disable level indention in orgmode.
;; (setq-default org-adapt-indentation nil)

;; Smooth scrolling.
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time
(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse
(setq scroll-step 1) ;; keyboard scroll one line at a time

;; Use anaconda for python virtual environment.
;; (setenv "WORKON_HOME" "/home/schen/anaconda3/envs")
;; (pyvenv-mode 1)

;; Use kernel style guide in c-mode.
(defvar c-syntactic-element)
(defvar c-basic-offset)
(defun c-lineup-arglist-tabs-only (ignored)
  "IGNORED Line up argument lists by tabs, not spaces."
  (let* ((anchor (c-langelem-pos c-syntactic-element))
         (column (c-langelem-2nd-pos c-syntactic-element))
         (offset (- (1+ column) anchor))
         (steps (floor offset c-basic-offset)))
    (* (max steps 1)
       c-basic-offset)))

(add-hook 'c-mode-common-hook
          (lambda ()
            ;; Add kernel style
            (c-add-style
             "linux-tabs-only"
             '("linux" (c-offsets-alist
                        (arglist-cont-nonempty
                         c-lineup-gcc-asm-reg
                         c-lineup-arglist-tabs-only))))))

(add-hook 'c-mode-hook
          (lambda ()
            (let ((filename (buffer-file-name)))
              ;; Enable kernel mode for the appropriate files
              (when (and filename
                         (string-match (expand-file-name "/home/shichen/")
                                       filename))
                (setq indent-tabs-mode t)
                (setq show-trailing-whitespace t)
                (c-set-style "linux-tabs-only")))))


;; Org-roam configurations
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))


(require 'use-package)

;; (load-theme 'leuven t)


(use-package org-roam
  :ensure t
  :custom
  (org-roam-directory (file-truename "/home/shichen/notes/roam"))
  (setq org-roam-dailies-directory "daily/")
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n g" . org-roam-graph)
         ("C-c n i" . org-roam-node-insert)
         ("C-c n c" . org-roam-capture)
         ;; Dailies
         ("C-c n j" . org-roam-dailies-capture-today))
  :config
  ;; If you're using a vertical completion framework, you might want a more
  ;; informative completion interface
  (setq org-roam-node-display-template
        (concat "${title:*} " (propertize "${tags:10}" 'face 'org-tag)))
  (org-roam-db-autosync-mode)
  ;; If using org-roam-protocol
  (require 'org-roam-protocol))


(setq org-journal-dir "/home/shichen/notes/roam/journal")


;; (setq org-agenda-files (list "~/notes/roam"))

(global-set-key (kbd "C-x f") 'select-frame-by-name)

(provide 'init-preload-local)
;;; init-preload-local.el ends here
