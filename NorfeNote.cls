% NorfeNote.cls - Custom LaTeX class for note-taking
% Author: [Norfe]
% Date: [2023-8-20]
% Recipe:xelatex -> bibtex -> xelatex*2

% This line specifies the required LaTeX format
\NeedsTeXFormat{LaTeX2e}
% This line specifies the name of the class file
\ProvidesClass{NorfeNote}[2025/11/12 v2.1 Norfe custom note class]

% Declare options for the class
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article,ctexbook}}
\newif\if@isCtexBook\@isCtexBookfalse

% Switch between article and ctexbook based on option
\DeclareOption{ctexbook}{\@isCtexBooktrue}
\ProcessOptions\relax

% Load the appropriate class with specific options
\if@isCtexBook
  \LoadClass[a4paper, 10pt, twoside]{ctexbook}
  \RequirePackage[left=2.5cm, right=2.5cm, top=2.5cm, bottom=2.5cm, twoside]{geometry}
\else
  \LoadClass[a4paper, 10pt, twoside]{ctexart}  % 改为 ctexart
  \RequirePackage[left=1.5cm, right=6.5cm, top=2.5cm, bottom=2.5cm, twoside]{geometry}
\fi

% 设置中文字体与英文字体（Times + 宋体）
% \ctexset{
%     fontset = windowsnew  % 或 auto / fandol / mac / none，根据平台
% }
% \setmainfont{Times New Roman}
% \setCJKmainfont{SimSun}

\linespread{1.2}

\RequirePackage{indentfirst}

\RequirePackage{amsmath}
% \RequirePackage{fontspec}
% \RequirePackage{xeCJK}
\RequirePackage{lipsum}
\RequirePackage{perpage}
\RequirePackage{etoolbox}
\RequirePackage{xcolor}
\RequirePackage{amsthm, amssymb, bm, graphicx, hyperref, mathrsfs, tikz}
\RequirePackage{subfiles}
\RequirePackage{enumerate}
\RequirePackage{subfigure}
\RequirePackage{blindtext}
\RequirePackage{float}
\RequirePackage{ulem}
\RequirePackage{cite}
\RequirePackage{caption}
\RequirePackage{setspace}
\RequirePackage{fancyhdr} % 加载 fancyhdr 宏包

\RequirePackage{changepage}  % 提供 adjustwidth 环境

% ======== 常用数学与算法宏包 ========
\RequirePackage{amsmath, amssymb, bm, mathrsfs}  % 数学支持
\RequirePackage{algorithm}
\RequirePackage{algpseudocode}

% ======== 列表样式与格式 ========
\RequirePackage{enumitem}
\setlist[itemize]{itemsep=1pt, topsep=1pt, parsep=0pt, partopsep=0pt}
\setlist[enumerate]{itemsep=1pt, topsep=1pt, parsep=0pt, partopsep=0pt}


% 修改 \cite 命令为中括号上标引用
\makeatletter
\renewcommand\@cite[2]{\textsuperscript{[#1\if@tempswa , #2\fi]}}
\makeatother

% 加粗宋体的定义：用黑体 SimHei 近似实现
\setCJKfamilyfont{song}{SimSun}       % 定义宋体
\setCJKfamilyfont{boldsong}{SimHei}   % 定义加粗宋体为黑体
\newcommand{\song}[1]{{\CJKfamily{song}#1}}        % 正常宋体
\newcommand{\boldsong}[1]{{\CJKfamily{boldsong}#1}} % 视觉加粗宋体

% Suppress specific LaTeX warnings
\RequirePackage{silence}
\WarningFilter{latex}{There}
\WarningFilter{latex}{Citation}

% Set up caption formatting
\captionsetup{labelformat=default,justification=centering,font={small}}

% Define a command for superscript citations
\newcommand{\upcite}[1]{\textsuperscript{\textsuperscript{\cite{#1}}}}

% Configure hyperlinks
\hypersetup{
    colorlinks=true,
    linkcolor=black,
    citecolor=black,
}

% ======== 颜色定义 ========
\RequirePackage{xcolor}

% 深红、深蓝、深绿、深紫、深黄、深青
\definecolor{deepred}{HTML}{b7282e}
\definecolor{deepblue}{HTML}{313772}
\definecolor{deepgreen}{HTML}{376439}
\definecolor{deeppurple}{HTML}{5d3a9b}
\definecolor{deepyellow}{HTML}{d4a017}
\definecolor{deepcyan}{HTML}{008b8b}

% 快捷命令（可选）
\newcommand{\dr}[1]{\textcolor{deepred}{#1}}
\newcommand{\db}[1]{\textcolor{deepblue}{#1}}
\newcommand{\dg}[1]{\textcolor{deepgreen}{#1}}
\newcommand{\dpu}[1]{\textcolor{deeppurple}{#1}}
\newcommand{\dy}[1]{\textcolor{deepyellow}{#1}}
\newcommand{\dc}[1]{\textcolor{deepcyan}{#1}}


% Set paragraph indentation and length
\parindent=0pt
\setlength{\parindent}{2em}

% % Set main and CJK fonts
% \setmainfont{Times New Roman}
% \setCJKmainfont{SimSun}

% Set marginpar width
\geometry{marginparwidth=5cm}

% Define a counter for side comments
\newcounter{sidecommentcounter}
% Define a command for side comments
\newcommand{\sidecomment}[1]{%
    \stepcounter{sidecommentcounter}%
    \textsuperscript{\Roman{sidecommentcounter}}%
    \marginpar{\raggedright\footnotesize\textbf{\Roman{sidecommentcounter}:} #1}}

% Define a counter for foot comments
\newcounter{footcommentcounter}
% Redefine the format of footnotes
\renewcommand{\thefootnote}{\arabic{footcommentcounter}}
% Define a command for foot comments
\newcommand{\footcomment}[1]{%
    \stepcounter{footcommentcounter}%
    \footnote{#1}}

% Patch the footnote format to include footnote mark
\makeatletter
\patchcmd{\@makefntext}{\ifFN@hangfoot\else}{\ifFN@hangfoot\else\makebox[1em][l]{\textbf{\@thefnmark}:}\fi}{}{}
\makeatother

% Define a counter for definitions
\newcounter{definitioncounter}
% Define a custom environment for definitions
\newenvironment{definition}[1]
    {\par\refstepcounter{definitioncounter}%
    \noindent\textcolor{green!70!black}{\textbf{定义\arabic{definitioncounter}: \textbf{#1}}}\par\noindent}
    {\par}


%  添加目录：定义新命令 \addcontent 
\newcommand{\addcontent}{%
\maketitle
\pagenumbering{roman}
\setcounter{page}{1}
\newpage
\pagenumbering{Roman}
\setcounter{page}{1}
\begin{spacing}{1.2}
    \tableofcontents
\end{spacing}
\newpage
\setcounter{page}{1}
\pagenumbering{arabic}
}



% End the class definition
\endinput
