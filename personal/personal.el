;;; personal.el --- Initialization file for Prelude Emacs

;;; Commentary: Emacs Startup File --- initialization for Emacs

;;; Code:

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; required packages
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(prelude-require-package 'nord-theme)
(prelude-require-package 'solarized-theme)
(prelude-require-package 'kosmos-theme)
(prelude-require-package 'theme-looper)
(prelude-require-package 'dashboard)
(prelude-require-package 'all-the-icons)
(prelude-require-package 'all-the-icons-dired)
(prelude-require-package 'display-line-numbers)
(prelude-require-package 'org-superstar)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; theme (set in personal/preload/theme.el)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(disable-theme 'zenburn)
(toggle-scroll-bar -1)
(menu-bar-mode -1)
(blink-cursor-mode 1)
; (toggle-truncate-lines -1)
(theme-looper-set-favorite-themes
 '(nord kosmos solarized-dark solarized-light leuven default))

(global-set-key (kbd "C-|") 'theme-looper-select-theme)
(global-set-key (kbd "C-M-|") 'theme-looper-select-theme-from-all)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; keybindings
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq prelude-super-keybindings nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; evil
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun ex-kill-buffer-and-close ()
  "Kill current buffer."
  (interactive)
  (unless (char-equal (elt (buffer-name) 0) ?*)
    (kill-this-buffer)))

(defun ex-save-kill-buffer-and-close ()
  "Save current buffer then kill it."
  (interactive)
  (save-buffer)
  (kill-this-buffer))

(evil-ex-define-cmd "q[uit]" 'ex-kill-buffer-and-close )
(evil-ex-define-cmd "wq" 'ex-save-kill-buffer-and-close)

(defun my-evil-record-macro ()
  "For read-only buffers use q to `quit-window`."
  (interactive)
  (if buffer-read-only
      (quit-window)
    (call-interactively 'evil-record-macro)))

(with-eval-after-load 'evil-maps
  (define-key evil-normal-state-map (kbd "q") 'my-evil-record-macro))

;; use default emacs keybindings in modes
(evil-set-initial-state 'image-dired-thumbnail-mode 'emacs)
(evil-set-initial-state 'image-dired-display-image-mode 'emacs)
(evil-set-initial-state 'image-mode 'emacs)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; line-numbers
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defcustom display-line-numbers-exempt-modes
  '(vterm-mode eshell-mode shell-mode term-mode ansi-term-mode cider-repl-mode)
  "Major modes on which to disable line numbers.")

(defun display-line-numbers--turn-on ()
  "Turn on line numbers except for certain major modes.
   Exempt major modes are defined in `display-line-numbers-exempt-modes'."
  (unless (or (minibufferp)
              (member major-mode display-line-numbers-exempt-modes))
    (display-line-numbers-mode)))

(global-display-line-numbers-mode)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; whitespace
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-hook 'gfm-mode-hook (lambda () (whitespace-toggle-options 'lines-tail)))
(add-hook 'web-mode-hook (lambda () (whitespace-toggle-options 'lines-tail)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; dashboard
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(dashboard-setup-startup-hook)
(setq dashboard-set-heading-icons t)
(setq dashboard-set-file-icons t)
(setq dashboard-items '((recents  . 10)
                        (bookmarks . 10)
                        (projects . 10)
                        (agenda . 5)
                        (registers . 3)))
(setq dashboard-week-agenda t)
(setq dashboard-agenda-release-buffers t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ibuffer - http://martinowen.net/blog/2010/02/03/tips-for-emacs-ibuffer.html
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq ibuffer-saved-filter-groups
  '(("home"
     ("Clojure" (mode . clojure-mode))
     ("Clojure REPL" (or (name . "\*cider")
                         (name . "\*nrepl")))
     ("Data" (or (filename . "csv")
                 (filename . "json$")))
     ("Dired" (mode . dired-mode))
     ("Docs" (mode . doc-view-mode))
     ("TeX" (or (mode . TeX-output-mode)
                (mode . latex-mode)))
     ("emacs-config" (or (filename . ".emacs.d")
                         (filename . "personal.el")
                         (filename . "emacs-config")))
     ("Images" (or (mode . image-mode)
                   (name . "\*image-dired")))
     ("Magit" (or (name . "\*magit")
                  (mode . magit-log-mode)
                  (mode . magit-status-mode)
                  (mode . magit-diff-mode)
                  (mode . magit-process-mode)
                  (mode . magit-revision-mode)))
     ("Org" (or (mode . org-mode)
                (filename . "Org")))
     ("Python" (or (mode . python-mode)
                   (mode . anaconda-mode)
                   (name . "\*Python\*")
                   (name . "\*gud-pdb\*")
                   (name . "\*Anaconda\*")
                   (name . "\*anaconda-mode\*")))
     ("Shells" (or (mode . eshell-mode)
                   (mode . bash-mode)
                   (mode . shell-mode)))
     ("Web" (or (mode . web-mode)
                (mode . html-mode)
                (mode . js2-mode)
                (mode . css-mode)
                (mode . gfm-mode)))
     ("Help" (or (name . "\*Help\*")
                 (name . "\*Apropos\*")
                 (name . "\*info\*"))))))

(add-hook 'ibuffer-mode-hook
          '(lambda ()
             (ibuffer-switch-to-saved-filter-groups "home")))

(setq ibuffer-expert t)

(setq ibuffer-show-empty-filter-groups nil)

(add-hook 'ibuffer-mode-hook
          '(lambda ()
             (ibuffer-auto-mode 1)
             (ibuffer-switch-to-saved-filter-groups "home")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; org - https://emacs.stackexchange.com/a/38443
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Todo keywords. Change these to your liking
(setq org-todo-keywords
      '((sequence "TODO(t)" "NEXT(n)" "WAITING(w)" "|" "DONE(d)" "CANCELLED(c)")))

; clean latex logfiles
(setq org-latex-logfiles-extensions
      (quote ("lof" "lot" "tex~" "aux" "idx" "log" "out" "toc" "nav" "snm" "vrb"
              "dvi" "fdb_latexmk" "blg" "brf" "fls" "entoc" "ps" "spl" "bbl")))

(setq org-agenda-files '("~/Org"))

;; Improve org mode looks
(setq org-startup-indented t
      org-pretty-entities t
      org-hide-emphasis-markers t
      org-startup-with-inline-images t
      org-image-actual-width '(300))

(add-hook 'org-mode-hook (lambda ()
                           (org-superstar-mode 1)))

(setq org-superstar-special-todo-items t)

(define-skeleton org-header-skeleton
  "Header info for an Org file."
  "Title: ""#+TITLE: " str " \n"
  "#+AUTHOR: " user-full-name "\n"
  "#+EMAIL: " user-mail-address "\n"
  "#+DATE: " (format-time-string "%Y-%m-%d") "\n"
  "#+STARTUP: content \n")

(global-set-key [C-S-f1] 'org-header-skeleton)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; dired
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; https://superuser.com/a/566401
(add-hook 'dired-mode-hook 'auto-revert-mode)
(add-hook 'dired-mode-hook 'all-the-icons-dired-mode)
(setq dired-listing-switches "-laXhG --group-directories-first")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; idle highlight - https://stackoverflow.com/a/5816139
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-hook 'prog-mode-hook (lambda () (idle-highlight-mode t)
                                     (setq-local idle-highlight-exclude-point t)))

;;; personal.el ends here
