% ============================================================
% NorfeNote.cls
% Custom LaTeX class for research notes and drafts
%
% Engine   : XeLaTeX
% Encoding : UTF-8
% Recipe   : xelatex -> bibtex -> xelatex*2
%
% Goals:
% 1) Keep all existing macros/features from the old cls.
% 2) Add an optional switch to use sans-serif TEXT fonts only.
%    - Chinese text -> Source Han Sans (思源黑体)
%    - English text -> Arial
%    - Math fonts are NOT changed.
% 3) Be compatible with user's existing typo option: [artical].
% ============================================================

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{NorfeNote}[2025/11/12 v2.3 Norfe custom note class]

% ------------------------------------------------------------
% 0. Options: base-class switches and font switches
% ------------------------------------------------------------

% Internal switches
\newif\if@NorfeCtexBook
\@NorfeCtexBookfalse

\newif\if@NorfeSansText
\@NorfeSansTextfalse

% Compatibility option: user uses [artical] (typo) in \documentclass
% We accept it and do nothing. (No error, no forwarding.)
\DeclareOption{artical}{}

% Switch between ctexbook vs ctexart
\DeclareOption{ctexbook}{\@NorfeCtexBooktrue}

% Enable sans-serif TEXT mode (math untouched)
\DeclareOption{sanstext}{\@NorfeSansTexttrue}

% Forward unknown options to ctexart/ctexbook safely.
% (Do NOT forward to "article" here; we are using ctex base classes.)
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{ctexart}}

\ProcessOptions\relax

% ------------------------------------------------------------
% 1. Base class selection
% ------------------------------------------------------------
\if@NorfeCtexBook
  \LoadClass[a4paper,10pt,twoside]{ctexbook}
\else
  \LoadClass[a4paper,10pt,twoside]{ctexart}
\fi

% ------------------------------------------------------------
% 2. Page layout (same as your old cls)
% ------------------------------------------------------------
\RequirePackage{geometry}
\geometry{
  left=1.5cm,
  right=6.5cm,
  top=2.5cm,
  bottom=2.5cm,
  twoside,
  marginparwidth=5cm
}

% ------------------------------------------------------------
% 3. Font system (TEXT ONLY, keep math untouched)
%    Important:
%    - Do NOT load any math font packages (newtx, unicode-math, etc.)
%    - For CJK bold warnings, provide BoldFont or AutoFakeBold.
% ------------------------------------------------------------
\RequirePackage{fontspec}
\RequirePackage{xeCJK}

% --- Default (serif text) ---
% English: Times New Roman
% Chinese: SimSun, but SimSun has no bold -> bind BoldFont=SimHei to reduce warnings
\def\Norfe@SerifMainEN{Times New Roman}
\def\Norfe@SerifSansEN{Arial}
\def\Norfe@MonoEN{Courier New}

\def\Norfe@SerifMainCN{SimSun}
\def\Norfe@SerifBoldCN{SimHei}

% --- Sans-text mode ---
% English: Arial
% Chinese: SourceHanSansCN (your file name)
% If your system font name is different, you can change it here.
\def\Norfe@SansMainEN{Arial}
\def\Norfe@SansSansEN{Arial}
\def\Norfe@SansMainCN{SourceHanSansCN-Normal.otf}

% Apply selected text fonts
\if@NorfeSansText
  % English text
  \setmainfont{\Norfe@SansMainEN}
  \setsansfont{\Norfe@SansSansEN}
  \setmonofont{\Norfe@MonoEN}

  % Chinese text
  % Use AutoFakeBold to avoid missing bold shapes if only Normal is present.
  \setCJKmainfont{\Norfe@SansMainCN}[
    AutoFakeBold = 2.0,
    AutoFakeSlant = 0.15
  ]
\else
  % English text
  \setmainfont{\Norfe@SerifMainEN}
  \setsansfont{\Norfe@SerifSansEN}
  \setmonofont{\Norfe@MonoEN}

  % Chinese text
  % Bind BoldFont to SimHei to avoid "b/n undefined" warnings as much as possible.
  \setCJKmainfont{\Norfe@SerifMainCN}[
    BoldFont = \Norfe@SerifBoldCN,
    AutoFakeSlant = 0.15
  ]
\fi

% Keep your CJK family shortcuts for compatibility
\setCJKfamilyfont{song}{SimSun}
\setCJKfamilyfont{boldsong}{SimHei}
\newcommand{\song}[1]{{\CJKfamily{song}#1}}
\newcommand{\boldsong}[1]{{\CJKfamily{boldsong}#1}}

% ------------------------------------------------------------
% 4. Basic typography
% ------------------------------------------------------------
\linespread{1.2}
\RequirePackage{indentfirst}
\setlength{\parindent}{2em}

% ------------------------------------------------------------
% 5. Core packages (keep your old features)
% ------------------------------------------------------------
\RequirePackage{amsmath}      % provides \numberwithin
\RequirePackage{amsthm}
\RequirePackage{amssymb}
\RequirePackage{bm}
\RequirePackage{graphicx}
\RequirePackage{hyperref}
\RequirePackage{mathrsfs}
\RequirePackage{tikz}

% NOTE: Keep this! Your main tex uses \subfile
\RequirePackage{subfiles}

\RequirePackage{lipsum}
\RequirePackage{perpage}
\RequirePackage{etoolbox}
\RequirePackage{xcolor}
\RequirePackage{enumerate}
\RequirePackage{subfigure}
\RequirePackage{blindtext}
\RequirePackage{float}
\RequirePackage{ulem}
\RequirePackage{cite}
\RequirePackage{caption}
\RequirePackage{setspace}
\RequirePackage{fancyhdr}
\RequirePackage{changepage}

% Algorithms
\RequirePackage{algorithm}
\RequirePackage{algpseudocode}

% Lists
\RequirePackage{enumitem}
\setlist[itemize]{itemsep=1pt, topsep=1pt, parsep=0pt, partopsep=0pt}
\setlist[enumerate]{itemsep=1pt, topsep=1pt, parsep=0pt, partopsep=0pt}

% ------------------------------------------------------------
% 6. Citation style: superscript [1]
% ------------------------------------------------------------
\makeatletter
\renewcommand\@cite[2]{\textsuperscript{[#1\if@tempswa , #2\fi]}}
\makeatother

\newcommand{\upcite}[1]{\textsuperscript{\cite{#1}}}

% ------------------------------------------------------------
% 7. Silence some warnings (same as your old cls)
% ------------------------------------------------------------
\RequirePackage{silence}
\WarningFilter{latex}{There}
\WarningFilter{latex}{Citation}

% ------------------------------------------------------------
% 8. Captions & hyperlinks
% ------------------------------------------------------------
\captionsetup{labelformat=default,justification=centering,font={small}}

\hypersetup{
  colorlinks=true,
  linkcolor=black,
  citecolor=black
}

% ------------------------------------------------------------
% 9. Color shortcuts (same as your old cls)
% ------------------------------------------------------------
\definecolor{deepred}{HTML}{b7282e}
\definecolor{deepblue}{HTML}{313772}
\definecolor{deepgreen}{HTML}{376439}
\definecolor{deeppurple}{HTML}{5d3a9b}
\definecolor{deepyellow}{HTML}{d4a017}
\definecolor{deepcyan}{HTML}{008b8b}

\newcommand{\dr}[1]{\textcolor{deepred}{#1}}
\newcommand{\db}[1]{\textcolor{deepblue}{#1}}
\newcommand{\dg}[1]{\textcolor{deepgreen}{#1}}
\newcommand{\dpu}[1]{\textcolor{deeppurple}{#1}}
\newcommand{\dy}[1]{\textcolor{deepyellow}{#1}}
\newcommand{\dc}[1]{\textcolor{deepcyan}{#1}}

% ------------------------------------------------------------
% 10. Side comments (margin notes)
% ------------------------------------------------------------
\newcounter{sidecommentcounter}
\newcommand{\sidecomment}[1]{%
  \stepcounter{sidecommentcounter}%
  \textsuperscript{\Roman{sidecommentcounter}}%
  \marginpar{\raggedright\footnotesize\textbf{\Roman{sidecommentcounter}:} #1}%
}
\newcommand{\sidec}[1]{\sidecomment{#1}}

% ------------------------------------------------------------
% 11. Foot comments
% ------------------------------------------------------------
\newcounter{footcommentcounter}
\renewcommand{\thefootnote}{\arabic{footcommentcounter}}
\newcommand{\footcomment}[1]{%
  \stepcounter{footcommentcounter}%
  \footnote{#1}%
}
\newcommand{\footc}[1]{\footcomment{#1}}
\newcommand{\fc}[1]{\footcomment{#1}}

% Patch footnote format (same as old)
\makeatletter
\patchcmd{\@makefntext}{\ifFN@hangfoot\else}{\ifFN@hangfoot\else\makebox[1em][l]{\textbf{\@thefnmark}:}\fi}{}{}
\makeatother

% ------------------------------------------------------------
% 12. Definition environment (same as old)
% ------------------------------------------------------------
\newcounter{definitioncounter}
\newenvironment{definition}[1]
  {\par\refstepcounter{definitioncounter}%
   \noindent\textcolor{green!70!black}{\textbf{定义\arabic{definitioncounter}: \textbf{#1}}}\par\noindent}
  {\par}

% ------------------------------------------------------------
% 13. Front-matter helper: \addcontent (RESTORED)
% ------------------------------------------------------------
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

% ------------------------------------------------------------
% 14. Decorative divider (safe, no TikZ)
%     A centered ornamented line: —— ❖ —— (repeat dots) —— ❖ ——
%     Pure TeX, very robust inside class/macro definitions.
% ------------------------------------------------------------
\newcommand{\NorfeDivider}{%
  \par\vspace{0.8em}%
  \noindent\centerline{%
    \leavevmode
    \hbox to 0.12\textwidth{\hfil\textbullet\hfil}%
    \leaders\hbox{\kern0.25em\hbox{\raise0.25ex\hbox{\tiny$\cdot$}}\kern0.25em}\hfill%
    \hbox{\kern0.6em$\blacklozenge$\kern0.6em}%
    \leaders\hbox{\kern0.25em\hbox{\raise0.25ex\hbox{\tiny$\cdot$}}\kern0.25em}\hfill%
    \hbox to 0.12\textwidth{\hfil\textbullet\hfil}%
  }%
  \vspace{0.8em}\par%
}

% ------------------------------------------------------------
% 15. Front-matter helper (Title + TOC on the SAME page)
%     Page numbering:
%       - Roman  : this combined page (title + toc)
%       - arabic : main text starts from 1 on next page
%
%     Key trick:
%       Temporarily disable \clearpage/\newpage/\cleardoublepage
%       during \tableofcontents to prevent forced page breaks.
% ------------------------------------------------------------
\newcommand{\addcontentTogether}{%
  % ---- Combined title + TOC page ----
  \pagenumbering{Roman}%
  \setcounter{page}{1}%

  \maketitle

  \NorfeDivider

  % TOC without forcing a new page
  \begingroup
    \let\clearpage\relax
    \let\newpage\relax
    \let\cleardoublepage\relax
    % If you don't want an extra centered "目录" title twice,
    % do NOT add \section*{\contentsname} here.
    \begin{spacing}{1.1}
      \tableofcontents
    \end{spacing}
  \endgroup

  % ---- Main text starts next page ----
  \clearpage
  \pagenumbering{arabic}%
  \setcounter{page}{1}%
}


%============================================================
% Custom front-matter:
%   One page: Title + Preface (NO page number)
%   Next page: TOC
%   Then switch to arabic page numbering automatically
%============================================================

\makeatletter

\newcommand{\MakeTitleWithPreface}[1]{%
  % ---------- Front matter numbering ----------
  \pagenumbering{Roman}%
  \setcounter{page}{1}%

  % ---------- Title + Preface page ----------
  \begin{titlepage}
    \thispagestyle{empty}
    \centering

    % ----- Title -----
    {\Huge\bfseries \@title\par}
    \vspace{1.5em}

    {\Large \@author\par}
    \vspace{3em}

    % ----- Divider -----
    \NorfeDivider

    % ----- Preface -----
    {\large\bfseries 序言\par}
    \vspace{1em}

    \begin{minipage}{0.75\textwidth}
      \small
      #1
    \end{minipage}

    \vfill
  \end{titlepage}

  % ---------- TOC page ----------
  \clearpage
  \thispagestyle{plain}
  \tableofcontents

  % ---------- Main matter ----------
  \clearpage
  \pagenumbering{arabic}%
  \setcounter{page}{1}%
}

\makeatother


\endinput
