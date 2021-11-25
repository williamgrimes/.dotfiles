;;; personal.el --- Initialization file for Prelude Emacs

;;; Commentary: Emacs Startup File --- initialization for Emacs

;;; Code:

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; required packages
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(prelude-require-package 'nord-theme)
(prelude-require-package 'dashboard)
(prelude-require-package 'all-the-icons)
(prelude-require-package 'display-line-numbers)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; theme (set in personal/preload/theme.el)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(disable-theme 'zenburn)
(toggle-scroll-bar -1)
(menu-bar-mode -1)
(blink-cursor-mode 1)
; (toggle-truncate-lines -1)

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
;; dashboard
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(dashboard-setup-startup-hook)
(setq dashboard-items '((recents  . 10)
                        (bookmarks . 5)
                        (projects . 5)
                        ;(agenda . 5)
                        (registers . 3)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ibuffer - http://martinowen.net/blog/2010/02/03/tips-for-emacs-ibuffer.html
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq ibuffer-saved-filter-groups
  '(("home"
     ("Clojure" (mode . clojure-mode))
     ("Clojure REPL" (or (mode . cider-repl-mode)
                         (mode . nrepl-messages-mode)
                         (mode . cider-stacktrace-mode)
                         (name . "\*nrepl")))
     ("Data" (or (filename . "csv")
                 (filename . "json$")))
     ("Dired" (mode . dired-mode))
     ("emacs-config" (or (filename . ".emacs.d")
                         (filename . "personal.el")
                         (filename . "emacs-config")))
     ("Images" (or (mode . image-mode)
                   (name . "\*image-dired")))
     ("Magit" (or (name . "\*magit")
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
                (mode . css-mode)))
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

;;; personal.el ends here
