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

\linespread{1.5} 
\parindent=0pt
\setlength{\parindent}{2em}

\endinput
