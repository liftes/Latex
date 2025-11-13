% NorfeArticle.cls - Custom LaTeX class for note-taking
% Author: [Norfe]
% Date: [2023-8-20]
% Recipe:xelatex -> bibtex -> xelatex*2

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{NorfeArticle}

\LoadClass[10pt, a4paper, oneside, twocolumn, UTF8]{ctexart}

\RequirePackage{amsmath, amsthm, amssymb, bm, graphicx, hyperref, mathrsfs, tikz}
\RequirePackage{abstract}
\RequirePackage{subfiles}
\RequirePackage{subfigure}
\RequirePackage[left=1.5cm,right=1.5cm,top=2cm,bottom=2cm]{geometry}
\RequirePackage{blindtext}
\RequirePackage{float}
\RequirePackage{ulem}
\usepackage[sort]{natbib}
\newcommand{\upcite}[1]{\textsuperscript{\textsuperscript{\cite{#1}}}}
\RequirePackage{caption}
\captionsetup{labelformat=default,justification=centering,font={small}}
\RequirePackage{tikz}
\RequirePackage{gbt7714}
\RequirePackage{silence}
\WarningFilter{latex}{There}
\WarningFilter{latex}{Citation}
\usepackage{xcolor}

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
\newcommand{\dp}[1]{\textcolor{deeppurple}{#1}}
\newcommand{\dy}[1]{\textcolor{deepyellow}{#1}}
\newcommand{\dc}[1]{\textcolor{deepcyan}{#1}}


\linespread{1.5} 
\parindent=0pt
\setlength{\parindent}{2em}

\endinput

