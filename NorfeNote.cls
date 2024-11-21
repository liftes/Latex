% NorfeNote.cls - Custom LaTeX class for note-taking
% Author: [Norfe]
% Date: [2023-8-20]
% Recipe:xelatex -> bibtex -> xelatex*2

% This line specifies the required LaTeX format
\NeedsTeXFormat{LaTeX2e}
% This line specifies the name of the class file
\ProvidesClass{NorfeNote}

% Declare options for the class
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article,ctexbook}}
\newif\if@isCtexBook\@isCtexBookfalse

% Switch between article and ctexbook based on option
\DeclareOption{ctexbook}{\@isCtexBooktrue}
\ProcessOptions\relax

% Load the appropriate class with specific options
\if@isCtexBook
  \LoadClass[a4paper, 12pt, twoside]{ctexbook}
  \RequirePackage[left=2.5cm, right=2.5cm, top=2.5cm, bottom=2.5cm, twoside]{geometry}
\else
  \LoadClass[a4paper, 12pt, twoside]{article}
  \RequirePackage[left=1.5cm, right=6.5cm, top=2.5cm, bottom=2.5cm, twoside]{geometry}
\fi

\linespread{1.2}

\RequirePackage{indentfirst}

\RequirePackage{amsmath}
\RequirePackage{fontspec}
\RequirePackage{xeCJK}
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
\usepackage{xcolor}

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


% Set paragraph indentation and length
\parindent=0pt
\setlength{\parindent}{2em}

% Set main and CJK fonts
\setmainfont{Times New Roman}
\setCJKmainfont{SimSun}

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
