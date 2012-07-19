;; Sucha's emacs settings
;; Time-stamp: <12/07/18 15:46>

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
 '(frame-background-mode dark)
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
 '(default ((t (:stipple nil :background "black" :foreground "gray85" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 123 :width normal :family "courier new"))))
 '(cursor ((t (:background "yellow2" :foreground "black"))) t)
 '(fringe ((((class color) (background dark)) (:background "black" :foreground "gray35"))))
 '(hl-line ((t (:background "grey13"))))
 '(mode-line ((((type x w32 mac) (class color)) (:background "black" :foreground "gray45"))))
 '(mode-line-inactive ((default (:background "black" :foreground "gray33")) (((class color) (min-colors 88) (background dark)) nil)))
 '(region ((((class color) (background dark)) (:background "yellow4"))))
 '(header-line ((default (:inherit mode-line)) (((class color grayscale) (background dark)) (:background "black" :foreground "grey40" :box nil))))
 )

;; 
;; Basic setting
;; 

(add-to-list 'load-path 
             (expand-file-name "~/.elisp/"))    ; my *.el path

(fset 'yes-or-no-p 'y-or-n-p)           ; yes or no == y/n

(add-hook 'before-save-hook
	  'time-stamp)                  ; load time-stamp

(require 'fold)                         ; fold mode instead of folding
;; (if (load "folding" 'nomessage 'noerror)
;;     (folding-mode-add-find-file-hook))  ; folding mode

;; open speedbar in current frame on the right
;; 
(require 'sr-speedbar)


;; icicles-mode
;; 
;; (add-to-list 'load-path
;;              (expand-file-name "~/.elisp/icicles/"))
;; (require 'icicles-mode)

;; unicad, see KNOWN BUGS of unicad
;; 
(require 'unicad)
(add-hook 'ido-kill-emacs-hook
          'unicad-disable)

;; header2 support, auto insert or update file headers
;; 
(require 'header2)
;; (setq header-copyright-notice
;;       (format-time-string "Copyright (c) %Y suchaaa@gmail.com. \n")
;;       user-full-name
;;       " Su Chang (suchaaa@gmail.com)"
;;       header-date-format
;;       "%Y/%m/%d %H:%M")
(setq header-copyright-notice
      (format-time-string "Copyright (c) %Y suchang@star-net.cn. \n")
      user-full-name
      " Su Chang (suchang@star-net.cn)"
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

;;         header-rcs-id
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

;; lua mode
(setq auto-mode-alist (cons '("\\.lua$" . lua-mode) auto-mode-alist))
(autoload 'lua-mode "lua-mode" "Lua editing mode." t)

;; 
;; Global and Common Key biding
;; 

;; notes: window and buffer handling refers to
;;        the relative stuff

(global-set-key [(f1)] (lambda () 
                         (interactive) 
                         (manual-entry (current-word))))
(global-set-key [(f3)] 'sucha-open/close-calendar)

;; highlight-phrase
;;
(global-set-key [(f8)] (lambda () (interactive)
                         (highlight-regexp 
                          (concat "\\b" (current-word) "\\b")
                          'hi-blue)))

(global-set-key [(control f8)] (lambda ()
                                 (interactive)
                                 (hi-lock-mode nil)))

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
(global-set-key [(control f6)]
                'sucha-open-shell-other-buffer)

(defun sucha-open-shell-other-buffer ()
  "Open shell in other buffer"
  (interactive)
  (split-window-vertically)
  (eshell))

(global-set-key "\C-c\C-g" 'goto-line)

;; todo mode
;; 
(global-set-key "\C-ct" 'todo-show)        ; switch to TODO buffer
(global-set-key "\C-ci" 'todo-insert-item) ; insert new item

(define-key text-mode-map "\C-c\i" 'sucha-insert-time-string)
(global-set-key "\M-[" 'backward-paragraph)
(global-set-key "\M-]" 'forward-paragraph)
(global-set-key "\C-c\C-t" 'outline-toggle-children)

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

;; psvn, better svn interfaces
;;(require 'psvn)

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

(sucha-update-global-var)               ; update when loaded
(run-at-time t 10			; repeat every 10s
	     'sucha-update-global-var)

;; mode line format
;; 
(setq default-mode-line-format
      (list "%Z" 
            'mode-line-modified
            " <%b> "
            'sucha-update-time-string
            " (%l,%c,%P) "
            'which-func-format
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
                   (find-file "C:/Documents and Settings/Sucha/YUNIO/wiki/index.org")))

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
(require 'dired-isearch)
(add-hook
 'dired-mode-hook
 (define-key dired-mode-map (kbd "C-s") 'dired-isearch-forward)
 (define-key dired-mode-map (kbd "C-r") 'dired-isearch-backward)
 t)

;;}}}
;;{{{ C/C++ mode stuff

;; 
;; Styles 
;; 

(setq c-default-style "linux")
(setq-default indent-tabs-mode nil
              c-basic-offset 4
              tab-width 4)              ; no tab, only blank
(c-set-offset 'case-label 4)
;; (setq tab-stop-list ())



(require 'ctypes)                       ; ctypes
(ctypes-auto-parse-mode 1)

;; (require 'linum)
;; (setq linum-format "%-4d")

(defvar use-xref-but-gtags t "use xref but gtags")

;; 
;; Relative Faces
;; 

(when (not use-xref-but-gtags)
    (custom-set-faces

     ;; company faces
     ;; 
     '(company-expand-face ((t (:background "black" :foreground "orange2"))))
     '(company-pseudo-tooltip-face ((t (:inherit default :background "black" :foreground "maroon3"))))
     '(company-pseudo-tooltip-selection-face ((t (:background "gray15" :foreground "maroon3"))))
     '(company-tooltip-selection-face ((t (:background "black" :foreground "orange"))))
     '(company-last-expansion-face ((t (:background "black" :foreground "gray85"))))

     ;; xgtags faces
     ;; 
     '(xgtags-file-face ((t (:foreground "salmon3" :weight bold))))
     '(xgtags-match-face ((((class color) (background dark)) (:foreground "green3"))))
     '(xgtags-line-number-face ((((class color) (background dark)) (:foreground "maroon3"))))
     '(xgtags-line-face ((((class color) (background dark)) (:foreground "yellow3"))))
     '(xgtags-file-selected-face ((t (:foreground "salmon3" :weight bold))))
     '(xgtags-match-selected-face ((t (:foreground "green2" :weight bold))))
     '(xgtags-line-selected-face ((t (:foreground "yellow2" :weight bold))))
     '(xgtags-line-number-selected-face ((t (:foreground "maroon2" :weight bold))))
     )
  )

;; 
;; Tag Browsing and Completions settings
;; 

;; tag modes
;; 
(when (not use-xref-but-gtags)
    (require 'xgtags) ; xgtags better face
  ;; (autoload 'gtags-mode "gtags" "" t)     ; gtags
  ;; (require 'xcscope)                      ; xcscope


  ;; company mode, better completion
  ;; 
  (add-to-list 'load-path
               (expand-file-name "~/.elisp/company/"))
  (require 'company-mode)
  (require 'company-bundled-completions) ; mass install
  (require 'company-gtags-completions)

  (defun sucha-install-company-completion-rules ()
    "gtags and dabbref completions for C and C++ mode"
    (company-clear-completion-rules)

    ;;   (company-install-dabbrev-completions)
    (company-install-file-name-completions)
    (eval-after-load 'company-gtags-completions
      '(company-install-gtags-completions))
    )
  )

;; Xrefactory configuration part ;;
;; some Xrefactory defaults can be set here
;;
(when use-xref-but-gtags
  (defvar xref-current-project nil "none")    ;; can be also "my_project_name"
;;  (defvar xref-key-binding 'global)    ;; can be also 'local or 'none
  (defvar xref-key-binding 'none "none") ;; can be also 'local or 'none
  (setq load-path (cons "~/.xrefdir/emacs" load-path))
  (setq exec-path (cons "~/.xrefdir" exec-path))
  (load "xrefactory")
  ;; end of Xrefactory configuration part ;;
  (message "xrefactory loaded")
  (global-set-key (kbd "C-,") (lambda ()
                                  (interactive)
                                  (if (eq last-command 'sucha-xref-lev/find-definition)
                                      (xref-pop-and-return))
                                  (delete-other-windows)))
  )




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
   ;;    (c-toggle-auto-state t)
   (highlight-parentheses-mode t)

   ;; auto make header
   ;; 
   (auto-make-header)

   ;; better tag handle
   ;; 
;;   (define-key c-mode-base-map [return] (lambda () 
;;                                          (interactive)
;;                                          (align-current)
;;                                          (newline)))
   (when (not use-xref-but-gtags)
     (xgtags-mode 1)
;;      (company-mode 1)
;;      (sucha-install-company-completion-rules) ; refers to the function
     ;;    (gtags-mode 1)
     ;;    (company-install-bundled-completions-rules) ; mass rules
     ;;    (require 'ifdef)                     ; mark ifdef color
     ;;    (define-key c-mode-base-map "\C-c\C-i" 'mark-ifdef)
     (define-key c-mode-base-map (kbd "RET") 'newline-and-indent)

     ;; for gtags
     ;; 
     (define-key c-mode-base-map (kbd "C-.") 'xgtags-find-tag-from-here)
     (define-key c-mode-base-map (kbd "C-,") 'delete-other-windows)
     (define-key c-mode-base-map (kbd "M-.") 'xgtags-find-symbol)
     (define-key c-mode-base-map (kbd "M-,") 'xgtags-find-pattern)
     (define-key c-mode-base-map (kbd "C-M-.") 'xgtags-find-rtag)
     (define-key c-mode-base-map (kbd "C-M-,") 'grep-find)
     (define-key c-mode-base-map (kbd "C-M-/") 'xgtags-find-tag)
     (define-key c-mode-base-map (kbd "M-p") 'xgtags-pop-stack)

     ;; c base mode keys
     ;; 
     (define-key c-mode-base-map [f7] 'sucha-generate-gtags-files)
     (define-key c-mode-base-map [C-f7] '(lambda () (interactive)
                                           (when gv-sucha-update-gtags-timer
                                             (message "cancel timer %s" gv-sucha-update-gtags-timer)
                                             (cancel-timer gv-sucha-update-gtags-timer)
                                             (setq gv-sucha-update-gtags-timer nil))))
     (define-key c-mode-base-map [meda .] 'xgtags-find-symbol) ; fix
     (define-key c-mode-base-map (kbd "M-p") 'xgtags-pop-stack)
     )

   ;; hide-ifdef-mode
   ;; 
   ;;    (define-key hide-ifdef-mode-map "\C-z\C-d" 'hide-ifdef-block)
   ;;    (define-key hide-ifdef-mode-map "\C-z\C-s" 'show-ifdef-block)

   ;; xref key bindings
   ;; 
   (when use-xref-but-gtags

     ;; (define-key-after xref-browser-dialog-key-map "p" 'xref-browser-dialog-previous-reference t)
     ;; (define-key-after xref-browser-dialog-key-map "n" 'xref-browser-dialog-next-reference)

     (define-key c-mode-base-map (kbd "M-<return>") 'xref-completion)
     ;;     (define-key c-mode-base-map [(control f8)] 'xref-ide-compile-run)

     (define-key c-mode-base-map (kbd "C-.") 'xref-push-and-goto-definition)
;;      (define-key c-mode-base-map [(control .)] 'sucha-xref-lev/find-definition)

     (define-key c-mode-base-map (kbd "M-.") 'xref-push-and-goto-definition)
     (define-key c-mode-base-map (kbd "M-,") 'sucha-xref-pop-and-delete)

     (define-key c-mode-base-map (kbd "C-M-.") (lambda ()
                                                 (interactive)
                                                 (xref-browse-symbol)
                                                 (other-window 1)
                                                 (shrink-window (- (window-height) 16))))
     (define-key c-mode-base-map (kbd "C-M-,") 'xref-push-name)
     (define-key c-mode-base-map (kbd "C-M-/") 'xref-refactor)

     (define-key c-mode-base-map [(meta j)] (lambda () 
                                              (interactive)
                                              (other-window 1)
                                              (xref-alternative-next-reference)
                                              (other-window 1)))
     (define-key c-mode-base-map [(meta k)] (lambda ()
                                              (interactive)
                                              (other-window 1)
                                              (xref-alternative-previous-reference)
                                              (other-window 1)))

;;      (define-key xref-completion-mode-map [(backtab)] 'previous-line)

     ;;     (define-key c-mode-base-map (kbd "M-p") 'xref-pop-and-return)
     (define-key c-mode-base-map (kbd "M-p") 'sucha-xref-pop-and-delete)

     (define-key c-mode-base-map (kbd "M-s") 'c-indent-new-comment-line) ; indent comments

     (defun sucha-xref-lev/find-definition ()
       "show xref's definition in other small window."
       (interactive)
       (let ((pos (point)))
         (split-window-vertically)
         (other-window 1)
         (shrink-window (- (window-height) 16))
         (xref-push-and-goto-definition)
         (other-window 1)
         (goto-char pos)
         ))

     (defun sucha-xref-pop-and-delete ()
       "pop and delete xref references window."
       (interactive)
       (xref-delete-window)
       (xref-delete-window)
       (xref-pop-and-return))
     )

   ;; global key bindings
   ;; 
   (define-key c-mode-base-map [C-f5] 'sucha-smart-compile)
   (define-key c-mode-base-map [f5] '(lambda () (interactive) 
                                       (compile compile-command)))
   )
 t)

(when (not use-xref-but-gtags)
  
  (defun sucha-update-gtags-files (&optional dir)
    "update gtags files command"
    (let ((current-dir default-directory))
      (if dir
          (cd dir)
        (cd gv-sucha-gtag-dir))
        (shell-command "gtags --gtagslabel gtags")
      (xgtags-make-complete-list)
      (cd current-dir)))

  (defvar gv-sucha-update-gtags-timer nil
    "global timer event to update gtags, invoke by f7, and C-f7
    to cancel it. only valid in cc-mode")

  (defun sucha-generate-gtags-files ()
    "Generate gtags reference file for global."
    (interactive)
    (setq gv-sucha-gtag-dir
          (read-from-minibuffer
           "directory: "
           default-directory))
    (sucha-update-gtags-files gv-sucha-gtag-dir)
    (when (not gv-sucha-update-gtags-timer)
      (setq gv-sucha-update-gtags-timer
            (run-at-time t 30 'sucha-update-gtags-files))
      (message "establish timer %s" gv-sucha-update-gtags-timer)))

;;;   ;; xgtags mode map
;;;   ;; 
;;;   (define-key xgtags-mode-map [(control .)] 'xgtags-find-tag-from-here)
;;;   (define-key xgtags-mode-map [(control ,)] 'delete-other-windows)
;;;   (define-key xgtags-mode-map [(meta .)] 'xgtags-find-symbol)
;;;   (define-key xgtags-mode-map [(meta ,)] 'xgtags-find-pattern)
;;;   (define-key xgtags-mode-map (kbd "C-M-.") 'xgtags-find-rtag)
;;;   (define-key xgtags-mode-map (kbd "C-M-,") 'grep-find)
;;;   (define-key xgtags-mode-map (kbd "C-M-/") 'xgtags-find-tag)
;;;   (define-key xgtags-mode-map (kbd "M-p") 'xgtags-pop-stack)

  ;; xgtags-select-mode-hook
  ;; 
  (add-hook
   'xgtags-select-mode-hook
   '(lambda ()
      (define-key xgtags-select-mode-map [(control f)] 'forward-char)
      (define-key xgtags-select-mode-map [(control b)] 'backward-char)
      (define-key xgtags-select-mode-map [(meta p)] 'xgtags-pop-stack)
      (define-key xgtags-select-mode-map (kbd "SPC")
        'sucha-xgtags-select-tag-other-window))
   )

  ;; company mode map
  ;; 
  (define-key company-mode-map [(tab)] 'indent-for-tab-command)
  (define-key company-mode-map [(meta j)] 'company-cycle)
  (define-key company-mode-map [(meta k)] 'company-cycle-backwards)
  (define-key company-mode-map [(backtab)] 'company-expand-common)
  (define-key company-mode-map (kbd "M-SPC") 'company-expand-anything)
  (define-key company-mode-map (kbd "M-<return>") 'company-expand-common) 

  (defun sucha-xgtags-select-tag-other-window ()
    "Selete gtag tag other window."
    (interactive)
    (xgtags-select-tag-near-point)
    (delete-other-windows)
    (split-window-vertically 12)
    (switch-to-buffer "*xgtags*"))
  )

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

;; company minor mode
;; 
;; (add-to-list 'load-path 
;;              (expand-file-name "~/.elisp/company/"))
;; (require 'company-mode)
;; (require 'company-bundled-completions)


;; 
;; Hooks and Key bindings
;; 

(add-hook
 'emacs-lisp-mode-hook
 (lambda ()

   ;; variables
   ;; 
   (setq tab-always-indent t)           ; always indent
   (highlight-parentheses-mode t)

   ;; company
   ;; 
;;;    (company-clear-completion-rules)     ; clear first
   
;;;    (company-install-lisp-completions)
;;;    (company-install-dabbrev-completions)
;;;    (company-install-file-name-completions)

   ;; misc modes
   ;; 
   (hs-minor-mode t)
   (which-func-mode t)
;;;    (company-mode 1)

   ;; 
   ;; auto make header
   (auto-make-header)
   ))

;; lisp mode shared map
;; 
(define-key lisp-mode-shared-map [(C-f7)] 'sucha-generate-tag-table)
(define-key lisp-mode-shared-map [(f7)] 'visit-tags-table)


;; tag handle
;; 
(define-key lisp-mode-shared-map (kbd "C-.") '(lambda ()
                                                  (interactive)
                                                  (lev/find-tag t)))
(define-key lisp-mode-shared-map (kbd "C-,") 'sucha-release-small-tag-window)

(define-key lisp-mode-shared-map (kbd "M-.") 'lev/find-tag)
(define-key lisp-mode-shared-map (kbd "M-,") 'pop-tag-mark)
(define-key lisp-mode-shared-map (kbd "M-p") 'pop-tag-mark)
(define-key lisp-mode-shared-map (kbd "C-M-/") 'find-tag)
(define-key lisp-mode-shared-map (kbd "C-M-.") 'find-tag-regexp)
(define-key lisp-mode-shared-map (kbd "C-M-,") 'igrep)

(defun sucha-generate-tag-table ()
  "Generate tag tables in certain directory."
  (interactive)
  (with-temp-buffer
    (shell-command
     (concat "find "
	     (read-from-minibuffer "generate tags in: " 
				   default-directory)
	     " -name \""
	     (read-from-minibuffer "suffix: ")
	     "\" | xargs etags "))
    (buffer-name)))

(defun lev/find-tag (&optional show-only)
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

;;}}}
;;{{{ CSS mode

(autoload 'css-mode "css-mode" "Mode for editing CSS files" t)

(setq auto-mode-alist
      (append '(("\\.css$" . css-mode))
              auto-mode-alist))

;;}}}
;;{{{ Dired and Ido


;; active ido mode
;; 
(ido-mode t)


;; dired-single
;; 
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


;;}}}
;;{{{ Frame, Window and Buffer handle

;; for quick swich buffers
;; 
(require 'swbuff)			; better buffer switch


;; for better show, and powerful operation
;; 
(require 'ibuffer)

(define-key ibuffer-mode-map (kbd "C-<return>") 
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
;; (global-set-key "\C-x\C-b" 
;;                 '(lambda () 
;;                    (interactive)
;;                    (list-buffers)
;;                    (other-window 1)))



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

(when (not use-xref-but-gtags)
  (global-set-key (kbd "C-,") 'delete-other-windows))


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

(when (string-equal system-type "windows-nt")

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
;;       ("GuestBook" . "../Guestbook.html")       ;; guestbook
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
      )

     ;; if emacs 24
     ;; 
     ((= 24 current-version)

      (load "fontset-win")
      (huangq-fontset-monaco 13)

      (set-file-name-coding-system 'gbk) ; local coding
      (set buffer-file-coding-system 'utf-8-unix)
;;      (w32-send-sys-command #xf030)     ; maxmize windows
      )))
  )

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

