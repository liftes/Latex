\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{response}[2026/06/02 Reviewer response class]

% ============================================================
% Class-internal commands
% ============================================================
\makeatletter

% ============================================================
% Options
% ============================================================
\newif\ifresponse@chinese
\response@chinesefalse

\newif\ifresponse@withbib
\response@withbibfalse

\DeclareOption{ch}{\response@chinesetrue}
\DeclareOption{en}{\response@chinesefalse}
\DeclareOption{withbib}{\response@withbibtrue}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{ctexart}}
\ProcessOptions\relax

% ============================================================
% Base class
% ============================================================
\LoadClass[zihao=-4,a4paper,UTF8]{ctexart}

% ============================================================
% Page layout and spacing
% ============================================================
\RequirePackage[left=2.5cm,right=2.5cm,top=3cm,bottom=3cm]{geometry}
\RequirePackage{setspace}
\onehalfspacing

\setlength{\parindent}{2em}
\setlength{\parskip}{0pt}

% ============================================================
% Basic packages
% ============================================================
\RequirePackage{amsmath}
\RequirePackage{amsthm}
\RequirePackage{amssymb}
\RequirePackage{bm}
\RequirePackage{graphicx}
\RequirePackage{mathrsfs}
\RequirePackage{tikz}
\RequirePackage[normalem]{ulem}
\RequirePackage{xcolor}
\RequirePackage{caption}
\RequirePackage{keyval}
\RequirePackage{ifthen}
\RequirePackage{fancyhdr}
\RequirePackage{titlesec}

% ============================================================
% Optional bibliography / hyperlink support
% ============================================================
\ifresponse@withbib
  \RequirePackage{hyperref}
  \RequirePackage{cite}
  \hypersetup{
    colorlinks=true,
    linkcolor=black,
    citecolor=black,
    urlcolor=black
  }
\fi

% ============================================================
% Font settings
% ============================================================
% Recommended compiler: XeLaTeX.
\RequirePackage{fontspec}
\setmainfont{Times New Roman}

% Times-like math font
\RequirePackage{newtxmath}

\renewcommand{\sfdefault}{phv}
\renewcommand{\ttdefault}{pcr}

% ============================================================
% Title
% ============================================================
\renewcommand{\maketitle}{%
  \begin{center}%
    {\LARGE \@title \par}%
  \end{center}%
  \vspace{1ex}%
}

% ============================================================
% Section formatting
% ============================================================
\titleformat{\section}
  {\normalfont\Large\bfseries}
  {}
  {0pt}
  {}

\titlespacing*{\section}
  {0pt}
  {0.75\baselineskip}
  {0.75\baselineskip}

\titleformat{\subsection}
  {\normalfont\large\bfseries}
  {}
  {0pt}
  {}

\titlespacing*{\subsection}
  {0pt}
  {0.6\baselineskip}
  {0.4\baselineskip}

% Keep indentation after section titles.
\let\@afterindentfalse\@afterindenttrue
\@afterindenttrue

% ============================================================
% Figure, table, and equation numbering
% ============================================================
\renewcommand{\thefigure}{Re:\arabic{figure}}
\renewcommand{\thetable}{Re:\arabic{table}}
\renewcommand{\theequation}{Re:\arabic{equation}}

\ifresponse@chinese
  \captionsetup[figure]{name={图}}
  \captionsetup[table]{name={表}}
\else
  \captionsetup[figure]{name={Fig.}}
  \captionsetup[table]{name={Table}}
\fi

% ============================================================
% Page style
% ============================================================
\fancypagestyle{plain}{%
  \fancyhf{}%
  \fancyfoot[C]{\thepage}%
  \renewcommand{\headrulewidth}{0pt}%
  \renewcommand{\footrulewidth}{0pt}%
}
\pagestyle{plain}

% ============================================================
% Reviewer / QA / Reply environments
% ============================================================
\newcounter{reviewercounter}
\newcounter{qacounter}

\setcounter{reviewercounter}{0}
\setcounter{qacounter}{0}

\newenvironment{reviewersection}{%
  \setcounter{qacounter}{0}%
  \stepcounter{reviewercounter}%
  \par\vspace{1ex}%
  \noindent
  {\large\bfseries Reviewer \thereviewercounter\ (Reviewer Comments to Author)\par}%
  \vspace{-1ex}%
  \noindent\rule{\textwidth}{1pt}\par
  \itshape
}{%
  \par\normalfont
}

\newenvironment{reply}{%
  \par\noindent{\normalfont\bfseries Reply:}~\normalfont
}{%
  \par
}

% ============================================================
% QA environment
% Usage:
%   \begin{qa}
%     ...
%   \end{qa}
%
%   \begin{qa}[showq=false]
%     ...
%   \end{qa}
% ============================================================
\define@key{responseqakeys}{showq}[true]{%
  \def\response@showq{#1}%
}

\newcommand{\responsesetupqa}[1][]{%
  \def\response@showq{true}%
  \setkeys{responseqakeys}{#1}%
}

\newenvironment{qa}[1][]{%
  \responsesetupqa[#1]%
  \par
  \stepcounter{qacounter}%
  \noindent
  \itshape
  \ifthenelse{\equal{\response@showq}{true}}{Q\theqacounter:~}{}%
}{%
  \par\normalfont
}

% ============================================================
% Additional outline commands
% ============================================================
\newcounter{question}
\newcounter{issue}

\newcommand{\Question}[1]{%
  \refstepcounter{question}%
  \par\noindent
  \textbf{\thequestion. Question:}~#1\par
}

\newcommand{\Q}[1]{%
  \refstepcounter{question}%
  \par\noindent
  \textbf{\thequestion.}~#1\par
}

\newcommand{\Issue}[2][]{%
  \refstepcounter{issue}%
  \par\noindent
  \textbf{\theissue.}%
  \if\relax\detokenize{#1}\relax
  \else
    \textbf{ #1}%
  \fi
  \if\relax\detokenize{#2}\relax
  \else
    \ #2%
  \fi
  \par
}

% ============================================================
% Citation helper
% ============================================================
\newcommand{\upcite}[1]{\textsuperscript{\cite{#1}}}

% ============================================================
% End class-internal commands
% ============================================================
\makeatother

\endinput