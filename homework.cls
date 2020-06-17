\NeedsTeXFormat{LaTeX2e}
\LoadClassWithOptions{article}
\ProvidesClass{homework}

\newcommand\@opanon{0}
\DeclareOption{anonymous}{\renewcommand\@opanon{1}}
\newcommand\@opnewpage{0}
\DeclareOption{newpage}{\renewcommand\@opnewpage{1}}
\newcommand\@oplargemargins{0}
\DeclareOption{largemargins}{\renewcommand\@oplargemargins{1}}
\ProcessOptions

% ----- Pakete --------------------------------------------------------------

% Mehr Schriftzeichen, Akzente etc.
\RequirePackage[T1]{fontenc}

% Befehle mit Stern
\RequirePackage{suffix}

% Mathe
\RequirePackage{amsmath}
\RequirePackage{amsfonts}
\RequirePackage{amsthm}
\RequirePackage{amssymb}
\RequirePackage{centernot}

% Listen
\RequirePackage{enumerate}
\RequirePackage{enumitem}

% Bilder, Diagramme, Code
\RequirePackage{graphicx}
\RequirePackage{grffile}
\RequirePackage[all]{xy}
\RequirePackage{wrapfig}
\RequirePackage{fancyvrb}
\RequirePackage{listings}

% Conditionals
\RequirePackage{ifthen}

% Header & Seite
\RequirePackage{fancyhdr}
\ifthenelse{\equal{\@oplargemargins}{1}}{}{\RequirePackage{fullpage}}

% Links
\RequirePackage{hyperref}

% ----- Frage -------------------------------------------------------------
\newcounter{questionCounter}
\newcounter{partCounter}[questionCounter]

% Präfix für Fragen
\newcommand{\questiontype}[0]{Frage}

% Für Seiten/Abschnitt-Angaben
\newcommand{\writtensection}[0]{0}

% Nummerierte Fragen
\providecommand{\question}{}
\renewcommand{\question}[0]{%
  % \newpage wenn Option `newpage`
  \ifthenelse{\equal{\@opnewpage}{1}}{%
    \newpage
  }{}

  % Miniseite um Zeilenbrüche zu vermeiden
  \begin{minipage}{\linewidth}%
    \stepcounter{questionCounter}%
      \vspace{.2in}%
      \ifx\writtensection\undefined{}
        \noindent{\bf \questiontype\ \arabic{questionCounter}.}%
        \else
          \ifnum\writtensection=0
          \noindent{\bf \questiontype\ \arabic{questionCounter}.}%
          \else
          \noindent{\bf \questiontype\ \writtensection.\arabic{questionCounter}}%
        \fi
      \vspace{0.3em} \hrule \vspace{.1in}%
  \end{minipage}
}

% Benannte Frage, ein Argument
\WithSuffix\providecommand\question*{}
\WithSuffix\renewcommand\question*[1]{%
  % \newpage wenn Option `newpage`
  \ifthenelse{\equal{\@opnewpage}{1}}{%
    \newpage%
  }{}%
  % Miniseite um Zeilenbrüche zu vermeiden
  \begin{minipage}{\linewidth}%
    \addtocounter{questionCounter}{1}%
    \setcounter{partCounter}{0}%
    \vspace{.2in}%
    \noindent{\bf \arabic{questionCounter}. #1}%
    \vspace{0.3em} \hrule \vspace{.1in}%
  \end{minipage}
}

% Statt normaler Section-Definition
\renewcommand{\section}[0]{\question}
\WithSuffix\newcommand\section*[1]{\question*{#1}}

% ----- Fragenabschnitte --------------------------------------------------------

\newenvironment{alphaparts}[0]{%
  \begin{enumerate}[label=\textbf{(\alph{partCounter})}]%
}{\end{enumerate}}

\newenvironment{arabicparts}[0]{%
  \begin{enumerate}[label=\textbf{\arabic{questionCounter}.\arabic{partCounter}})]%
}{\end{enumerate}}

\newcommand{\questionpart}[0]{\stepcounter{partCounter}\item}

% ----- Induktionsumgebung -------------------------------------------------

\newenvironment{induction}[0]{%
  \begin{description}
}{\end{description}}

\newcommand{\basecase}{\item[Induktionsanfang]\mbox{}\\}
\newcommand{\indhyp}{\item[Inductionsbehauptung]\mbox{}\\}
\newcommand{\indstep}{\item[Inductionsschritt]\mbox{}\\}

% ----- Antwort ------------------------------------------------------------

\newcommand{\answerbox}[1]{%
\begin{framed}
\vspace{#1}
\end{framed}}

% ----- Seitensetup ------------------------------------------------------------

% Blockabsätze
\setlength{\parindent}{0pt}
\setlength{\parskip}{5pt plus 1pt}

\def\indented#1{\list{}{}\item[]}
\let\indented=\endlist

% ----- Titel & Header --------------------------------------------------------
\pagestyle{empty}
\pagestyle{fancy}

%\if\@opanon%
\ifthenelse{\equal{\@opanon}{0}}{%
  \renewcommand{\maketitle}[0]{%
    % Header-Setup
    \setlength{\headheight}{15.2pt}
    \setlength{\headsep}{0.2in}
    \lhead{\hwclass{} \hwlecture\hwsection}%
    \chead{\hwname{} (\hwemail)}%
    \rhead{\hwtype{} \hwnum}%

    % HRule-Setup
    \renewcommand{\headrulewidth}{0pt}
    \headrule{}

    % Kein Header auf Seite 1
    \thispagestyle{plain}

    \begin{center}
      {\Large \hwclass{} \hwtype{} \hwnum}

      \hwname{} (\hwemail)

      \today
    \end{center}
    \renewcommand{\headrulewidth}{0.4pt}
  }

}%
{%
  \renewcommand{\maketitle}[0]{%
    % Alle Seiten plain
    \pagestyle{plain}

    % Header auf eigener Seite
    \begin{center}
      {\Large \hwclass{} \hwtype{} \hwnum}

      \hwname{} (\hwemail)

      \today
    \end{center}
    \renewcommand{\headrulewidth}{0.4pt}
    \newpage
  }
}

% ----- pandoc -----------------------------

\providecommand{\tightlist}{%
  \setlength{\itemsep}{0pt}\setlength{\parskip}{0pt}}

% -----------------------------------------------------------------------------

