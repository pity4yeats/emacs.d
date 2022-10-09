;;; init-roam.el --- Configuration for org-roam -*- lexical-binding: t -*-
;;; Commentary:

;;; Code:

(use-package org-roam
  :ensure t
  :custom
  (org-roam-directory (file-truename "~/notes"))
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
  
  ;; The following definition is required by customizing display template
  (cl-defmethod org-roam-node-type ((node org-roam-node))
    "Return the TYPE of NODE."
    (condition-case nil
	(file-name-nondirectory
	 (directory-file-name
          (file-name-directory
           (file-relative-name (org-roam-node-file node) org-roam-directory))))
      (error "")))
  (setq org-roam-node-display-template
        (concat "${type:15} ${title:*} " (propertize "${tags:10}" 'face 'org-tag)))

  (org-roam-db-autosync-mode)
  ;; If using org-roam-protocol
  (require 'org-roam-protocol))


(setq org-roam-capture-templates
      '(("a" "Agenda" plain
         "%?"
         :if-new (file+head "agenda/${slug}.org"
                            "#+title: ${title}\n#+options: ^:nil\n#+filetags: :agenda:\n")
         :immediate-finish t
         :unnarrowed t)
        ("t" "Temporary (TBD - aka 'To Be Determined')" plain
         "%?"
         :if-new (file+head "tmp/${slug}.org"
                            "#+title: ${title}\n#+options: ^:nil\n")
         :immediate-finish t
         :unnarrowed t)
        ("c" "Misc" plain "%?"
         :if-new
         (file+head "misc/${slug}.org" "#+title: ${title}\n#+options: ^:nil\n")
         :immediate-finish t
         :unnarrowed t)
        ("p" "Temps Perdu" plain "%?"
         :if-new
         (file+head "temps/${slug}.org" "#+title: ${title}\n#+options: ^:nil\n#+filetags: :temps:\n")
         :immediate-finish t
         :unnarrowed t)
        ("h" "RHEL" plain
         "%?"
         :if-new (file+head "rhel/${slug}.org"
                            "#+title: ${title}\n#+options: ^:nil\n#+filetags: :rhel:\n")
         :immediate-finish t
         :unnarrowed t)
        ("r" "RTS (RealTimeScheduling - aka 'RATS')" plain
         "%?"
         :if-new (file+head "rts/${slug}.org"
                            "#+title: ${title}\n#+options: ^:nil\n#+filetags: :rts:\n")
         :immediate-finish t
         :unnarrowed t)
        ("b" "BPF" plain "%?"
         :if-new
         (file+head "bpf/${slug}.org" "#+title: ${title}\n#+options: ^:nil\n#+filetags: :bpf:\n")
         :immediate-finish t
         :unnarrowed t)
        ("o" "Old" plain
         "%?"
         :if-new (file+head "old/${slug}.org"
                            "#+title: ${title}\n#+options: ^:nil\n")
         :immediate-finish t
         :unnarrowed t)
        ("m" "Memory" plain "%?"
         :if-new
         (file+head "mm/${slug}.org" "#+title: ${title}\n#+options: ^:nil\n#+filetags: :mm:\n")
         :immediate-finish t
         :unnarrowed t)))

(setq org-journal-dir "~/notes/journal")

(setq org-agenda-files (list "~/notes/agenda"))

(setq org-archive-location "~/notes/agenda/agenda.org_archive::* From %s")

(provide 'init-roam)
;;; init-roam.el ends here
