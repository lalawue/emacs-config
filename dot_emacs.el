;; Sucha's emacs settings
;; Time-stamp: <14/01/05 00:19>

;;{{{ Global Settings

;; 
;; Global Variable
;; 

(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(auto-compression-mode t nil (jka-compr))
 '(auto-image-file-mode t)
 '(auto-save-timeout 30)
 '(browse-url-browser-function (quote w3m-browse-url))
 '(c-default-style "k&r")
 '(case-fold-search t)
 '(column-number-mode t)
 '(confirm-kill-emacs (quote y-or-n-p))
 '(current-language-environment "UTF-8")
 '(default-input-method "rfc1345")
 '(display-time-day-and-date t)
 '(display-time-format "%R %-m/%-d %A")
 '(display-time-interval 60)
 '(display-time-mail-string "mail")
 '(display-time-mode t)
 '(time-stamp-format "%02y/%02m/%02d %02H:%02M")
 '(display-time-use-mail-icon nil)
 '(fill-column 72)
 '(global-font-lock-mode t nil (font-lock))
 '(global-mark-ring-max 35)
 '(kill-ring-max 200)
 '(make-backup-files nil)
 '(mark-ring-max 35)
 '(menu-bar-mode nil)
 '(message-default-charset (quote utf-8))
 '(message-send-mail-function (quote smtpmail-send-it))
 '(mouse-avoidance-mode (quote animate))
 '(require-final-newline nil)
 '(scroll-bar-mode nil)
 '(scroll-conservatively 1000)
 '(scroll-margin 3)
 '(sentence-end-double-space t)
 '(show-paren-mode t)
 '(show-paren-style (quote parenthesis))
 '(speedbar-update-speed nil)
 '(speedbar-use-images nil)
 '(speedbar-verbosity-level 0)
 '(tags-add-tables (quote ask-user))
 '(tags-apropos-verbose t)
 '(tags-case-fold-search nil)
 '(tags-loop-revert-buffers t)
 '(text-mode-hook (quote turn-on-auto-fill))
 '(tool-bar-mode nil)
 '(transient-mark-mode t)
 '(uniquify-buffer-name-style t)
 '(visible-bell t)
 '(safe-local-variable-values (quote ((todo-categories "Todo")))))

;; 
;; Global Faces
;; 

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:stipple nil :background "black" :foreground "gray85" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 155 :width normal :family "courier new"))))
 
 '(default ((t (:stipple nil :background "darkslategrey" :foreground "gray80" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 155 :width normal :family "courier new"))))
 '(cursor ((t (:background "yellow2" :foreground "black"))) t)
 ;; '(fringe ((((class color) (background dark)) (:background "black" :foreground "gray35"))))
 '(fringe ((((class color) (background darkslategrey)) (:background "darkslategrey" :foreground "gray60"))))
 '(hl-line ((t (:background "grey13"))))
 '(mode-line ((((type x w32 mac) (class color)) (:background "black" :foreground "gray45"))))
 ;; '(mode-line-inactive ((default (:background "black" :foreground "gray33")) (((class color) (min-colors 88) (background dark)) nil)))
 '(mode-line-inactive ((default (:background "darkslategrey" :foreground "gray55")) (((class color) (min-colors 88) (background darkslategrey)) nil)))
 '(region ((((class color) (background dark)) (:background "yellow4"))))
 '(header-line ((default (:inherit mode-line)) (((class color grayscale) (background darkslategrey)) (:background "black" :foreground "grey40" :box nil))))
 )

;; 
;; Basic setting
;; 

(setq max-speecpdl-size 10000)
(add-to-list 'load-path 
             (expand-file-name "~/.elisp/"))    ; my *.el path

(fset 'yes-or-no-p 'y-or-n-p)           ; yes or no == y/n

(add-hook 'before-save-hook 'time-stamp) ; load time-stamp

(require 'fold)                         ; fold mode instead of folding
;; (if (load "folding" 'nomessage 'noerror)
;;     (folding-mode-add-find-file-hook))  ; folding mode

;; open speedbar in current frame on the right
;; 
;; (require 'sr-speedbar)

;; popwin
(require 'popwin)
(popwin-mode 1)

;; direx
(require 'direx)
(global-set-key (kbd "C-x C-j") 'direx:jump-to-directory)

(push '(direx:direx-mode :position left :width 30 :dedicated t)
      popwin:special-display-config)
(global-set-key (kbd "C-x C-j") 'direx:jump-to-directory-other-window)

;; unicad, see KNOWN BUGS of unicad
;; 
(require 'unicad)
(add-hook 'ido-kill-emacs-hook 'unicad-disable)

;; header2 support, auto insert or update file headers
;; 
(require 'header2)
(setq header-copyright-notice
      (format-time-string "Copyright (c) %Y chale.suu@gmail.com \n")
      user-full-name
      " lalawue"
      header-date-format
      "%Y/%m/%d %H:%M")

;; header layout
;; 
(setq make-header-hook
      '(header-title
        header-blank

        header-copyright
        header-blank

        header-author
        header-maintainer
        header-blank

        header-creation-date
        header-modification-date
        header-blank

        ;; header-rcs-id
        header-end-line

        header-commentary
        header-blank
        header-blank
        header-end-line

        header-code
        header-eof))

(progn
  (register-file-header-action "[ \t]Last Modified On[ \t]*: "
                               'update-last-modified-date)
  (register-file-header-action "[ \t]Last Modified On[ \t]*: "
                               'update-last-modified-date))
(add-hook 'write-file-hooks 'auto-update-file-header)

;; 
;; Global and Common Key biding
;; 

;; notes: window and buffer handling refers to
;;        the relative stuff

(global-set-key [(f1)] (lambda () 
                         (interactive) 
                         (manual-entry (current-word))))
(global-set-key [(f3)] 'sucha-open/close-calendar)

(defun toggle-frame-fullscreen () 
  (interactive)
  (set-frame-parameter nil 'fullscreen 
                       (if (frame-parameter nil 'fullscreen) nil 'fullscreen)))
;; (global-set-key [(meta f2)] 'ns-toggle-fullscreen) ; v23
(global-set-key [(meta f2)] 'toggle-frame-fullscreen) ; v24

;; highlight-phrase
;;
(global-set-key [(f8)] (lambda () (interactive)
                         (highlight-regexp 
                          (concat "\\b" (current-word) "\\b")
                          'hi-blue)))

(global-set-key [(control f8)] (lambda ()
                                 (interactive)
                                 (hi-lock-mode nil)))

;; call global macro
(global-set-key [(f7)] 'call-last-kbd-macro)

(defun sucha-open/close-calendar ()
  "Auto open/close calendar buffer."
  (interactive)
  (if (not (derived-mode-p
            'calendar-mode))
      (calendar)
    (kill-buffer (buffer-name))
    (other-window -1)
    (delete-other-windows)))

(global-set-key "\M-/" 'hippie-expand)

(setq hippie-expand-try-functions-list
      '( ;;senator-complete-symbol
        try-expand-dabbrev
        try-expand-dabbrev-visible
        try-expand-dabbrev-all-buffers
        try-expand-dabbrev-from-kill
        try-complete-file-name-partially
        try-complete-file-name
        try-expand-all-abbrevs
        try-expand-list
        try-expand-line
        try-complete-lisp-symbol-partially
        try-complete-lisp-symbol))

;; bookmark
;; 
(global-set-key (kbd "C-M-m") 'bookmark-set)
(global-set-key (kbd "C-M-l") 'list-bookmarks)

;; open shell
;; 
(global-set-key [f6] 'eshell)           ; open a shell window
(global-set-key [(control f6)] 'sucha-open-shell-other-buffer)

(defun sucha-open-shell-other-buffer ()
  "Open shell in other buffer"
  (interactive)
  (split-window-vertically)
  (eshell))

(global-set-key "\C-c\C-g" 'goto-line)

;; todo mode
;; 
(define-key text-mode-map "\C-c\i" 'sucha-insert-time-string)
(global-set-key "\C-w" 'clipboard-kill-region)

(defun sucha-insert-time-string ()
  "Insert the date in current position."
  (interactive)
  (insert (format-time-string "[%Y-%m-%d, %a]")))

(defun sucha-local-diary-add-entries  ()
  "Open my local journal file and add entries any time."
  (interactive)
  (let
      ((heading "")
       (dialy "~/doc/home/daily/%s"))

    (setq heading
	  (read-from-minibuffer "entry title: "))
    (find-file
     (format dialy (format-time-string "%Y-%m")))
    (goto-char (point-min))
    (unless (re-search-forward "^# " nil t)
      (insert "# 创建于 "
	      (format-time-string "%04Y年%02m月")
	      "\n\n"))
    (forward-line 1)
    (insert "\n\n\n\n")
    (forward-line -3)
    (insert (concat
	     (format-time-string "%02y/%02m/%2d, ")
	     heading
	     "\n\n"))
    (text-mode)))

;; uniquify-buffer-name-style
;; 
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

;; mode line format
;; 
(defun sucha-update-global-var ()
  "sucha's time string"
  (setq sucha-update-time-string
        (format "%s %s"
                (format-time-string "%R %m/%d")
                (let ((day (string-to-number
                            (format-time-string "%u"))))
                  (cond
                   ((= day 1) "Mon")
                   ((= day 2) "Tue")
                   ((= day 3) "Wen")
                   ((= day 4) "Thi")
                   ((= day 5) "Fri")
                   ((= day 6) "Sat")
                   ((= day 7) "Sun"))))))

(sucha-update-global-var)		    ; update when loaded
(run-at-time t 10 'sucha-update-global-var) ; repeat every 10s

;; mode line format
;; 
(setq default-mode-line-format
      (list "%Z" 
            'mode-line-modified
            " <%b> "
            'sucha-update-time-string
            " (%l,%c,%P) "
            ;; 'which-func-format
            "["
            'which-func-current
            "]"
            'vc-mode
            " %[{" 
            'mode-name
            'minor-mode-alist
            "}%n%] "
            "("
            'default-directory
            ") %-"))

;; header line format
;; 
;; (setq default-header-line-format
;;       (list
;;        " <%b> "
;;        which-func-format
;;        " ("
;;        'default-directory
;;        ")"
;;        ))


(global-unset-key "\C-z")               ; unset C-z to minimize the frame

;; org mode
;; 
(setq auto-mode-alist
      (append '(("\\.org$" . org-mode))
              auto-mode-alist))

(global-set-key [(meta f11)] 
                '(lambda ()
                   (interactive) 
                   (find-file "~/workport/wiki/index.org")))

;; use fuzzy text search
(setq org-link-search-must-match-exact-headline nil)

;; focus parenthesis
;; 
(require 'highlight-parentheses)
(highlight-parentheses-mode t)

;; search kill ring for yank
;; 
(require 'kill-ring-search)

;; dired-isearch only search file-name
;; 
(require 'dired)


;;}}}
;;{{{ System specific setting

;; better grep under linux
;; 
(when (string-equal system-type "gnu/linux")
  (require 'igrep)                        ; better grep
  (require 'igrep-next-error))

;; Font setting under windows
;; 
(when (string-equal system-type "windows-nt")

  ;; "Set defferent font for emacs version."
  ;; 
  (let ((current-version
         (string-to-number 
          (substring (version) 10 12))))
    (cond

     ;; if emacs 22
     ;; 
     ((= 22 current-version)
      (if 
          (not (member 
                '("-*-courier new-normal-r-*-*-16-*-*-*-c-*-fontset-chinese"
                  . "fontset-chinese") fontset-alias-alist))
          (progn
            (create-fontset-from-fontset-spec
             "-*-monaco-normal-r-*-*-14-*-*-*-c-*-fontset-chinese,
              chinese-gbk:-*-ÐÂËÎÌå-normal-r-*-*-14-*-*-*-c-*-gbk*-*,
              chinese-gb2312:-*-ÐÂËÎÌå-normal-r-*-*-16-*-*-*-c-*-gb2312*-*,
              chinese-big5-1:-*-MingLiU-normal-r-*-*-16-*-*-*-c-*-big5*-*,
              chinese-big5-2:-*-MingLiU-normal-r-*-*-16-*-*-*-c-*-big5*-*" t)
            (setq default-frame-alist
                  (append
                   '((font . "fontset-chinese"))
                   default-frame-alist)))))

     ;; if emacs 23
     ;; 
     ((= 23 current-version)
      
      (load "fontset-win")
      (huangq-fontset-monaco 13)

      (set-file-name-coding-system 'gbk) ; local coding
      (set buffer-file-coding-system 'utf-8-unix)
;;      (w32-send-sys-command #xf030)     ; maxmize windows
      )))
  )


(when (eq system-type 'darwin)

  (setq mac-option-modifier 'alt)
  (setq mac-command-modifier 'meta)

  ;; default Latin font (e.g. Consolas)
  ;; (set-face-attribute 'default nil :family "Consolas")
  (set-face-attribute 'default nil :family "Monaco")
  ;; default font size (point * 10)
  ;;
  ;; WARNING!  Depending on the default font,
  ;; if the size is not supported very well, the frame will be clipped
  ;; so that the beginning of the buffer may not be visible correctly. 
  ;; (set-face-attribute 'default nil :height 165)
  (set-face-attribute 'default nil :height 130)
  ;; use specific font for Korean charset.
  ;; if you want to use different font size for specific charset,
  ;; add :size POINT-SIZE in the font-spec.
  (set-fontset-font t 'hangul (font-spec :name "NanumGothicCoding"))
  ;; you may want to add different for other charset in this way.
  )

;;}}}
;;{{{ C/C++ mode stuff

(setq auto-mode-alist (cons '("\\.mm$" . c++-mode) auto-mode-alist))

;; 
;; Styles 
;; 

(setq c-default-style "linux")
(setq-default indent-tabs-mode nil
              c-basic-offset 4
              tab-width 4)              ; no tab, only blank
(c-set-offset 'case-label 4)
;; (setq tab-stop-list ())



;; 
;; Tag Browsing and Completions settings
;; 

;; tag modes
;; 

;; yasnippet
(add-to-list 'load-path "~/.elisp/yasnippet")
(require 'yasnippet)
(setq yas/trigger-key (kbd "C-c <kp-multiply>"))
;;(yas/initialize)

;; This is where your snippets will lie.
(setq yas/root-directory '("~/.emacs.d/snippets"))
;; (mapc 'yas/load-directory yas/root-directory)

;; auto-complete
(add-to-list 'load-path (expand-file-name "~/.elisp/auto-complete"))
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories (expand-file-name "~/.elisp/auto-complete/dict/"))

(setq-default ac-sources '(ac-source-abbrev ac-source-dictionary ac-source-words-in-same-mode-buffers))

(global-auto-complete-mode t)

;; (require 'auto-complete-clang-async)
;; (defun ac-cc-mode-setup ()
;;   (setq ac-clang-complete-executable "/usr/local/Cellar/emacs-clang-complete-async/0.5/bin/clang-complete")
;;   (setq-default ac-sources '(ac-source-abbrev
;;                              ac-source-dictionary
;;                              ac-source-words-in-same-mode-buffers
;;                              ac-source-clang-async))
;;   (ac-clang-launch-completion-process))
;; (defun my-ac-config ()
;;   (add-hook 'c-mode-common-hook 'ac-cc-mode-setup)
;;   (add-hook 'auto-complete-mode-hook 'ac-common-setup)
;;   (global-auto-complete-mode t))
;; (my-ac-config)


;; document viewer
;; (add-to-list 'load-path (expand-file-name "~/.elisp/w3m/"))
;; (add-to-list 'exec-path "/usr/local/bin")
;; (require 'w3m)
;; (require 'w3m-load)


;; (require 'xcode-document-viewer)
;; (setq xcdoc:document-path
;;       "/Users/user/Library/Developer/Shared/Documentation/DocSets/com.apple.adc.documentation.AppleiOS6.1.iOSLibrary.docset/")
;; (setq xcdoc:open-w3m-other-buffer t)

;; (defun xcdoc:docsetutil-command ()
;;  (or (executable-find "docsetutil")
;;      (and (file-executable-p "/Applications/Xcode.app/Contents/Developer/usr/bin/docsetutil")
;;           "/Applications/Xcode.app/Contents/Developer/usr/bin/docsetutil")
;;      (error "docsetutil command is not found. Perhaps you dont have Xcode man.")))


;; jump between source and header file
(defun c-base-mode-in-header-file ()
  (let* ((filename (buffer-file-name))
         (extension (car (last (split-string filename "\\.")))))
    (string= "h" extension)))

(defun c-base-mode-file-jump-to-extension (extension)
  (let* ((filename (buffer-file-name))
         (file-components (append (butlast (split-string filename
                                                         "\\."))
                                  (list extension)))
         (filepath (mapconcat 'identity file-components ".")))
    (if (file-readable-p filepath)
        (find-file filepath)
      nil)))


;;; Assumes that Header and Source file are in same directory
(defun c-base-mode-jump-between-header-source ()
  (interactive)
  (if (c-base-mode-in-header-file)
      (or
       (c-base-mode-file-jump-to-extension "m")
       (c-base-mode-file-jump-to-extension "mm")
       (c-base-mode-file-jump-to-extension "c")
       (c-base-mode-file-jump-to-extension "cc")
       (c-base-mode-file-jump-to-extension "cpp"))
    (c-base-mode-file-jump-to-extension "h")))

(require 'igrep)

;; for Xcode pragma mark, and C/C++ functions
(require 'anything)
(require 'anything-config)

(defvar anything-objc-headline
  '((name . "Objective-C Headline")
    (headline  "^[-+@]\\|^#pragma mark\\|FIXME")
))

(defvar anything-c-headline
  '((name . "C Headline")
    (headline  "^[A-Za-z_]+?[ A-Za-z_0-9\*]+[A-Za-z_0-9]+?(\\|FIXME")
))

(defvar anything-cpp-headline
  '((name . "Cpp Headline")
    (headline  "^[A-Za-z_]+?[ A-Za-z_:~0-9\*]+[A-Za-z_0-9]+?(\\|FIXME")
))

(defvar anything-lua-headline
  '((name . "Lua Headline")
    (headline  "^local \\|^function \\|[A-Za-z]+?[A-Za-z0-9_.] +\{\\|FIXME")
))

(defun major-mode-headline ()
  (interactive)
  ;; Set to 500 so it is displayed even if all methods are not narrowed down.
  (let ((anything-candidate-number-limit 500))
    (cond
     ((eq major-mode 'objc-mode) 
      (anything-other-buffer '(anything-objc-headline)
                             "*ObjC Headline*"))
     ((eq major-mode 'c++-mode)
      (anything-other-buffer '(anything-cpp-headline)
                             "*Cpp Headline*"))
     ((eq major-mode 'c-mode)
      (anything-other-buffer '(anything-c-headline)
                             "*C Headline*"))
     ((eq major-mode 'lua-mode)
      (anything-other-buffer '(anything-lua-headline)
                             "*C Headline*"))
     )))

(defun sucha-mode-auto-pair ()
  (interactive)
  (make-local-variable 'skeleton-pair-alist)
  (setq skeleton-pair-alist  '(
                               (?` ?` _ "''")
                               (?\( _ ")")
                               (?\[ _ "]")
                               (?{ > _ ?} >)))
  (setq skeleton-pair t)
  (local-set-key (kbd "(") 'skeleton-pair-insert-maybe)
  (local-set-key (kbd "{") 'skeleton-pair-insert-maybe)
  (local-set-key (kbd "`") 'skeleton-pair-insert-maybe)
  (local-set-key (kbd "[") 'skeleton-pair-insert-maybe))

;; 
;; Hooks and Key bindings
;; 

(add-hook
 'c-mode-common-hook
 (lambda ()
   ;; variables
   ;; 
   (setq tab-always-indent t)           ; always indent

   ;; better browsing and editing
   ;; 
   ;;    (hs-minor-mode t)
   (hide-ifdef-mode t)
   (which-func-mode t)
   (c-toggle-hungry-state t)
   ;; (c-toggle-auto-state t)
   (highlight-parentheses-mode t)

   ;; auto make header
   ;; 
   (auto-make-header)

   (hs-minor-mode t)

   ;; hide-ifdef-mode
   ;; 
   ;;    (define-key hide-ifdef-mode-map "\C-z\C-d" 'hide-ifdef-block)
   ;;    (define-key hide-ifdef-mode-map "\C-z\C-s" 'show-ifdef-block)

   ;; mode key bindings
   ;; 
   (define-key c-mode-base-map [C-f5] 'sucha-smart-compile)
   (define-key c-mode-base-map [f5] '(lambda () (interactive) 
                                       (compile compile-command)))

   (define-key c-mode-base-map (kbd "M-[") 'c-base-mode-jump-between-header-source)
   (define-key c-mode-base-map (kbd "M-]") 'c-base-mode-jump-between-header-source)

   ;; tags
   (define-key c-mode-base-map (kbd "C-.") 'lev-find-tag)
   (define-key c-mode-base-map (kbd "C-,") 'pop-tag-mark)
   (define-key c-mode-base-map (kbd "M-p") 'pop-tag-mark)
   (define-key c-mode-base-map (kbd "M-n") 'tags-loop-continue)
   (define-key c-mode-base-map (kbd "C-M-/") 'tags-search)
   (define-key c-mode-base-map (kbd "C-M-.") 'find-tag-regexp)
   (define-key c-mode-base-map (kbd "C-M-,") 'igrep)

   (define-key c-mode-base-map (kbd "M-i") 'major-mode-headline)

   ;; (sucha-mode-auto-pair)
   )
 t)

(defun sucha-smart-compile ()
    "Simply compile your file according to the file type."
    (interactive)
    (save-some-buffers t)
    (let
        ((compile-command nil)
         (alist
          (list '("\\.c$" .  "gcc")
                '("\\.cc$" . "g++")
                '("\\.cpp$" . "g++"))))
      (while (not (null alist))
        (if (string-match (caar alist) (buffer-file-name))
            (setq compile-command
                  (concat (cdar alist) " " (buffer-file-name))))
        (setq alist (cdr alist)))

      (if (null compile-command)
          (setq compile-command
                (read-from-minibuffer "Compile command: ")))
      (compile compile-command)))

;;}}}
;;{{{ Emacs-Lisp mode stuff

;; 
;; Hooks and Key bindings
;; 


(defun lev-find-tag (&optional show-only)
  "Show tag in other window with no prompt in minibuf."
  (interactive)
  (let ((default (funcall (or find-tag-default-function
			      (get major-mode 'find-tag-default-function)
			      'find-tag-default))))
    (if show-only
	(progn (find-tag-other-window default)
	       (shrink-window (- (window-height) 16)) ; limited 14 lines
	       (recenter 1)
	       (other-window 1))
      (find-tag default))))

(defun sucha-release-small-tag-window ()
  "Kill other window."
  (interactive)
  (let ((pos (point)))
    (delete-other-windows)
    (ignore-errors
      (pop-tag-mark))
    (goto-char pos))
  (message "Kill other window down, :)"))

(add-hook
 'emacs-lisp-mode-hook
 (lambda ()

   ;; variables
   ;; 
   (setq tab-always-indent t)           ; always indent
   (highlight-parentheses-mode t)

   ;; misc modes
   ;; 
   (hs-minor-mode t)
   (which-func-mode t)

   ;; auto make header
   ;; (auto-make-header)

   ;; tag handle
   ;; 
   (define-key lisp-mode-shared-map [(control .)] '(lambda ()
                                                     (lev-find-tag t)))
   (define-key lisp-mode-shared-map (kbd "C-,") 'sucha-release-small-tag-window)

   (define-key lisp-mode-shared-map [(meta .)] 'lev-find-tag)
   (define-key lisp-mode-shared-map [(meta n)] 'tags-loop-continue)
   (define-key lisp-mode-shared-map (kbd "M-,") 'pop-tag-mark)
   (define-key lisp-mode-shared-map [(meta p)] 'pop-tag-mark)
   (define-key lisp-mode-shared-map (kbd "C-M-/") 'find-tag)
   (define-key lisp-mode-shared-map (kbd "C-M-.") 'find-tag-regexp)
   (define-key lisp-mode-shared-map (kbd "C-M-,") 'igrep)

   ;; (sucha-mode-auto-pair)
   )
 t)


;;}}}
;;{{{ lisp mode
;;(add-to-list 'load-path "~/.emacs.d/slime/")
;;(add-to-list 'load-path "~/.elisp/slime-2013-02-23/")
;;(setq inferior-lisp-program "/usr/local/bin/sbcl")
;;(require 'slime-autoloads)
;;(setq slime-net-coding-system 'utf-8-unix)
;;(slime-setup '(slime-fancy))

;; SLIME & Swank
;; (loadlib "swank")
;; (swank:create-server :port 4006 :style :spawn :dont-close t)
 
;; (loadlib "Your-Project")
;; (Your-Project:start-server)

;;}}}
;;{{{ CSS mode

(autoload 'css-mode "css-mode" "Mode for editing CSS files" t)

(setq auto-mode-alist
      (append '(("\\.css$" . css-mode))
              auto-mode-alist))

;;}}}
;;{{{ Lua mode
;; lua mode
(defadvice lua-electric-match (around last-command-char-fixup activate) 
  (let ((last-command-char last-command-event)) 
    ad-do-it))

(setq auto-mode-alist (cons '("\\.lua$" . lua-mode) auto-mode-alist))
(autoload 'lua-mode "lua-mode" "Lua editing mode." t)

(add-hook
 'lua-mode-hook
 (lambda ()
   (define-key lua-mode-map [(control .)] 'lev-find-tag)
   (define-key lua-mode-map (kbd "C-,") 'sucha-release-small-tag-window)

   (define-key lua-mode-map [(meta .)] 'lev-find-tag)
   (define-key lua-mode-map [(meta n)] 'tags-loop-continue)
   (define-key lua-mode-map (kbd "M-,") 'pop-tag-mark)
   (define-key lua-mode-map [(meta p)] 'pop-tag-mark)
   (define-key lua-mode-map (kbd "C-M-/") 'find-tag)
   (define-key lua-mode-map (kbd "C-M-.") 'find-tag-regexp)
   (define-key lua-mode-map (kbd "C-M-,") 'igrep)

   (define-key lua-mode-map (kbd "M-i") 'major-mode-headline)
   )
 t)
;;}}}
;;{{{ Project and Dir

;; ido and cl
(require 'cl)                           ; ido neead cl?

(require 'ido)				; ido
(ido-mode t)


;; dired-single
(require 'dired-single)

(defun my-dired-init ()
  "Bunch of stuff to run for dired, either immediately or when it's
        loaded."

  ;; <add other stuff here>
  ;; 
  (define-key dired-mode-map [return] 'joc-dired-single-buffer)
  (define-key dired-mode-map [mouse-1] 'joc-dired-single-buffer-mouse)
  (define-key dired-mode-map [(ctrl return)]
    (function
     (lambda nil (interactive) (joc-dired-single-buffer "..")))))

;; if dired's already loaded, then the keymap will be bound
;; 
(if (boundp 'dired-mode-map)

    ;; we're good to go
    ;; just add our bindings
    (my-dired-init)

  ;; it's not loaded yet, so add our bindings to the load-hook
  ;; 
  (add-hook 'dired-load-hook 'my-dired-init))

;; fiplr, find file in project
(require 'fiplr)
(setq fiplr-root-markers '(".git" ".svn"))
(setq fiplr-ignored-globs 
    '((directories (".git" ".svn"))
      (files ("*.jpg" "*.png" "*.zip" "*~"))))
(global-set-key (kbd "C-x f") 'fiplr-find-file)


;;}}}
;;{{{ Frame, Window and Buffer handle

;; for quick swich buffers
;; 
(require 'swbuff)			; better buffer switch


;; for better show, and powerful operation
;; 
(require 'ibuffer)

(define-key ibuffer-mode-map [(control return)] 
  '(lambda () 
     (interactive)
     (ibuffer-visit-buffer)
     (delete-other-windows)))

(define-key ibuffer-mode-map (kbd "C-,")
  '(lambda ()
     (interactive)
     (other-window 1)
     (delete-other-windows)))
(global-set-key "\C-x\C-b" 'ibuffer-other-window)

;; basic buffer list
;; 
(global-set-key "\C-x\C-b" 
                '(lambda () 
                   (interactive)
                   (list-buffers)
                   (other-window 1)))

(add-hook
 'Buffer-menu-mode-hook
 (lambda ()

   (define-key Buffer-menu-mode-map [(control return)]
     '(lambda ()
        (interactive)
        (Buffer-menu-this-window)
        (delete-other-windows)))
   )
 t)

;; cycle buffers
;; 
(global-set-key (kbd "C-;") 'swbuff-switch-to-previous-buffer)
(global-set-key (kbd "C-'") 'swbuff-switch-to-next-buffer)
(global-set-key (kbd "M-'") 'other-window)


;; handle windows size
;; 
(global-set-key [(control -)] 'shrink-window)
(global-set-key [(control =)] (lambda () 
                                (interactive)
                                (shrink-window -1)))

(global-set-key [(control meta -)] 'shrink-window-horizontally)
(global-set-key [(control meta =)] (lambda () (interactive)
                                     (shrink-window-horizontally -1)))

(global-set-key (kbd "C-,") 'delete-other-windows)
(global-set-key (kbd "C-x w") 'delete-window)

;;}}}
;;{{{ My Temp attempt

;;(require 'thumbs)			; thumbs.el

;; maxima
;;
(add-to-list 'load-path
             (expand-file-name "D:/Program Files/Maxima-5.18.1/share/maxima/5.18.1/emacs"))
(autoload 'maxima-mode "maxima" "Maxima mode" t)
(autoload 'maxima "maxima" "Maxima interaction" t)
(setq auto-mode-alist (cons '("\\.max" . maxima-mode) auto-mode-alist))
(if (string-equal system-type "windows-nt")
  (setq maxima-command "D:/Program Files/Maxima-5.18.1/bin/maxima.bat"))

;;}}}
;;{{{ Emacs-Wiki 

(when (or (string-equal system-type "windows-nt")
          (string-equal system-type "darwin"))

  ;;load emacs-wiki 
  ;; 
  (add-to-list 'load-path "~/.elisp/emacs-wiki-2.72")
  (require 'emacs-wiki)
  (require ' htmlize)
  ;; (require 'emacs-wiki-table)
  ;; (require 'emacs-wiki-menu)
  (require 'emacs-wiki-srctag)
  (add-to-list 'emacs-wiki-src-tag-modes-alist
               '("conf" . conf-mode))
  (add-to-list 'emacs-wiki-src-tag-modes-alist
               '("sh" . shell-script-mode))
  (add-to-list 'emacs-wiki-src-tag-modes-alist
               '("xml" . xml-mode))
  (add-to-list 'emacs-wiki-src-tag-modes-alist
               '("scheme" . scheme-mode))

  ;; emacs-wiki-journal
  ;; 
  (add-to-list 'load-path "~/.elisp/emacs-wiki-journal")
  (require 'emacs-wiki-journal)

  ;; setting custom variab
  ;; 
  (custom-set-variables
   '(emacs-wiki-anchor-on-word t)
   '(emacs-wiki-index-page "WikiIndex")
   '(emacs-wiki-journal-description "Lives and essay.")
   '(emacs-wiki-journal-directory "~/workport/homesite/sources/blog")
   '(emacs-wiki-journal-icons-subdirectory "../images")
   '(emacs-wiki-journal-index-title-threshold t)
   '(emacs-wiki-journal-publishing-directory "~/workport/homesite/publish/blog")
   '(emacs-wiki-journal-rss-file-name "~/workport/homesite/publish/blog/rss.xml")
   '(emacs-wiki-journal-rss-about-prefix "http://suchang.net/blog/")
   '(emacs-wiki-journal-rss-link-prefix "http://suchang.net/blog/")
   '(emacs-wiki-journal-self-link-name "Permalink")
   ;;  '(emacs-wiki-journal-time-format "%-m月%-e日 周%a %R")
   ;;  '(emacs-wiki-journal-time-format-category "%-m月%-e日 周%a %R")
   '(emacs-wiki-journal-time-format nil) ; use user define time-format
   '(emacs-wiki-journal-time-format-category nil) ; use user define time-format
   '(emacs-wiki-journal-use-other-window nil)
   '(emacs-wiki-journal-wiki "index")
   '(emacs-wiki-charset-default "utf-8")
   '(emacs-wiki-coding-default (quote utf-8))
   '(emacs-wiki-create-backlinks t)
   '(emacs-wiki-default-page "index")
   '(emacs-wiki-interwiki-names
     (quote
      (("blog" lambda (tag) (emacs-wiki-project-interwiki-link "blog" tag))
       ("cs" lambda (tag) (emacs-wiki-project-interwiki-link "cs" tag))
       ("live" lambda (tag) (emacs-wiki-project-interwiki-link "live" tag))
       ("muse" lambda (tag) (emacs-wiki-project-interwiki-link "muse" tag))
       ("scratch" lambda (tag) (emacs-wiki-project-interwiki-link "scratch" tag))
       ("slack" lambda (tag) (emacs-wiki-project-interwiki-link "slack" tag))
       ("JournalWiki" lambda (tag) (emacs-wiki-project-interwiki-link "JournalWiki" tag))
       ("GnuEmacs" . "http://www.gnu.org/software/emacs/emacs.html")
       ("TheEmacsWiki" lambda (tag)
        (concat "http://www.emacswiki.org/cgi-bin/wiki/" 
                (or tag "SiteMap")))
       ("MeatballWiki" lambda (tag)
        (concat "http://www.usemod.com/cgi-bin/mb.pl?" (or tag "MeatballWiki")))
       ;; Sites
       ;; 
       ("EmacsWikiProject" . "http://mwolson.org/projects/EmacsWikiMode.html") ;; Emacs Wiki
       ("EmacsMuse" . "http://mwolson.org/projects/EmacsMuse.html") ;; Emacs Muse
       ("HFUTBBS" . "http://www.hfutbbs.com")      ;; HFUT BBS
       ("LinuxForum" . "http://www.linuxforum.net/") ;; Linuxforum
       ;; subdirectories
       ;; 
       ("code" . "../code/")                   ;; code directory
       ("doc" . "../doc/")                     ;; doc directory
       ;; personal information
       ;; 
       ("EmailMe" . "mailto: suchaaa@gmail.com") ;; email
       ("GuestBook" . "../Guestbook.html")       ;; guestbook
       )))
   '(emacs-wiki-directories 
     (quote 
      ("~/workport/homesite/sources/blog"
       "~/workport/homesite/sources/cs"
       "~/workport/homesite/sources/live"
       "~/workport/homesite/sources/muse"
       "~/workport/homesite/sources/scratch"
       "~/workport/homesite/sources/slack"))
     nil (emacs-wiki))
   ;; '(emacs-wiki-footer-date-format "")
   '(emacs-wiki-home-page "index")
   '(emacs-wiki-home-project "homesite")
   '(emacs-wiki-maintainer "mailto:suchaaa@gmail.com")
   '(emacs-wiki-markup-nonexistent-link t)
   '(emacs-wiki-mode-hook (quote
                           (;; footnote-mode
                            emacs-wiki-use-font-lock
                            ;; footnote-mode
                            outline-minor-mode)))
   ;; blog, cs, live, muse, scratch, slack
   ;; 
   '(emacs-wiki-projects
     (quote
      (("blog" ;; blog
        (emacs-wiki-directories "~/workport/homesite/sources/blog/")
        (emacs-wiki-project-server-prefix . "../blog/")
        (emacs-wiki-publishing-directory . "~/workport/homesite/publish/blog/")
        (emacs-wiki-home-page . "index")
        (emacs-wiki-index-page . "WikiIndex")
        (emacs-wiki-publishing-header . "<lisp>(sucha-wiki-import-file \"../.blog-header\")</lisp>")
        (emacs-wiki-publishing-footer . "<lisp>(sucha-wiki-import-file \"../.blog-footer\")</lisp>"))
       ("cs" ;; small lab, or computer science
        (emacs-wiki-directories "~/workport/homesite/sources/cs/")
        (emacs-wiki-project-server-prefix . "../cs/")
        (emacs-wiki-publishing-directory . "~/workport/homesite/publish/cs/")
        (emacs-wiki-home-page . "index")
        (emacs-wiki-index-page . "WikiIndex")
        (emacs-wiki-publishing-header . "<lisp>(sucha-wiki-import-file \"../.site-header\")</lisp>")
        (emacs-wiki-publishing-footer . "<lisp>(sucha-wiki-import-file \"../.site-footer\")</lisp>"))
       ("live" ;; about my life
        (emacs-wiki-directories "~/workport/homesite/sources/live/")
        (emacs-wiki-project-server-prefix . "../live/")
        (emacs-wiki-publishing-directory . "~/workport/homesite/publish/live/")
        (emacs-wiki-home-page . "index")
        (emacs-wiki-index-page . "WikiIndex")
        (emacs-wiki-publishing-header . "<lisp>(sucha-wiki-import-file \"../.site-header\")</lisp>")
        (emacs-wiki-publishing-footer . "<lisp>(sucha-wiki-import-file \"../.site-footer\")</lisp>"))
       ("muse" ;; we need musing
        (emacs-wiki-directories "~/workport/homesite/sources/muse/")
        (emacs-wiki-project-server-prefix . "../muse/")
        (emacs-wiki-publishing-directory . "~/workport/homesite/publish/muse/")
        (emacs-wiki-home-page . "index")
        (emacs-wiki-index-page . "WikiIndex")
        (emacs-wiki-publishing-header . "<lisp>(sucha-wiki-import-file \"../.site-header\")</lisp>")
        (emacs-wiki-publishing-footer . "<lisp>(sucha-wiki-import-file \"../.site-footer\")</lisp>"))
       ("scratch" ;; scratch, draft, anything
        (emacs-wiki-directories "~/workport/homesite/sources/scratch/")
        (emacs-wiki-project-server-prefix . "../scratch/")
        (emacs-wiki-publishing-directory . "~/workport/homesite/publish/scratch/")
        (emacs-wiki-home-page . "index")
        (emacs-wiki-index-page . "WikiIndex")
        (emacs-wiki-publishing-header . "<lisp>(sucha-wiki-import-file \"../.site-header\")</lisp>")
        (emacs-wiki-publishing-footer . "<lisp>(sucha-wiki-import-file \"../.site-footer\")</lisp>"))
       ("slack" ;; here is Slackware
        (emacs-wiki-directories "~/workport/homesite/sources/slack/")
        (emacs-wiki-project-server-prefix . "../slack/")
        (emacs-wiki-publishing-directory . "~/workport/homesite/publish/slack/")
        (emacs-wiki-home-page . "index")
        (emacs-wiki-index-page . "WikiIndex")
        (emacs-wiki-publishing-header . "<lisp>(sucha-wiki-import-file \"../.site-header\")</lisp>")
        (emacs-wiki-publishing-footer . "<lisp>(sucha-wiki-import-file \"../.site-footer\")</lisp>"))
       )))
   '(emacs-wiki-publish-url-coding-system (quote utf-8))
   '(emacs-wiki-publishing-directory "~/workport/homesite/publish")
   '(emacs-wiki-publishing-file-prefix "")
   '(emacs-wiki-refresh-file-alist-p t)
   '(emacs-wiki-show-project-name-p t)
   '(emacs-wiki-use-mode-flags t)
   '(emacs-wiki-xhtml-inline-css nil))

  ;; setting custom faces
  ;; 
  (custom-set-faces
   '(emacs-wiki-link-face ((t (:foreground "cyan" :weight bold))))
   '(emacs-wiki-bad-link-face ((t (:foreground "coral" :weight bold))))
   '(emacs-wiki-header-1 ((t (:inherit variable-pitch :weight bold :height 1.9))))
   '(emacs-wiki-header-2 ((t (:inherit variable-pitch :weight bold :height 1.7))))
   '(emacs-wiki-header-3 ((t (:inherit variable-pitch :weight bold :height 1.6))))
   '(emacs-wiki-header-4 ((t (:inherit variable-pitch :slant italic :weight normal :height 1.3))))
   '(emacs-wiki-header-5 ((t (:inherit variable-pitch :slant italic :weight normal :height 1.2))))
   '(emacs-wiki-header-6 ((t (:inherit variable-pitch :slant italic :weight normal :height 1.2)))))

  ;; emacs-wiki auto-publish, added my hack
  ;; 
  (defun sacha-emacs-wiki-auto-publish()
    (when (derived-mode-p 'emacs-wiki-mode)
      (unless emacs-wiki-publishing-p
        (let ((emacs-wiki-publishing-p t)
              (emacs-wiki-after-wiki-publish-hook nil)
              (buffer-file-coding-system 'utf-8-unix))
          (emacs-wiki-journal-publish-this-page)
          ;;(emacs-wiki-publish-index)
          ))))

  (add-hook 'emacs-wiki-mode-hook
            (lambda () (add-hook 'after-save-hook
                                 'sacha-emacs-wiki-auto-publish
                                 nil t)))

  ;; time-format for entries' title and categorys' title
  ;; 
  (defun emacs-wiki-journal-user-definite-time-format ()
    "If emacs-wiki-journal-time-format set to nil, it will 
  display your own time string format in entries."
    (format "%s年%s月%s日 %s %s"
            (string-to-number (format-time-string "%-y"))
            (string-to-number (format-time-string "%-m"))
            (format-time-string "%-e")
            (let
                ((weekday (string-to-number
                           (format-time-string "%u"))))
              (cond 
               ((= weekday 1) (concat "周一"))
               ((= weekday 2) (concat "周二"))
               ((= weekday 3) (concat "周三"))
               ((= weekday 4) (concat "周四"))
               ((= weekday 5) (concat "周五"))
               ((= weekday 6) (concat "周六"))
               ((= weekday 7) (concat "周日"))))
            (format-time-string "%R")))

  (defun emacs-wiki-journal-user-definite-format-category ()
    "If emacs-wiki-journal-time-format-category set to nil, it 
   will display your own time string format in category."
    (format "%s月%s日 %s %s"
            (string-to-number (format-time-string "%-m"))
            (format-time-string "%-e")
            (let
                ((weekday (string-to-number
                           (format-time-string "%u"))))
              (cond 
               ((= weekday 1) (concat "周一"))
               ((= weekday 2) (concat "周二"))
               ((= weekday 3) (concat "周三"))
               ((= weekday 4) (concat "周四"))
               ((= weekday 5) (concat "周五"))
               ((= weekday 6) (concat "周六"))
               ((= weekday 7) (concat "周日"))))
            (format-time-string "%R")))


  ;; import outer template file
  ;; 
  (defun sucha-wiki-import-file (file)
    (if (file-readable-p file)
        (ignore (insert-file-contents file))))

  ;; from ChunYe Wang's Emacs tips
  ;; 
  (defun wcy-wiki-input-special-character ()
    "Use to input special character."
    (interactive)
    (let* ((c (read-char "Character:"))
           (x (emacs-wiki-escape-html-string (string c))))
      (insert x)))

  (define-key emacs-wiki-mode-map (kbd "C-c i") 'wcy-wiki-input-special-character)

  ;; add something to my web blog anytime
  ;; 
  (global-set-key [(C-f12)] 'emacs-wiki-journal-add-entry)

  ;; find wiki files
  ;; 
  (defun sucha-wiki-find-file ()
    "Find the wiki file in wiki directorys"
    (interactive)
    (find-file (file-name-directory "~/workport/homesite/sources/")))

  (global-set-key [(M-f12)] 'sucha-wiki-find-file)

  )                                     ; windows-nt-special-setting
;;}}}
;;{{{ Desktop and Session

;; record the open file history and defines the relative topic files
;; 
;;(require 'history)
;;(setq history-file "~/.emacs.d/_emacs-history.el")
;;(setq project-file "~/.emacs.d/_emacs-projects.el")

;; record the last working files
;; 
(require 'session)
(add-hook 'after-init-hook 'session-initialize)
(setq session-save-file "~/.emacs.d/_session")
(add-hook 'session-before-save-hook 'unicad-disable) ; do not care session's coding

(setq desktop-base-file-name "~/.emacs.d/_emacs_desktop")
(desktop-save-mode 1)

;;}}}

;; Sucha's dot_emacs ends here
