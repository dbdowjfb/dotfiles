(global-auto-composition-mode t)
(global-company-mode)

(require 'package)
(require 'compat)

(package-initialize)
(add-to-list 'package-archives '("gnu" . "https://elpa.gnu.org/packages/") t) ;; installed by default
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("nongnu" . "https://elpa.nongnu.org/nongnu/") t) ;; installed by default from Emacs 28 onwards
(add-to-list 'package-archives
             (cons "gnu-devel" "https://elpa.gnu.org/devel/")
             t)
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))
(setq browse-url-browser-function 'browse-url-generic browse-url-generic-program "xdg-open")

(quelpa
 '(quelpa-use-package
   :fetcher git
   :url "https://github.com/quelpa/quelpa-use-package.git"))
(require 'quelpa-use-package)




(use-package evil
  :ensure t
  :init
  (evil-mode)
  )

(use-package mathjax)

(require 'mathjax-autoloads)

(add-hook 'eww-mode-hook #'mathjax-shr-setup)


(add-to-list 'evil-emacs-state-modes 'elfeed-search-mode)
(add-to-list 'evil-insert-state-modes 'elfeed-show-mode)

;;; display elfeed entry in other window. switch the article on the entry 
;;; buffer when another article is selected from the search buffer
;;; https://www.reddit.com/r/emacs/comments/hq3r36/elfeed_configuration_to_display_in_next_window/
(use-package elfeed
  :bind (("C-x w" . elfeed)
		 :map  elfeed-search-mode-map
		 ("m" . (lambda () (interactive) (apply 'elfeed-search-toggle-all '(star))))
  ;; :map  elfeed-search-mode-map
  ;("SPC" . (lambda () (elfeed-show-entry)))
  )
  :config
  (setq elfeed-show-entry-switch 'display-buffer)
  (setq elfeed-search-remain-on-entry t))

(setq use-package-always-ensure t)
(eval-when-compile (require 'use-package))




(use-package savehist
  :init
  (savehist-mode))

(unless (package-installed-p 'quelpa)
  (with-temp-buffer
    (url-insert-file-contents "https://raw.githubusercontent.com/quelpa/quelpa/master/quelpa.el")
    (eval-buffer)
    (quelpa-self-upgrade)))


(use-package org-ql
  :quelpa (org-ql :fetcher github :repo "alphapapa/org-ql"
            :files (:defaults (:exclude "helm-org-ql.el"))))



(use-package exec-path-from-shell
  ;; Get environment variables such as $PATH from the shell
  ;; without this auctex doesn't work
  :ensure t
  :config (exec-path-from-shell-initialize))

(use-package gruvbox-theme)

(defun my/latex-mode-hook ()
  (push (list 'output-pdf "Zathura") TeX-view-program-selection))

(use-package auctex
  :ensure t
  :defer t
  :hook (LaTeX-mode . my/latex-mode-hook) 
) 



;(load-theme 'gruvbox t)
(global-display-line-numbers-mode 1)
(recentf-mode)
(run-at-time nil 600 'recentf-save-list)





;; org-mdoe
;;(add-hook 'org-mode-hook 'org-cdlatex-mode)
;;(add-hook 'org-mode-hook 'visual-line-mode)
;; (add-hook 'org-mode-hook 'flyspell-mode )
(setq inhibit-startup-message t)
(setq visible-bell t)



(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)





;; themes and fonts
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")


(defun my-set-margins ()
"Set margins in current buffer."
(setq left-margin-width 1)
(setq right-margin-width 1))

(add-hook 'text-mode-hook 'my-set-margins)

(defun my-toggle-margins ()
"Set margins in current buffer."
(interactive)
(if (or (> left-margin-width 0) (> right-margin-width 0))
(progn
(setq left-margin-width 0)
(setq right-margin-width 0)
(set-window-buffer (selected-window) (current-buffer)))
(setq left-margin-width 100)
(setq right-margin-width 100)
(set-window-buffer (selected-window) (current-buffer))))

(global-set-key [f2] 'my-toggle-margins)
(define-key global-map (kbd "<f2>") 'remember)


(defun insert-date ()
  (interactive)
  (shell-command "date +'%Y-%m-%d '" t)) 

(recentf-mode)

(global-set-key (kbd "<f5>") 'insert-date )


(defun insert-line-after-and-move ()
  ;; simulate the `o` key in Vi
  (interactive)
  (move-end-of-line 1)
  (open-line 1)
  (next-line)
  (indent-according-to-mode)
)

(defun my-org-ql-shuffle-todo ()
  (interactive)
  (org-ql-search (org-agenda-files)
    '(and
      (todo "TODO" "STARTED")
      (not (done))
      (not (scheduled))
      (not (deadline))
      (not (ts-active))
      (not (tags "cooking")))
    :sort 'random))

(defun my-org-ql-shuffle-someday ()
  (interactive)
  (org-ql-search (org-agenda-files)
    '(and
      (todo "SOMEDAY")
      (not (done))
      (not (scheduled))
      (not (deadline))
      (not (ts-active))
      (not (tags "cooking")))
    :sort 'random))




; keymap for insert-line-after-and-move function 
(global-set-key (kbd "M-n") 'insert-line-after-and-move)

(global-set-key (kbd "<f1>") (lambda () (interactive) (find-file "~/.notes")
			       (org-mode)))
(define-key global-map (kbd "<f9> r" )  'remember-region)



(set-face-attribute 'default nil
		    :family "KaTeX_Typewriter"
		    :height 160
		    )

(set-face-attribute 'variable-pitch nil :family "Noto Sans CJK SC")



(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("a75aff58f0d5bbf230e5d1a02169ac2fbf45c930f816f3a21563304d5140d245" "7b8f5bbdc7c316ee62f271acf6bcd0e0b8a272fdffe908f8c920b0ba34871d98" default))
 '(elfeed-feeds '("https://blog.danieljanus.pl/atom.xml"))
 '(package-selected-packages
   '(modus-themes mathjax--installation-directory elfeed markdown-ts-mode magit lsp-mode mathjax cdlatex f org-ql quelpa-use-package aggressive-indent elisp-autofmt yasnippet svgo svg-lib emacs-goodies-el marginalia exec-path-from-shell auctex kana dash pdf-tools company vertico gptel use-package macaulay2 cmake-mode)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(setq Info-default-directory-list
             (append '("~/Downloads")
                     Info-default-directory-list
                    ))

(load-file "~/test.el")

(setq org-format-latex-options (plist-put org-format-latex-options :scale 1.6))

(defun my-setup-color-theme ()
  (interactive)
  (when (display-graphic-p)
    (load-theme (car modus-themes-to-toggle))))

;(use-package modus-themes
;  :quelpa (modus-themes :fetcher github :repo "protesilaos/modus-themes")
;  :init (setq modus-themes-to-toggle '(modus-vivendi-tinted modus-operandi-tinted))
;  :config (my-setup-color-theme))
