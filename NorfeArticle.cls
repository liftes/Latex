% ============================================================
% NorfeArticle.cls
% Custom LaTeX class for two-column research articles
%
% Engine   : XeLaTeX
% Encoding : UTF-8
% Author   : Norfe
% Version  : v1.1
% Date     : 2025-11-12
%
% Design principles:
% - Two-column article layout (ctexart-based)
% - Optional sans-serif TEXT font switch
% - Chinese & English text configurable
% - Math fonts remain untouched (AMS default)
% ============================================================

% ------------------------------------------------------------
% 1. LaTeX format & class identification
% ------------------------------------------------------------
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{NorfeArticle}[2025/11/12 v1.1 Norfe article class]

% ------------------------------------------------------------
% 2. Class options
% ------------------------------------------------------------

% Internal switch: enable sans-serif text
\newif\if@NorfeSansText
\@NorfeSansTextfalse
\DeclareOption{sanstext}{\@NorfeSansTexttrue}

% Forward any other options to ctexart
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{ctexart}}

\ProcessOptions\relax

% ------------------------------------------------------------
% 3. Load base class (two-column article)
% ------------------------------------------------------------
\LoadClass[
  10pt,
  a4paper,
  oneside,
  twocolumn,
  UTF8
]{ctexart}

% ------------------------------------------------------------
% 4. Page layout
% ------------------------------------------------------------
\RequirePackage[left=1.5cm,right=1.5cm,top=2cm,bottom=2cm]{geometry}

% ------------------------------------------------------------
% 5. Font system (TEXT ONLY)
% ------------------------------------------------------------
% IMPORTANT:
% - We intentionally do NOT change math fonts.
% - No unicode-math, no newtx, no math font packages.

\RequirePackage{fontspec}
\RequirePackage{xeCJK}

% ---- Default (serif text) fonts ----
\def\Norfe@SerifEN{Times New Roman}
\def\Norfe@SansEN{Arial}
\def\Norfe@MonoEN{Courier New}

\def\Norfe@SerifCN{SimSun}
\def\Norfe@SerifCNBold{SimHei}

% ---- Sans-text fonts ----
\def\Norfe@SansMainEN{Arial}
\def\Norfe@SansMainCN{SourceHanSansCN-Normal.otf}

\if@NorfeSansText
  % ===== Sans-serif text mode =====
  \setmainfont{\Norfe@SansMainEN}
  \setsansfont{\Norfe@SansMainEN}
  \setmonofont{\Norfe@MonoEN}

  \setCJKmainfont{\Norfe@SansMainCN}[
    AutoFakeBold = 2.0,
    AutoFakeSlant = 0.15
  ]
\else
  % ===== Default serif text mode =====
  \setmainfont{\Norfe@SerifEN}
  \setsansfont{\Norfe@SansEN}
  \setmonofont{\Norfe@MonoEN}

  \setCJKmainfont{\Norfe@SerifCN}[
    BoldFont = \Norfe@SerifCNBold,
    AutoFakeSlant = 0.15
  ]
\fi

% ------------------------------------------------------------
% 6. Core math & graphics packages
% ------------------------------------------------------------
\RequirePackage{amsmath}
\RequirePackage{amsthm}
\RequirePackage{amssymb}
\RequirePackage{bm}
\RequirePackage{mathrsfs}
\RequirePackage{graphicx}
\RequirePackage{tikz}

% ------------------------------------------------------------
% 7. Structure & utility packages
% ------------------------------------------------------------
\RequirePackage{abstract}
\RequirePackage{subfiles}
\RequirePackage{subfigure}
\RequirePackage{blindtext}
\RequirePackage{float}
\RequirePackage{ulem}

% ------------------------------------------------------------
% 8. Bibliography & citation helpers
% ------------------------------------------------------------
\RequirePackage[sort]{natbib}
\RequirePackage{gbt7714}

\newcommand{\upcite}[1]{\textsuperscript{\cite{#1}}}

% ------------------------------------------------------------
% 9. Captions & hyperlinks
% ------------------------------------------------------------
\RequirePackage{caption}
\captionsetup{
  labelformat=default,
  justification=centering,
  font={small}
}

\RequirePackage{hyperref}
\hypersetup{
  colorlinks=true,
  linkcolor=black,
  citecolor=black
}

% ------------------------------------------------------------
% 10. Colors & shortcuts
% ------------------------------------------------------------
\RequirePackage{xcolor}

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
% 11. Foot-comment system (unchanged logic)
% ------------------------------------------------------------
\newcounter{footcommentcounter}
\renewcommand{\thefootnote}{\arabic{footcommentcounter}}

\newcommand{\footcomment}[1]{%
  \stepcounter{footcommentcounter}%
  \footnote{#1}%
}
\newcommand{\footc}[1]{\footcomment{#1}}
\newcommand{\fc}[1]{\footcomment{#1}}

% ------------------------------------------------------------
% 12. Paragraph & spacing
% ------------------------------------------------------------
\linespread{1.5}
\setlength{\parindent}{2em}

% ------------------------------------------------------------
% 13. Silence harmless warnings
% ------------------------------------------------------------
\RequirePackage{silence}
\WarningFilter{latex}{There}
\WarningFilter{latex}{Citation}

% ------------------------------------------------------------
% End of class
% ------------------------------------------------------------
\endinput
