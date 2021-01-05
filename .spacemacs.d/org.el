(setq org-directory "~/Dropbox/memo/org"
  org-archive-directory (concat org-directory "/archive")
  org-archive-location (concat org-archive-directory "/%s_archive::")
  org-default-notes-file (concat org-directory "/memo.org")
  org-agenda-files '(
                      (concat org-directory "/memo.org")
                      (concat org-directory "/idea.org")
                      (concat org-directory "/gtd.org")
                      ))

(setq org-todo-keywords
  (quote ((sequence "TODO(t)" "NEXT(n)" "|" "DONE(d)")
           (sequence "WAITING(w)" "|" "CANCELLED(c)" "MEETING"))))

(setq org-capture-templates
  '(
	   ("t" "Task" entry (file+headline "~/Dropbox/memo/org/gtd.org" "Inbox")
	     "** TODO %? \n   CREATED: %i\n %a")
	   ("i" "Idea" entry (file+headline "~/Dropbox/memo/org/idea.org" "Idea")
	     "* %? %U %i")
	   ("r" "Remember" entry (file+headline "~/Dropbox/memo/org/remember.org" "Remember")
	     "* %? %U %i")
	   ("m" "Memo" entry (file+headline "~/Dropbox/memo/org/memo.org" "Memo")
	     "* %? %U %i")
     ))
