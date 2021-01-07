(setq org-directory "~/Dropbox/memo/org"
  org-archive-directory (concat org-directory "/archive")
  org-archive-location (concat org-archive-directory "/%s_archive::")
  org-default-notes-file (concat org-directory "/note.org")
  org-agenda-files '(
                      (concat org-directory "/note.org")
                      (concat org-directory "/idea.org")
                      (concat org-directory "/gtd.org")
                      ))

(setq org-todo-keywords
  (quote ((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d)")
           (sequence "WAITING(w@/!)" "|" "CANCELLED(c@/!)"))))

(setq org-capture-templates
  '(
	   ("t" "Task" entry (file+headline "~/Dropbox/memo/org/gtd.org" "Inbox")
	     "** TODO %? \n   CREATED: %U\n %i")
	   ("i" "Idea" entry (file+headline "~/Dropbox/memo/org/idea.org" "Idea")
	     "* %? %U %i")
	   ("r" "Remember" entry (file+headline "~/Dropbox/memo/org/remember.org" "Remember")
	     "* %? %U %i")
	   ("m" "Memo" entry (file+headline "~/Dropbox/memo/org/note.org" "Memo")
	     "* %? %U %i")
     ("R" "Review entry" entry (file+datetree "~/Dropbox/memo/org/review.org") (file "~/Dropbox/memo/org/template-review.org"))
     ))


(setq org-journal-dir "~/Dropbox/memo/org/journal/")
(setq org-journal-file-format "%Y-%m-%d")
(setq org-journal-date-format "%Y-%m-%d %A")
(setq org-journal-file-type 'weekly)
