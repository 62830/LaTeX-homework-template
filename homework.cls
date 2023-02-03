% adapted from https://github.com/gijs-pennings/latex-homework

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{homework}[2023 LaTeX homework template]

% --------[ OPTIONS ]-----------------------------------------------------------

\newif\if@localnums \@localnumstrue
\newif\if@narrowmargins \@narrowmarginstrue

\LoadClass[12pt]{article}

% --------[ PACKAGES ]----------------------------------------------------------

\RequirePackage[american]{babel}
\RequirePackage{amssymb,amsmath,amsthm} % 引入 AMS 數學環境
\RequirePackage{yhmath}                 % math symbol
\RequirePackage{mathtools}
\RequirePackage{esint}                  % for oiint
\RequirePackage{halloweenmath}          % for oiint
\RequirePackage{titlesec}               % 設定section等的字體
\RequirePackage{titling}                % 加強 title 功能
\RequirePackage{fancyhdr}               % 頁首頁尾
\RequirePackage{ulem}                   % 字加裝飾
\RequirePackage{tabularx}               % 加強版 table
\RequirePackage{enumerate}              % 加強版enumerate
\RequirePackage{tikz}
\RequirePackage{siunitx}
\RequirePackage{minted}
\RequirePackage{algorithm}              % for psuedo code
\RequirePackage{algpseudocode}

\RequirePackage{mleftright}
\mleftright

% --------[ CJK ENV ]-----------------------------------------------------------

\RequirePackage{xeCJK}    % xelatex 中文
\RequirePackage{multicol} % Multi-columned enumeration
\RequirePackage{CJKulem}  % 中文字裝飾
\XeTeXlinebreaklocale "zh"
\XeTeXlinebreakskip = 0pt plus 1pt

% ----------[ FONTS ]-----------------------------------------------------------

\RequirePackage{fontspec}
\setmonofont[Scale=0.9]{Inconsolata}
\setCJKmainfont[AutoFakeSlant=.2,BoldFont={Noto Serif CJK TC SemiBold}]{Noto Serif CJK TC}

\DeclareFontEncoding{LS1}{}{}
\DeclareFontSubstitution{LS1}{stix2}{m}{n}
\DeclareSymbolFont{stix2-operators}{LS1}{stix2}{m}{n}
\DeclareSymbolFont{stix2-symbols3}{LS1}{stix2bb}{m}{n}

% ----------[ PAGE ]------------------------------------------------------------

\RequirePackage[a4paper]{geometry}  % to set margins etc.
\RequirePackage{aliascnt}           % to fix autoref labels for shared counters
\RequirePackage{graphicx}           % to add images and scale text
\RequirePackage{microtype}          % improves typography
\RequirePackage[parfill]{parskip}   % separates paragraphs by white space
\RequirePackage{xurl}               % allows URLs to break (almost) anywhere
\if@narrowmargins
	\geometry{margin=1in}
\fi
% Prevent math from overlapping https://tex.stackexchange.com/a/349882
\lineskip=6pt
\lineskiplimit=18pt

% --------[ PACKAGES: HYPERREF ]------------------------------------------------

% load last: tex.stackexchange.com/q/1863
% .. and even later: mirrors.ctan.org/macros/latex/contrib/hyperref/doc/hyperref-doc.html#x1-540009
\RequirePackage[pdfusetitle]{hyperref}
\RequirePackage[capitalize,nameinlink,noabbrev]{cleveref}
\RequirePackage{ellipsis}           % fixes space after \textellipsis

% renames subsection labels (etc.) to 'section' for \autoref
\addto\extrasamerican{
	\let\subsectionautorefname\sectionautorefname
	\let\subsubsectionautorefname\sectionautorefname
	\let\paragraphautorefname\sectionautorefname
	\let\subparagraphautorefname\sectionautorefname
}

% removes boxes around links and sets Creator field
\hypersetup{
	hidelinks,
	pdfcreator={LaTeX with homework.cls}
}

% removes \, from all text when used for pdf fields (e.g. author)
\pdfstringdefDisableCommands{\def\,{}}

% customizes space between dots to recreate Libertinus's ellipsis
\renewcommand{\ellipsisgap}{.045em}

% --------[ PROBLEMS ]----------------------------------------------------------

\newaliascnt{problem}{section} % so \autoref associates correct name with label
\providecommand{\problemname}{Problem}

\let\problemmark\@gobble
\let\toclevel@problem\toclevel@section % for PDF bookmarks

% disables numbering for problems, for both actual headers and in TOC
\def\l@problem#1#2{\begingroup\let\numberline\@gobble\l@section{#1}{#2}\endgroup} % tex.stackexchange.com/a/62117
\def\@nonumsproblem{}
\def\@seccntformat#1{% www.texfaq.org/FAQ-seccntfmt
	\ifcsname @nonums#1\endcsname\else
		\csname the#1\endcsname\quad% default behavior for other section types, from ltsect.dtx
	\fi
}

\newcommand{\@problemsection}{% copied from article.cls and modified
	\@startsection
	{problem}{1}{\z@}
	{-3.5ex \@plus -1ex \@minus -.2ex}
	{2.3ex \@plus.2ex}
	{\normalfont\Large\bfseries}
}
\newcommand*{\@problem}[1][\@nil]{% tex.stackexchange.com/a/217763
	\def\@arg{#1}
	\begingroup\edef\x{\endgroup% expands problem counter for \nameref: tex.stackexchange.com/a/569405
		\noexpand\@problemsection{
			\problemname{} % note: space
			\ifx\@arg\@nnil\the\numexpr\value{problem}+1\else#1\fi%
		}
	}\x
}
\newcommand{\problem}{\@ifstar{
		\@problem
	}{
		\ifnum\theproblem>0\newpage\fi
		\@problem
}}

\if@localnums
	\counterwithin{equation}{section} % resets equation counter for each section/problem
\fi

% --------[ THEOREMS ]----------------------------------------------------------

\newtheoremstyle{hw-plain}{}{}{\itshape}{}{\bfseries}{ --- }{0pt}{}
\newtheoremstyle{hw-definition}{}{}{}{}{\bfseries}{ --- }{0pt}{}
\newtheoremstyle{hw-remark}{}{}{}{}{\itshape}{ --- }{0pt}{} % unused

\newcommand*{\NewTheorem}[1]{
	\expandafter\providecommand\csname#1autorefname\endcsname{\MakeUppercase{#1}}
	\newaliascnt{#1}{equation}
	\newtheorem{#1}[#1]{\MakeUppercase#1}
	\newtheorem*{#1*}{\MakeUppercase#1}
	\aliascntresetthe{#1} % 1.2 of mirrors.ctan.org/macros/latex/contrib/oberdiek/aliascnt.pdf
}

\theoremstyle{hw-plain}
\NewTheorem{corollary}
\NewTheorem{lemma}
\NewTheorem{theorem}

\theoremstyle{hw-definition}
\NewTheorem{definition}
\NewTheorem{observation}

\theoremstyle{hw-remark}
\NewTheorem{remark}

% --------[ MACROS: DELIMITERS ]------------------------------------------------

% 3.6 of mirrors.ctan.org/macros/latex/contrib/mathtools/mathtools.pdf
% \mid is of type \mathrel, so \; is used. In (script)script style \, is used.
\newcommand{\@renewmid}{\renewcommand{\mid}{%
		\mathclose{}%
		\mathchoice{\;}{\;}{\,}{\,}%
		\delimsize\vert%\allowbreak
		\mathchoice{\;}{\;}{\,}{\,}%
		\mathopen{}%
}}

% tex.stackexchange.com/a/43009
\DeclarePairedDelimiter{\@abs}{\lvert}{\rvert}
\DeclarePairedDelimiter{\@ceil}{\lceil}{\rceil}
\DeclarePairedDelimiter{\@floor}{\lfloor}{\rfloor}
\DeclarePairedDelimiter{\@inner}{\langle}{\rangle} % bad name
\DeclarePairedDelimiter{\@norm}{\lVert}{\rVert}
\DeclarePairedDelimiterX{\@set}[1]{\{}{\}}{\@renewmid#1}
\DeclarePairedDelimiterX{\@Set}[1]{\{}{\}}{\@renewmid\nonscript\,#1\nonscript\,} % \nonscript suppresses \, in (script)script style

\def\abs{\@ifstar{\@abs}{\@abs*}}
\def\ceil{\@ifstar{\@ceil}{\@ceil*}}
\def\floor{\@ifstar{\@floor}{\@floor*}}
\def\inner{\@ifstar{\@inner}{\@inner*}}
\def\norm{\@ifstar{\@norm}{\@norm*}}
\def\set{\@ifstar{\@set}{\@set*}}
\def\Set{\@ifstar{\@Set}{\@Set*}}

% --------[ MAPPINGS ]----------------------------------------------------------

\mathcode`\*="8000
{\catcode`\*\active\gdef*{\cdot}}

\newcommand{\N}{\mathbb N}
\newcommand{\Z}{\mathbb Z}
\newcommand{\Q}{\mathbb Q}
\newcommand{\R}{\mathbb R}
\newcommand{\C}{\mathbb C}
\newcommand{\contra}{\rightarrow\!\leftarrow}

\newcommand*{\numberthis}[1]{\stepcounter{equation}\tag{\theequation}\label{#1}}

% --------[ CODE ]--------------------------------------------------------------

\usemintedstyle{xcode}
\renewcommand{\theFancyVerbLine}{\textcolor{black}{\footnotesize\arabic{FancyVerbLine}}}
\newmintedfile[Code]{c++}{tabsize=2,obeytabs,linenos,frame=single}

%-------------------------------------------------------------------%

\makeatletter %\@title only usable after this
\pagestyle{fancy}
\fancyhf{}
\rhead{\@author}
\lhead{\@title}
\cfoot{\thepage}
