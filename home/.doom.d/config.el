;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
(setq doom-font (font-spec :family "Cica" :size 18)
      doom-unicode-font (font-spec :family "Cica" :size 18))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-nord)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Dropbox/memo/org/")
(setq org-roam-directory "~/Dropbox/memo/org/roam")

;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.


;; OS判定
(defun macp ()
  (eq system-type 'darwin))
(defun linuxp ()
  (eq system-type 'gnu/linux))
(defun bsdp ()
  (eq system-type 'gnu/kfreebsd))
(defun winp ()
  (eq system-type 'windows-nt))
(defun wslp ()
  (and (eq system-type 'gnu/linux)
       (file-exists-p "/proc/sys/fs/binfmt_misc/WSLInterop")))

;; Ctrl-h
(map! "C-h" 'delete-backward-char)

;; delete character without yanking
(map! :n "x" 'delete-char)

;; leader key
(add-hook! 'org-mode-hook #'+org-init-keybinds-h)
(setq evil-snipe-override-evil-repeat-keys nil)
(setq doom-localleader-key ",")
(setq doom-localleader-alt-key "M-,")

;; auto save
(use-package! auto-save-buffers-enhanced
  :config
  (setq auto-save-buffers-enhanced-interval 1)
  (setq auto-save-buffers-enhanced-quiet-save-p t)
  (auto-save-buffers-enhanced t)
  )

;; Disable exit confirmation.
(setq confirm-kill-emacs nil)

;; org-mode の日付を英語にする
(setq system-time-locale "C")

(after! org-roam
  (map!
    "C-c n l" #'org-roam-buffer-toggle
    "C-c n f" #'org-roam-node-find
    "C-c n i" #'org-roam-node-insert
    )
  )

(map! :after evil-org
      :map evil-org-mode-map
      :ni "C-<return>" #'org-insert-heading-respect-content
      :ni "C-S-<return>" #'org-insert-todo-heading-respect-content
      )

;; mozc
(use-package mozc
  :if (wslp)
  :config
  (setq mozc-helper-program-name "mozc_emacs_helper.exe")
  (setq mozc-helper-process-timeout-sec 10)
  ;; Windows の mozc では、セッション接続直後 directモード になるので hiraganaモード にする
  (advice-add 'mozc-session-execute-command
              :after (lambda (&rest args)
                       (when (eq (nth 0 args) 'CreateSession)
                         ;; (mozc-session-sendkey '(hiragana)))))
                         (mozc-session-sendkey '(Hankaku/Zenkaku))))))
(use-package mozc-im
  :if (wslp)
  :after mozc
  :config
  ;;(bind-key "<zenkaku-hankaku>" #'toggle-input-method)
  ;; IME有効時のタイトル設定
  (defun my-mozc-leim-title ()
    "Return a title string (with image icon) when mozc IM is enabled."
    (let ((icon (expand-file-name
                 ;; 解像度に応じてアイコンの大きさを変える
                 (format "images/mozc-icon-%d.png"
                         (if (> (display-pixel-height) 2000) 32 16))
                 user-emacs-directory)))
      (if (and (image-type-available-p 'png) (file-exists-p icon))
          (progn
            ;; 画像表示のために `current-input-method-title' のテキストプロパティを有効にする
            (put 'current-input-method-title 'risky-local-variable t)
            (propertize "あ" 'display `(image :type png :file ,icon :ascent center
                                              :mask heuristic :margin (2 . 0))))
        "[あ]")))
  (setq mozc-leim-title (my-mozc-leim-title))
  (setq default-input-method "japanese-mozc-im"))

(use-package mozc-popup :disabled t
  :if (wslp)
  :after mozc
  :config
  ;; 変換候補をポップアップで表示する
  (setq mozc-candidate-style 'popup))
