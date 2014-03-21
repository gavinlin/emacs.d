(add-to-list 'load-path "~/.emacs.d/org-mode/lisp" t)


(require 'org)
(require 'org-capture)
(require 'org-install)
(require 'org-latex)

(setq 
	calendar-week-start-day 1
	org-agenda-span 7
	org-agenda-files (quote ("~/workspace/GTD/someday.org" "~/workspace/GTD/newgtd.org"))
	org-agenda-repeating-timestamp-show-all nil
	org-agenda-restore-windows-after-quit t
	org-agenda-show-all-dates t
    org-agenda-skip-deadline-if-done t
	org-agenda-start-on-weekday nil
	org-agenda-window-setup (quote other-window)
	org-fast-tag-selection-single-key nil
	org-log-done (quote (done))
	org-reverse-note-order nil
    org-tags-column 80
	org-tags-match-list-sublevels nil
    org-use-fast-todo-selection t
    org-use-tag-inheritance nil
    org-startup-truncated nil
    capture-annotation-functions '(org-capture-annotation)
    capture-handler-functions '(org-capture-handler)
)

;; map keys
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(define-key global-map "\C-cc" 'org-capture)

(setq org-capture-templates
      '(
        ("t" "Todo" entry (file+headline "~/workspace/GTD/newgtd.org" "Tasks")
             "* TODO %^{Brief Description} %^g\n%?\nAdded: %U")
        ("p" "Private" entry(file+datetree "~/workspace/GTD/privnotes.org")
             "\n* %^{topic} %T \n%i%?\n")
        ("w" "Wordofday" entry(file+datetree "~/workspace/GTD/wotd.org")
             "\n* %^{topic} \n%i%?\n")
        ))


(setq org-agenda-exporter-settings
      '((ps-number-of-columns 1)
        (ps-landscape-mode t)
        (htmlize-output-type 'css)))

(setq org-agenda-custom-commands
'(

("P" "Projects"   
((tags "PROJECT")))

("H" "Office and Home Lists"
     ((agenda)
          (tags-todo "OFFICE")
          (tags-todo "HOME")
          (tags-todo "COMPUTER")
          (tags-todo "DVD")
          (tags-todo "READING")))

("D" "Daily Action List"
     (
          (agenda "" ((org-agenda-ndays 1)
                      (org-agenda-sorting-strategy
                       (quote ((agenda time-up priority-down tag-up) )))
                      (org-deadline-warning-days 0)
                      ))))
)
)


(setq org-emphasis-alist
   (quote (("*" bold "<b>" "</b>")
           ("/" italic "<i>" "</i>")
           ("_" underline "<span style=\"text-decoration:underline;\">" "</span>")
           ("=" org-code "<code>" "</code>" verbatim)
           ("~" org-verbatim "<code>" "</code>" verbatim)
           ("+" (:strike-through t) "<del>" "</del>")
           ("@" org-warning "<b>" "</b>")
           )))
(setq org-export-latex-emphasis-alist
   (quote (("*" "\\textbf{%s}" nil)
           ("/" "\\emph{%s}" nil)
           ("_" "\\underline{%s}" nil)
           ("+" "\\st{%s}" nil)
           ("=" "\\protectedtexttt" t)
           ("~" "\\verb" t)
           ("@" "\\alert{%s}" nil)
           )))


(add-hook 'org-agenda-mode-hook 'hl-line-mode)

;; org latex
(setq org-latex-to-pdf-process
      '("xelatex -interaction=nonstopmode %f" "xelatex -interaction=nonstopmode %f"))

(add-hook 'org-mode-hook
          (lambda ()
            (setq org-export-latex-default-packages-alist
                  (delete '("AUTO" "inputenc" t) org-export-latex-default-packages-alist))
            ))

;; 使用Listings宏包格式化源代码(只是把代码框用listing环境框起来，还需要额外的设置)
(setq org-export-latex-listings t)
;; Options for \lset command（reference to listing Manual)
(setq org-export-latex-listings-options
      '(
        ("basicstyle" "\\color{foreground}\\small\\mono")           ; 源代码字体样式
        ("keywordstyle" "\\color{function}\\bfseries\\small\\mono") ; 关键词字体样式
        ("identifierstyle" "\\color{doc}\\small\\mono")
        ("commentstyle" "\\color{comment}\\small\\itshape")         ; 批注样式
        ("stringstyle" "\\color{string}\\small")                    ; 字符串样式
        ("showstringspaces" "false")                                ; 字符串空格显示
        ("numbers" "left")                                          ; 行号显示
        ("numberstyle" "\\color{preprocess}")                       ; 行号样式
        ("stepnumber" "1")                                          ; 行号递增
        ("backgroundcolor" "\\color{background}")                   ; 代码框背景色
        ("tabsize" "4")                                             ; TAB等效空格数
        ("captionpos" "t")                                          ; 标题位置 top or buttom(t|b)
        ("breaklines" "true")                                       ; 自动断行
        ("breakatwhitespace" "true")                                ; 只在空格分行
        ("showspaces" "false")                                      ; 显示空格
        ("columns" "flexible")                                      ; 列样式
        ("frame" "single")                                          ; 代码框：阴影盒
        ("frameround" "tttt")                                       ; 代码框： 圆角
        ("framesep" "0pt")
        ("framerule" "8pt")
        ("rulecolor" "\\color{background}")
        ("fillcolor" "\\color{white}")
        ("rulesepcolor" "\\color{comdil}")
        ("framexleftmargin" "10mm")
        ))


;; 各种Babel语言支持
(org-babel-do-load-languages
 'org-babel-load-languages
 '((R . t)
   (emacs-lisp . t)
   (matlab . t)
   (C . t)
   (perl . t)
   (sh . t)
   (ditaa . t)
   (python . t)
   (haskell . t)
   (dot . t)
   (latex . t)
   (js . t)
   ))
(setq ps-paper-type 'a4
ps-font-size 16.0
ps-print-header nil
ps-landscape-mode nil)


;; 'my-org-article' for export org documents to the LaTex 'article', using
;; XeTeX and some fancy fonts; requires XeTeX (see org-latex-to-pdf-process)
;;(unless (boundp 'org-export-latex-classes)
;;  (setq org-export-latex-classes nil))
(add-to-list 'org-export-latex-classes
             '("cn-article"
               "\\documentclass[10pt,a4paper]{article}
               \\usepackage{graphicx}
               \\usepackage{xcolor}
               \\usepackage{xeCJK}
               \\usepackage{lmodern}
               \\usepackage{verbatim}
               \\usepackage{fixltx2e}
               \\usepackage{longtable}
               \\usepackage{float}
               \\usepackage{tikz}
               \\usepackage{wrapfig}
               \\usepackage{soul}
               \\usepackage{textcomp}
               \\usepackage{listings}
               \\usepackage{geometry}
               \\usepackage{algorithm}
               \\usepackage{algorithmic}
               \\usepackage{marvosym}
               \\usepackage{wasysym}
               \\usepackage{latexsym}
               \\usepackage{natbib}
               \\usepackage{fancyhdr}
               \\usepackage[xetex,colorlinks=true,
                             linkcolor=blue,
                             urlcolor=blue,
                             menucolor=blue]{hyperref}
               \\usepackage{fontspec,xunicode,xltxtra}
               \\setmainfont{Times New Roman}
               \\newcommand\\fontnamemono{DejaVu Sans YuanTi Mono}
               \\newfontinstance\\MONO{\\fontnamemono}
               \\newcommand{\\mono}[1]{{\\MONO #1}}
               \\setCJKmainfont[Scale=0.9]{DejaVu Sans YuanTi Condensed}
               \\setCJKmonofont[Scale=0.9]{DejaVu Sans YuanTi Mono}
               \\setCJKfamilyfont{mono}{YaHei Consolas Hybrid}
               \\hypersetup{unicode=true}
               \\geometry{a4paper, textwidth=6.5in, textheight=10in,
               marginparsep=7pt, marginparwidth=.6in}
               \\definecolor{foreground}{RGB}{220,220,204}%浅灰
               \\definecolor{background}{RGB}{62,62,62}%浅黑
               \\definecolor{preprocess}{RGB}{250,187,249}%浅紫
               \\definecolor{var}{RGB}{239,224,174}%浅肉色
               \\definecolor{string}{RGB}{154,150,230}%浅紫色
               \\definecolor{type}{RGB}{225,225,116}%浅黄
               \\definecolor{function}{RGB}{140,206,211}%浅天蓝
               \\definecolor{keyword}{RGB}{239,224,174}%浅肉色
               \\definecolor{comment}{RGB}{180,98,4}%深褐色
               \\definecolor{doc}{RGB}{175,215,175}%浅铅绿
               \\definecolor{comdil}{RGB}{111,128,111}%深灰
               \\definecolor{constant}{RGB}{220,162,170}%粉红
               \\definecolor{buildin}{RGB}{127,159,127}%深铅绿
               \\punctstyle{kaiming}
               \\title{}
               \\fancyfoot[C]{\\bfseries\\thepage}
               \\chead{\\MakeUppercase\\sectionmark}
               \\pagestyle{fancy}
               \\tolerance=1000
               [NO-DEFAULT-PACKAGES]
               [NO-PACKAGES]"
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")
               ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

(provide 'init-org)
