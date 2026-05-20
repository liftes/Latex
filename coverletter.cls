%% coverletter.cls
%% A clean, PRL/APS-style journal cover letter class
%% 2026-01-05

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{coverletter}[2026/01/05 Journal cover letter class]

% -------------------------------------------------
% Base class
% -------------------------------------------------
\LoadClass[11pt]{article}

% -------------------------------------------------
% Page layout
% -------------------------------------------------
\RequirePackage[a4paper,margin=1in]{geometry}
\RequirePackage{setspace}
\RequirePackage{parskip}

\setstretch{1.1}
\pagestyle{empty}

% -------------------------------------------------
% Fonts and encoding
% -------------------------------------------------
\RequirePackage[T1]{fontenc}
\RequirePackage[utf8]{inputenc}
\RequirePackage{lmodern}

% -------------------------------------------------
% Internal storage (with safe defaults)
% -------------------------------------------------
\def\@sendername{}
\def\@senderaffiliation{}
\def\@senderaddress{}
\def\@senderemail{}
\def\@journalname{}
\def\@manuscripttitle{}

% -------------------------------------------------
% User-facing setter commands
% -------------------------------------------------
\newcommand{\sendername}[1]{\gdef\@sendername{#1}}
\newcommand{\senderaffiliation}[1]{\gdef\@senderaffiliation{#1}}
\newcommand{\senderaddress}[1]{\gdef\@senderaddress{#1}}
\newcommand{\senderemail}[1]{\gdef\@senderemail{#1}}

\newcommand{\journalname}[1]{\gdef\@journalname{#1}}
\newcommand{\manuscripttitle}[1]{\gdef\@manuscripttitle{#1}}

% -------------------------------------------------
% User-facing getter commands (THIS IS THE KEY FIX)
% -------------------------------------------------
\newcommand{\printjournalname}{\@journalname}
\newcommand{\printmanuscripttitle}{\@manuscripttitle}

% -------------------------------------------------
% Header
% -------------------------------------------------
\newcommand{\makecoverheader}{
    \noindent
    \@sendername\\
    \@senderaffiliation\\
    \@senderaddress\\
    \texttt{\@senderemail}

    \vspace{1.5em}

    \noindent
    \today

    \vspace{2em}

    \noindent
    Dear Editor,

    \vspace{1em}
}

% -------------------------------------------------
% Footer
% -------------------------------------------------
\newcommand{\makecoverfooter}{
    \vspace{2em}
    \noindent
    Sincerely,\\[1em]
    \@sendername
}

% -------------------------------------------------
% Environment
% -------------------------------------------------
\newenvironment{coverletter}
{
    \makecoverheader
}
{
    \makecoverfooter
}
