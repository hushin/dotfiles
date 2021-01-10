(setq org-directory "~/Dropbox/memo/org"
  org-archive-directory (concat org-directory "/archive")
  org-archive-location (concat org-archive-directory "/%s_archive::")
  org-default-notes-file (concat org-directory "/note.org")
  org-agenda-files (list org-directory))

(setq org-todo-keywords
  (quote ((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d)")
           (sequence "WAITING(w@/!)" "|" "CANCELLED(c@/!)"))))

(add-to-list 'org-modules 'org-protocol)

(setq org-capture-templates
  '(
	   ("t" "Task" entry (file+headline "~/Dropbox/memo/org/gtd.org" "Inbox")
	     "* TODO %? \n   CREATED: %U\n %i")
	   ("i" "Idea" entry (file+headline "~/Dropbox/memo/org/idea.org" "Idea")
	     "* %? %U %i")
	   ("r" "Remember" entry (file+headline "~/Dropbox/memo/org/remember.org" "Remember")
	     "* %? %U %i")
	   ("m" "Memo" entry (file+headline "~/Dropbox/memo/org/note.org" "Memo")
	     "* %? %U %i")
	   ("p" "Protocol" entry (file+headline "~/Dropbox/memo/org/note.org" "Inbox")
       "* %^{Title}\nSource: %u, %c\n #+BEGIN_QUOTE\n%i\n#+END_QUOTE\n\n\n%?")
	   ("L" "Protocol Link" entry (file+headline "~/Dropbox/memo/org/note.org" "Inbox")
       "* %? [[%:link][%:description]] \nCaptured On: %U")
	   ("M" "Memo from protocol" entry (file+headline "~/Dropbox/memo/org/note.org" "Memo")
       "* %^{Title}\nSource: %u, %c\n #+BEGIN_QUOTE\n%i\n#+END_QUOTE\n\n\n%?")
     ;; ("R" "Review entry" entry (file+datetree "~/Dropbox/memo/org/review.org") (file "~/Dropbox/memo/org/template-review.org"))
     ))

(add-hook 'org-capture-mode-hook 'evil-insert-state)

(setq org-journal-dir "~/Dropbox/memo/org/journal/")
(setq org-journal-file-format "%Y-%m-%d")
(setq org-journal-date-format "%Y-%m-%d %A")
(setq org-journal-time-format "%R\n")
(setq org-journal-file-type 'weekly)
(setq org-journal-find-file 'find-file)
(setq org-extend-today-until '3)

;; 行の折り返しの設定
(add-hook 'visual-line-mode-hook
  '(lambda()
     (setq word-wrap nil)))
(defun org-journal-file-header-func (time)
  "Custom function to create journal header."
  (concat
    (pcase org-journal-file-type
      (`weekly "#+TITLE: Weekly Journal\n#+STARTUP: content indent inlineimages"))))
(setq org-journal-file-header 'org-journal-file-header-func)
