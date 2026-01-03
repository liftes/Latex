\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{response}[2025/12/15 Reviewer Outline Class]

% ------------------------------------------------
% Base class
% ------------------------------------------------
\LoadClass[10pt]{article}

% ------------------------------------------------
% Page layout
% ------------------------------------------------
\RequirePackage[a4paper,margin=2.5cm]{geometry}

% ------------------------------------------------
% Line spacing
% ------------------------------------------------
\RequirePackage{setspace}
\onehalfspacing

% ------------------------------------------------
% Chinese / English mixed typesetting
% ------------------------------------------------
\RequirePackage[UTF8]{ctex}

% ------------------------------------------------
% Font: Times New Roman
% ------------------------------------------------
\RequirePackage{fontspec}
\setmainfont{Times New Roman}


% ------------------------------------------------
% Math (optional)
% ------------------------------------------------
\RequirePackage{amsmath,amssymb}

% ------------------------------------------------
% Paragraph formatting
% ------------------------------------------------
\setlength{\parindent}{2em}
\setlength{\parskip}{0pt}

% ------------------------------------------------
% Section format & compact spacing
% ------------------------------------------------
\RequirePackage{titlesec}
\titleformat{\section}
  {\normalfont\bfseries}
  {\thesection.}
  {0.6em}
  {}
\titlespacing*{\section}
  {0pt}{0.75\baselineskip}{0.75\baselineskip}

% ------------------------------------------------
% Question counter
% ------------------------------------------------
\newcounter{question}

% ------------------------------------------------
% Question styles
% ------------------------------------------------
% 1. With "Question:" label
\newcommand{\Question}[1]{%
  \refstepcounter{question}%
  \par\noindent
  \textbf{\thequestion. Question:}~#1\par
}

% 2. Number only, no label
\newcommand{\Q}[1]{%
  \refstepcounter{question}%
  \par\noindent
  \textbf{\thequestion.}~#1\par
}

% ------------------------------------------------
% Issue counter
% ------------------------------------------------
\newcounter{issue}

% ------------------------------------------------
% Issue command
% Usage:
%   \Issue[Short title]{Content}
%   \Issue{Content}
%   \Issue[Short title]{}
%   \Issue{}{}
% ------------------------------------------------
\newcommand{\Issue}[2][]{%
  \refstepcounter{issue}%
  \par\noindent
  \textbf{\theissue.}%
  % ---- short title ----
  \if\relax\detokenize{#1}\relax
    % no short title
  \else
    \textbf{ #1}%
  \fi
  % ---- content ----
  \if\relax\detokenize{#2}\relax
    % no content
  \else
    \ #2%
  \fi
  \par
}
