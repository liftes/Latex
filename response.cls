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
\RequirePackage{mdframed}
\RequirePackage{hyperref}

\definecolor{responseCommentBg}{gray}{0.96}
\definecolor{responseCommentLine}{gray}{0.55}

% ============================================================
% Optional bibliography / hyperlink support
% ============================================================
\ifresponse@withbib
  \RequirePackage{cite}
\fi

\hypersetup{
  colorlinks=true,
  linkcolor=black,
  citecolor=black,
  urlcolor=black,
  bookmarksopen=true,
  bookmarksnumbered=false
}

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
\newcounter{qabookmarkcounter}
% Global counter used only to keep PDF destinations unique.
\newcounter{reviewergroupcounter}
% Per-reviewer counter used for the visible A, B, C outline labels.
\newcounter{reviewergrouplabelcounter}

\newif\ifresponse@ingroup
\response@ingroupfalse

\def\response@grouptitle{}

% Vertical spacing between point-by-point response blocks.
% These lengths may be adjusted in the main document with \setlength.
\newlength{\responseReviewerBeforeSkip}
\newlength{\responseReviewerRuleBeforeSkip}
\newlength{\responseQBeforeSkip}
\newlength{\responseReplyBeforeSkip}
\newlength{\responseReplyAfterSkip}
\setlength{\responseReviewerBeforeSkip}{1.25\baselineskip}
\setlength{\responseReviewerRuleBeforeSkip}{-2.13ex}
\setlength{\responseQBeforeSkip}{0.85\baselineskip}
\setlength{\responseReplyBeforeSkip}{0.15\baselineskip}
\setlength{\responseReplyAfterSkip}{0.40\baselineskip}

\setcounter{reviewercounter}{0}
\setcounter{qacounter}{0}
\setcounter{qabookmarkcounter}{0}
\setcounter{reviewergroupcounter}{0}
\setcounter{reviewergrouplabelcounter}{0}

\newenvironment{reviewersection}{%
  \setcounter{qacounter}{0}%
  \setcounter{reviewergrouplabelcounter}{0}%
  \stepcounter{reviewercounter}%
  \response@ingroupfalse
  \def\response@grouptitle{}%
  \pdfbookmark[0]{Response to Reviewer \thereviewercounter}{reviewer.\thereviewercounter}%
  \par\vspace{\responseReviewerBeforeSkip}%
  \noindent
  {\large\bfseries Response to Reviewer \thereviewercounter\par}%
  \vspace{\responseReviewerRuleBeforeSkip}%
  \noindent\rule{\textwidth}{1pt}\par
}{%
  \response@ingroupfalse
  \def\response@grouptitle{}%
  \par\normalfont
}

% ============================================================
% Reviewer comment group
% Usage:
%   \begin{reviewergroup}{Major Comments}
%     ...
%   \end{reviewergroup}
%
% Optional short title for the PDF outline:
%   \begin{reviewergroup}[General Comments]
%     {There are some points that the authors might want to consider:}
%     ...
%   \end{reviewergroup}
%
% Each group resets the visible Q numbering. Outside this environment,
% qa remains valid and is placed directly below the current reviewer.
% Group letters (A, B, C, ...) appear only in the PDF outline and
% restart for each reviewer; the printed group heading stays unnumbered.
% ============================================================
\newenvironment{reviewergroup}[2][]{%
  \par
  \setcounter{qacounter}{0}%
  \stepcounter{reviewergroupcounter}%
  \stepcounter{reviewergrouplabelcounter}%
  \response@ingrouptrue
  \def\response@grouptitle{#2}%
  \def\response@outlinegrouptitle{#1}%
  \if\relax\detokenize{#1}\relax
    \def\response@outlinegrouptitle{#2}%
  \fi
  \subsection*{#2}%
  \pdfbookmark[1]{\Alph{reviewergrouplabelcounter}. \response@outlinegrouptitle}%
    {reviewergroup.\thereviewergroupcounter}%
}{%
  \par
  \response@ingroupfalse
  \def\response@grouptitle{}%
}

\newenvironment{reply}{%
  \par\vspace{\responseReplyBeforeSkip}%
  \noindent{\normalfont\bfseries Response:}~\normalfont
}{%
  \par\vspace{\responseReplyAfterSkip}%
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
  \par\vspace{\responseQBeforeSkip}%
  \stepcounter{qacounter}%
  \stepcounter{qabookmarkcounter}%
  \ifresponse@ingroup
    \pdfbookmark[2]{Q\theqacounter}{question.\theqabookmarkcounter}%
  \else
    \pdfbookmark[1]{Q\theqacounter}{question.\theqabookmarkcounter}%
  \fi
  \begin{mdframed}[
    backgroundcolor=responseCommentBg,
    linecolor=responseCommentLine,
    linewidth=1.6pt,
    topline=false,
    rightline=false,
    bottomline=false,
    leftline=true,
    leftmargin=0pt,
    rightmargin=0pt,
    innerleftmargin=0.8em,
    innerrightmargin=0.8em,
    innertopmargin=0.45\baselineskip,
    innerbottommargin=0.45\baselineskip,
    skipabove=0pt,
    skipbelow=0.25\baselineskip
  ]%
  \noindent
  \normalfont
  \ifthenelse{\equal{\response@showq}{true}}{%
    \textbf{Q\theqacounter:}~%
  }{}%
}{%
  \end{mdframed}%
  \par\normalfont
}

% ============================================================
% Unnumbered reviewer comment environment
% Usage: opening comments, summaries, or other unnumbered text.
% ============================================================
\newenvironment{reviewercomment}{%
  \par\vspace{0.75\baselineskip}%
  \begin{mdframed}[
    backgroundcolor=responseCommentBg,
    linecolor=responseCommentLine,
    linewidth=1.6pt,
    topline=false,
    rightline=false,
    bottomline=false,
    leftline=true,
    leftmargin=0pt,
    rightmargin=0pt,
    innerleftmargin=0.8em,
    innerrightmargin=0.8em,
    innertopmargin=0.45\baselineskip,
    innerbottommargin=0.45\baselineskip,
    skipabove=0pt,
    skipbelow=0.25\baselineskip
  ]%
  \noindent\normalfont
}{%
  \end{mdframed}%
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
