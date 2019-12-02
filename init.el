;; init.el -- Emacs configuration

;; INSTALL PACKAGES

(require 'package)

(global-hl-line-mode 1)

(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives
	     '("melpa-stable" . "https://stable.melpa.org/packages/"))
(add-to-list 'package-archives
	     '("gnu" . "https://elpa.gnu.org/packages/"))

(package-initialize)
(eval-when-compile (require 'use-package))

(projectile-global-mode)
(setq projectile-completion-system 'helm)
(helm-projectile-on)
(global-set-key (kbd "C-x C-f") #'helm-find-files)
(require 'lsp-mode)
(add-hook 'prog-mode-hook #'lsp)
(add-to-list 'exec-path "~/src/github/kotlin-language-server/server/build/install/server/bin/")


(setq-default tab-width 4)
(setq-default c-basic-offset 4
			  indent-tabs-mode nil)

(use-package dumb-jump
  :bind (("M-g j" . dumb-jump-go)
		 ("M-g o" . dumb-jump-go-other-window)
		 ("M-g b" . dumb-jump-back))
  :config (setq dump-jump-selector 'helm)
  :ensure)

(use-package multiple-cursors
  :bind (("C->" . mc/mark-next-like-this)
		 ("C-<" . mc/mark-previous-like-this)
		 ("C-c C-<" . mc/mark-all-like-this))
  :ensure)


(setq indent-tabs-mode nil)

(global-auto-revert-mode t)
(setq backup-directory-alist
      `((".*" . "/tmp/emacs")))
(setq auto-save-file-name-transforms
      `((".*" "/tmp/emacs" t)))

(require 'clang-format)
(global-set-key (kbd "C-c i") 'clang-format-region)
(global-set-key (kbd "C-c u") 'clang-format-buffer)
(setq clang-format-style-option "google")

(setq c-default-style "linux"
      c-basic- 4)

(load (expand-file-name "~/quicklisp/slime-helper.el"))
(setq inferior-lisp-program "sbcl")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("f589e634c9ff738341823a5a58fc200341b440611aaa8e0189df85b44533692b" "2a3ffb7775b2fe3643b179f2046493891b0d1153e57ec74bbe69580b951699ca" "a22f40b63f9bc0a69ebc8ba4fbc6b452a4e3f84b80590ba0a92b4ff599e53ad0" "7e78a1030293619094ea6ae80a7579a562068087080e01c2b8b503b27900165c" "75d3dde259ce79660bac8e9e237b55674b910b470f313cdf4b019230d01a982a" "4697a2d4afca3f5ed4fdf5f715e36a6cac5c6154e105f3596b44a4874ae52c45" "6d589ac0e52375d311afaa745205abb6ccb3b21f6ba037104d71111e7e76a3fc" "a3fa4abaf08cc169b61dea8f6df1bbe4123ec1d2afeb01c17e11fdc31fc66379" "6b2636879127bf6124ce541b1b2824800afc49c6ccd65439d6eb987dbf200c36" "d2e9c7e31e574bf38f4b0fb927aaff20c1e5f92f72001102758005e53d77b8c9" "e2fd81495089dc09d14a88f29dfdff7645f213e2c03650ac2dd275de52a513de" "7f89ec3c988c398b88f7304a75ed225eaac64efa8df3638c815acc563dfd3b55" "d1cc05d755d5a21a31bced25bed40f85d8677e69c73ca365628ce8024827c9e3" default)))
 '(package-selected-packages
   (quote
    (nix-mode multiple-cursors gradle-mode flycheck lsp-ui dumb-jump company-lsp lsp-mode helm-projectile kotlin-mode use-package julia-repl julia-shell julia-mode racket-mode protobuf-mode flyspell-correct merlin tuareg cmake-mode fsharp-mode erc-colorize doom-themes elm-mode helm hindent gruvbox-theme racer cyberpunk-theme haskell-mode python-mode evil rust-playground erlang lua-mode color-theme-sanityinc-tomorrow rust-mode column-marker ensime scala-mode auctex auto-complete-c-headers auto-complete-clang go-mode go-autocomplete clang-format ac-anaconda))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(load-theme 'misterioso)

;; BASIC CONFIGURATION
(ac-config-default)
(add-to-list 'load-path "~/src/go")
(add-to-list 'load-path "~/.emacs.d/colors")
(add-to-list 'load-path "~/.emacs.d/protobuf")
(setq linum-format "%4d \u2502 ")
(show-paren-mode 1)
(global-linum-mode t) ;; enable line numbers globally
(setq column-number-mode 1)
(setq hl-line 1)
(set-face-underline-p 'highlight t)
(setq-default fill-column 80)
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(add-hook 'text-mode-hook 'turn-on-auto-fill)
(add-hook 'after-change-major-mode-hook (lambda () (interactive)
					  (column-marker-1 80)))
(add-hook 'after-init-hook 'global-company-mode)


;; Protobuf mode
(require 'protobuf-mode)

;; Tramp
(require 'tramp)
(setq tramp-default-method "ssh")

;; SCALA

;; PYTHON
;;(add-hook 'python-mode-hook 'ac-anaconda-setup)

;; GO
(defun my-go-mode-hook ()
  ; Call Gofmt before saving
  (add-hook 'before-save-hook 'gofmt-before-save)
  )
(add-hook 'go-mode-hook 'my-go-mode-hook)

(defun auto-complete-for-go ()
  (auto-complete-mode 1))
(add-hook 'go-mode-hook 'auto-complete-for-go)

(with-eval-after-load 'go-mode
  (require 'go-autocomplete))

;; C
(defun c-lineup-arglist-tabs-only (ignored)
  "Line up argument lists by tabs, not spaces"
  (let * ((anchor (c-langelem-pos c-syntactic-element))
	  (column (c-langelem-2nd-pos c-syntactic-elment))
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
	      ;; Enable kernel mode for appropriate files
	      (when (and filename
			 (string-match (expand-file-name "~/src/linux-trees")
				       filename))
		(setq indent-tabs-mode t)
		(setq show-trailing-whitespace t)
		(c-set-style "linux-tabs-only")))))

;; LATEX
(setq Tex-auto-save t)
(setq Tex-parse-self t)
(setq-default Tex-master nil)

(add-hook 'LaTeX-mode-hook 'visual-line-mode)
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
;; ## added by OPAM user-setup for emacs / base ## 56ab50dc8996d2bb95e7856a6eddb17b ## you can edit, but keep this line
(require 'opam-user-setup "~/.emacs.d/opam-user-setup.el")
;; ## end of OPAM user-setup addition for emacs / base ## keep this line
