% =============================================================================
% resume.cls — A clean, professional, ATS-friendly resume template
% =============================================================================
%
% Author:  github.com/avmnu-sng
% License: MIT
% Engine:  XeLaTeX (required for custom fonts)
% Build:   xelatex resume.tex
%
% FEATURES:
%   - Clean, minimalist design optimized for ATS parsing
%   - Automatic tenure calculation (e.g., "3 years", "2+ years")
%   - Dynamic skill label alignment
%   - Customizable colors, fonts, and spacing
%   - Support for hyperlinks (email, phone, social profiles)
%
% STRUCTURE:
%   1. Page Layout      — Margins, paper size, no page numbers
%   2. Colors           — Accent color, text shades
%   3. Fonts            — Name font (serif), body font (sans-serif)
%   4. Spacing          — Configurable gaps and paddings
%   5. Typography       — Style commands for consistent formatting
%   6. Header           — Name, contact info, links, summary
%   7. Sections         — Skills, Experience, Certifications, Awards, Education
%
% =============================================================================

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{resume}[2026/01/17 Professional Resume Class]

% =============================================================================
% CLASS OPTIONS
% =============================================================================
% Font theme options:
%
% Usage in resume.tex:
%   \documentclass{resume}              % classic: Source Sans 3 + Playfair Display
%   \documentclass[scholar]{resume}     % scholar: Lato + EB Garamond
%   \documentclass[modern]{resume}      % modern:  Inter (all sans-serif)
%   \documentclass[silicon]{resume}     % silicon: Roboto + Roboto Slab
%   \documentclass[harmony]{resume}     % harmony: Source Sans 3 + Source Serif 4
%
\newif\if@fontscholar
\newif\if@fontmodern
\newif\if@fontsilicon
\newif\if@fontharmony
\DeclareOption{classic}{}                   % Default theme (no flags needed)
\DeclareOption{scholar}{\@fontscholartrue}
\DeclareOption{modern}{\@fontmoderntrue}
\DeclareOption{silicon}{\@fontsilicontrue}
\DeclareOption{harmony}{\@fontharmonytrue}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax

% =============================================================================
% BASE CLASS
% =============================================================================
% Using article as base; a4paper can be changed to letterpaper if needed
\LoadClass[a4paper,11pt]{article}

% =============================================================================
% REQUIRED PACKAGES
% =============================================================================
\RequirePackage{fontspec}           % Custom font loading (XeLaTeX only)
\RequirePackage{geometry}           % Page margins
\RequirePackage{xcolor}             % Color definitions
\RequirePackage{hyperref}           % Hyperlinks (email, URLs)
\RequirePackage{tabularx}           % Flexible tables
\RequirePackage{enumitem}           % Customizable bullet lists
\RequirePackage{parskip}            % Paragraph spacing (no indent)
\RequirePackage{calc}               % Arithmetic in lengths
\RequirePackage{etoolbox}           % Conditional logic (\ifstrempty, etc.)
\RequirePackage{tikz}               % Graphics (unused but available)
\RequirePackage{needspace}          % Ensure minimum space before page break

% =============================================================================
% PAGE LAYOUT
% =============================================================================
% Tight margins to maximize content space while maintaining readability
\geometry{
  a4paper,
  top=0.7cm,
  bottom=0.7cm,
  left=0.7cm,
  right=0.7cm,
  headheight=0pt,
  headsep=0pt,
  footskip=0pt,
}

\setlength{\parindent}{0pt}         % No paragraph indent
\hyphenpenalty=10000                % Disable hyphenation
\exhyphenpenalty=10000
\raggedright                        % Left-align text (no justification)
\pagestyle{empty}                   % No page numbers

% Right padding (breathing room from right margin for content)
\newlength{\contentrightpadding}
\setlength{\contentrightpadding}{0.4cm}

% =============================================================================
% COLOR PALETTE
% =============================================================================
% Customize these colors to match your personal brand
%
%   accent        — Section titles, hyperlinks
%   text-primary  — Main text (headings)
%   text-secondary— Body text
%   text-muted    — Labels, durations
%   text-light    — Taglines (italic descriptions)
%   text-lighter  — Locations
%   rule-color    — Horizontal rules after section titles
%   entry-bg      — Background color for experience entry headers
%
\definecolor{accent}{HTML}{164476}
\definecolor{text-primary}{HTML}{000000}
\definecolor{text-secondary}{HTML}{000000}
\definecolor{text-muted}{HTML}{000000}
\definecolor{text-light}{HTML}{111111}
\definecolor{text-lighter}{HTML}{222222}
\definecolor{text-faint}{HTML}{333333}
\definecolor{rule-color}{HTML}{777777}
\definecolor{entry-bg}{HTML}{DCE6ED}

% =============================================================================
% HYPERLINK STYLING
% =============================================================================
\hypersetup{
  colorlinks=true,
  urlcolor=accent,
  linkcolor=accent,
  pdfborder={0 0 0},
}

% =============================================================================
% FONT CONFIGURATION
% =============================================================================
% Five font themes available (set via class option):
%
%   classic (default) — Source Sans 3 + Playfair Display
%   scholar           — Lato + EB Garamond
%   modern            — Inter (all sans-serif)
%   silicon           — Roboto + Roboto Slab
%   harmony           — Source Sans 3 + Source Serif 4
%

\if@fontscholar
  % --- scholar: Lato + EB Garamond ---
  \newfontfamily\namefont{EBGaramond-Bold.ttf}[
    Path=fonts/ebgaramond/,
  ]
  \setmainfont{Lato}[
    Path=fonts/lato/,
    Extension=.ttf,
    UprightFont=*-Regular,
    ItalicFont=*-Italic,
    BoldFont=*-Bold,
    BoldItalicFont=*-BoldItalic,
  ]
  \newfontfamily\semibold{Lato}[
    Path=fonts/lato/,
    Extension=.ttf,
    UprightFont=*-Bold,
    ItalicFont=*-BoldItalic,
  ]
\else\if@fontmodern
  % --- modern: Inter (all sans-serif) ---
  \newfontfamily\namefont{Inter_18pt-Bold.ttf}[
    Path=fonts/inter/,
  ]
  \setmainfont{Inter_18pt}[
    Path=fonts/inter/,
    Extension=.ttf,
    UprightFont=*-Regular,
    ItalicFont=*-Italic,
    BoldFont=*-Bold,
    BoldItalicFont=*-BoldItalic,
  ]
  \newfontfamily\semibold{Inter_18pt}[
    Path=fonts/inter/,
    Extension=.ttf,
    UprightFont=*-SemiBold,
    ItalicFont=*-SemiBoldItalic,
  ]
\else\if@fontsilicon
  % --- silicon: Roboto + Roboto Slab ---
  \newfontfamily\namefont{RobotoSlab-Bold.ttf}[
    Path=fonts/robotoslab/,
  ]
  \setmainfont{Roboto}[
    Path=fonts/roboto/,
    Extension=.ttf,
    UprightFont=*-Regular,
    ItalicFont=*-Italic,
    BoldFont=*-Bold,
    BoldItalicFont=*-BoldItalic,
  ]
  \newfontfamily\semibold{Roboto}[
    Path=fonts/roboto/,
    Extension=.ttf,
    UprightFont=*-Medium,
    ItalicFont=*-MediumItalic,
  ]
\else\if@fontharmony
  % --- harmony: Source Sans 3 + Source Serif 4 ---
  \newfontfamily\namefont{SourceSerif4-Bold.ttf}[
    Path=fonts/sourceserif4/,
  ]
  \setmainfont{SourceSans3}[
    Path=fonts/sourcesans3/,
    Extension=.ttf,
    UprightFont=*-Regular,
    ItalicFont=*-Italic,
    BoldFont=*-Bold,
    BoldItalicFont=*-BoldItalic,
  ]
  \newfontfamily\semibold{SourceSans3}[
    Path=fonts/sourcesans3/,
    Extension=.ttf,
    UprightFont=*-SemiBold,
    ItalicFont=*-SemiBoldItalic,
  ]
\else
  % --- classic (default): Source Sans 3 + Playfair Display ---
  \newfontfamily\namefont{PlayfairDisplay-Bold.ttf}[
    Path=fonts/playfairdisplay/,
  ]
  \setmainfont{SourceSans3}[
    Path=fonts/sourcesans3/,
    Extension=.ttf,
    UprightFont=*-Regular,
    ItalicFont=*-Italic,
    BoldFont=*-Bold,
    BoldItalicFont=*-BoldItalic,
  ]
  \newfontfamily\semibold{SourceSans3}[
    Path=fonts/sourcesans3/,
    Extension=.ttf,
    UprightFont=*-SemiBold,
    ItalicFont=*-SemiBoldItalic,
  ]
\fi\fi\fi\fi

% =============================================================================
% SPACING CONSTANTS
% =============================================================================
% All spacing values are defined here for easy customization
% Adjust these to make the resume more or less compact

% -- Global --
\newlength{\sectionbefore}          % Space before section title
\setlength{\sectionbefore}{6pt}

\newlength{\sectionafter}           % Space after section title
\setlength{\sectionafter}{3pt}

\newlength{\entrygap}               % Space between entries
\setlength{\entrygap}{4pt}

\newlength{\bulletgap}              % Space between bullet points
\setlength{\bulletgap}{1pt}

% -- Header --
\newlength{\headergap}              % Space after header
\setlength{\headergap}{6pt}

\newlength{\headernamespacing}      % Space after name
\setlength{\headernamespacing}{2pt}

\newlength{\headersubtitlespacing}  % Space after tagline
\setlength{\headersubtitlespacing}{1pt}

\newlength{\headersummaryspacing}   % Space before summary
\setlength{\headersummaryspacing}{6pt}

\newlength{\headercontactgap}       % Gap between label and value
\setlength{\headercontactgap}{4pt}

\newlength{\headercontactlinespacing} % Space between contact lines
\setlength{\headercontactlinespacing}{2pt}

\newcommand{\headerleftwidth}{0.55\textwidth}  % Left column width
\newcommand{\headerrightwidth}{0.43\textwidth} % Right column width

% -- Section Title --
\newlength{\sectionrulespacing}     % Gap between title and rule
\setlength{\sectionrulespacing}{0.5em}

\newlength{\sectionruleheight}      % Thickness of horizontal rule
\setlength{\sectionruleheight}{0.5pt}

% -- Skills --
\newlength{\skilllabelwidth}        % Width for skill labels (auto-calculated)
\setlength{\skilllabelwidth}{2.35cm}

\newlength{\skilllabelgap}          % Gap between label and skills
\setlength{\skilllabelgap}{6pt}

\newlength{\skillsalistedbottom}    % Space after skills section
\setlength{\skillsalistedbottom}{2pt}

% -- Experience --
\newlength{\bulletleftmargin}       % Indent for bullet points
\setlength{\bulletleftmargin}{1.5em}

\newlength{\bulletlabelsep}         % Space between bullet and text
\setlength{\bulletlabelsep}{0.5em}

\newlength{\subbullettopspacing}    % Space before nested bullets
\setlength{\subbullettopspacing}{1pt}

\newlength{\taglinetopspacing}      % Space before tagline
\setlength{\taglinetopspacing}{1pt}

\newlength{\taglinebottomspacing}   % Space after tagline
\setlength{\taglinebottomspacing}{4pt}

\newlength{\entryheaderspacing}     % Space after entry header background
\setlength{\entryheaderspacing}{2pt}

\newlength{\entryheaderpadding}     % Padding inside entry header background
\setlength{\entryheaderpadding}{4pt}

\newlength{\entryrightcolwidth}     % Width for location/duration column
\setlength{\entryrightcolwidth}{5cm}

\newlength{\entrybgextend}          % Background extension beyond content
\setlength{\entrybgextend}{3pt}

% =============================================================================
% PAGE BREAK PROTECTION
% =============================================================================
% Minimum space required to avoid orphaned elements at page bottom
% These are calculated after font sizes are defined (see below)

\newlength{\sectionminspace}        % Section title + first entry header
\newlength{\expentryminspace}       % Experience header + tagline + first bullet

% =============================================================================
% FONT SIZE CONSTANTS
% =============================================================================
% Font sizes and line heights (leading) for each element type
% Format: \<element>fontsize and \<element>leading

% -- Name --
\newlength{\namefontsize}
\setlength{\namefontsize}{21pt}
\newlength{\nameleading}
\setlength{\nameleading}{21pt}

% -- Header Tagline --
\newlength{\headertaglinefontsize}
\setlength{\headertaglinefontsize}{11pt}
\newlength{\headertaglineleading}
\setlength{\headertaglineleading}{13pt}

% -- Section Title --
\newlength{\sectiontitlefontsize}
\setlength{\sectiontitlefontsize}{12pt}
\newlength{\sectiontitleleading}
\setlength{\sectiontitleleading}{14pt}

% -- Primary (Company/School/Cert Name) --
\newlength{\primaryfontsize}
\setlength{\primaryfontsize}{10.5pt}
\newlength{\primaryleading}
\setlength{\primaryleading}{12pt}

% -- Secondary (Job Title/Degree) --
\newlength{\secondaryfontsize}
\setlength{\secondaryfontsize}{10.5pt}
\newlength{\secondaryleading}
\setlength{\secondaryleading}{12pt}

% -- Location --
\newlength{\locationfontsize}
\setlength{\locationfontsize}{9.5pt}
\newlength{\locationleading}
\setlength{\locationleading}{11pt}

% -- Duration --
\newlength{\durationfontsize}
\setlength{\durationfontsize}{9.5pt}
\newlength{\durationleading}
\setlength{\durationleading}{11pt}

% -- Label (Phone:, Email:, skill categories) --
\newlength{\labelfontsize}
\setlength{\labelfontsize}{9.5pt}
\newlength{\labelleading}
\setlength{\labelleading}{11pt}

% -- Body (bullet points, skill values) --
\newlength{\bodyfontsize}
\setlength{\bodyfontsize}{10pt}
\newlength{\bodyleading}
\setlength{\bodyleading}{12pt}

% -- Summary --
\newlength{\summaryfontsize}
\setlength{\summaryfontsize}{10pt}
\newlength{\summaryleading}
\setlength{\summaryleading}{11.5pt}

% -- Tagline (italic description under entry) --
\newlength{\taglinefontsize}
\setlength{\taglinefontsize}{9.5pt}
\newlength{\taglineleading}
\setlength{\taglineleading}{11.5pt}

% -- Calculated Page Break Protection Values --
% Section: title + spacing + first entry header (2 lines)
\setlength{\sectionminspace}{\dimexpr\sectiontitleleading+\sectionafter+2\primaryleading\relax}
% Experience: header + spacing + tagline + spacing + first bullet
\setlength{\expentryminspace}{%
  \dimexpr 2\entryheaderpadding + 2\primaryleading + \entryheaderspacing
         + \taglinetopspacing + \taglineleading + \taglinebottomspacing
         + \bodyleading\relax
}

% =============================================================================
% TYPOGRAPHY STYLES
% =============================================================================
% These commands apply consistent styling throughout the resume
% Each style combines: font family, size, color, and text transform

% Name (large serif, letter-spaced, uppercase)
\newcommand{\stylename}[1]{%
  {\namefont\fontsize{\namefontsize}{\nameleading}\selectfont%
   \color{text-primary}\addfontfeature{LetterSpace=5}\MakeUppercase{#1}}%
}

% Header tagline (sans-serif, uppercase)
\newcommand{\styleheadertagline}[1]{%
  {\fontsize{\headertaglinefontsize}{\headertaglineleading}\selectfont%
   \color{text-muted}\MakeUppercase{#1}}%
}

% Section title (bold, accent color, letter-spaced, uppercase)
\newcommand{\stylesectiontitle}[1]{%
  {\bfseries\fontsize{\sectiontitlefontsize}{\sectiontitleleading}\selectfont%
   \color{accent}\addfontfeature{LetterSpace=2.5}\MakeUppercase{#1}}%
}

% Primary text (semibold, uppercase) — company names, schools
\newcommand{\styleprimary}[1]{%
  {\semibold\fontsize{\primaryfontsize}{\primaryleading}\selectfont%
   \color{text-primary}\MakeUppercase{#1}}%
}

% Secondary text (regular, uppercase) — job titles, degrees
\newcommand{\stylesecondary}[1]{%
  {\fontsize{\secondaryfontsize}{\secondaryleading}\selectfont%
   \color{text-secondary}\MakeUppercase{#1}}%
}

% Location text
\newcommand{\stylelocation}[1]{%
  {\fontsize{\locationfontsize}{\locationleading}\selectfont\color{text-lighter}#1}%
}

% Duration text (semibold)
\newcommand{\styleduration}[1]{%
  {\semibold\fontsize{\durationfontsize}{\durationleading}\selectfont\color{text-muted}#1}%
}

% Label text (semibold) — Phone:, Email:, skill categories
\newcommand{\stylelabel}[1]{%
  {\semibold\fontsize{\labelfontsize}{\labelleading}\selectfont\color{text-muted}#1}%
}

% Body text — bullet points, skill values
\newcommand{\stylebody}[1]{%
  {\fontsize{\bodyfontsize}{\bodyleading}\selectfont\color{text-secondary}#1}%
}

% Summary text
\newcommand{\stylesummary}[1]{%
  {\fontsize{\summaryfontsize}{\summaryleading}\selectfont%
   \setlength{\baselineskip}{\summaryleading}\color{text-secondary}#1}%
}

% Tagline text (italic)
\newcommand{\styletagline}[1]{%
  {\fontsize{\taglinefontsize}{\taglineleading}\selectfont%
   \setlength{\baselineskip}{\taglineleading}\itshape\color{text-light}#1}%
}

% =============================================================================
% HEADER COMMANDS
% =============================================================================
% Commands to set header data (called in resume/header.tex)
%
% Usage:
%   \name{John Doe}
%   \tagline{Software Engineer}
%   \email{john@example.com}
%   \phone{+1-555-123-4567}
%   \addlink
%     {LinkedIn}
%     {johndoe}
%     {https://linkedin.com/in/johndoe}
%   \summary{Your professional summary...}
%

% Storage for header data
\newcommand{\@resumename}{}
\newcommand{\name}[1]{\renewcommand{\@resumename}{#1}}

\newcommand{\@resumetagline}{}
\newcommand{\tagline}[1]{\renewcommand{\@resumetagline}{#1}}

\newcommand{\@resumesummary}{}
\newcommand{\summary}[1]{\renewcommand{\@resumesummary}{#1}}

\newcommand{\@resumeemail}{}
\newcommand{\email}[1]{\renewcommand{\@resumeemail}{#1}}

\newcommand{\@resumephone}{}
\newcommand{\phone}[1]{\renewcommand{\@resumephone}{#1}}

% Links storage (up to 5 links supported)
\newcommand{\@linkA}{}
\newcommand{\@linkB}{}
\newcommand{\@linkC}{}
\newcommand{\@linkD}{}
\newcommand{\@linkE}{}
\newcounter{@linkcount}

\newlength{\contactlabelwidth}
\AtBeginDocument{\settowidth{\contactlabelwidth}{\stylelabel{Phone:}}}

% Add a link to the header
% Usage:
%   \addlink
%     {Label}
%     {Display Text}
%     {URL}
\newcommand{\addlink}[3]{%
  \stepcounter{@linkcount}%
  \ifnum\value{@linkcount}=1%
    \renewcommand{\@linkA}{\stylelabel{#1:} & \stylebody{\href{#3}{#2}}\\[\headercontactlinespacing]}%
  \fi%
  \ifnum\value{@linkcount}=2%
    \renewcommand{\@linkB}{\stylelabel{#1:} & \stylebody{\href{#3}{#2}}\\[\headercontactlinespacing]}%
  \fi%
  \ifnum\value{@linkcount}=3%
    \renewcommand{\@linkC}{\stylelabel{#1:} & \stylebody{\href{#3}{#2}}\\[\headercontactlinespacing]}%
  \fi%
  \ifnum\value{@linkcount}=4%
    \renewcommand{\@linkD}{\stylelabel{#1:} & \stylebody{\href{#3}{#2}}\\[\headercontactlinespacing]}%
  \fi%
  \ifnum\value{@linkcount}=5%
    \renewcommand{\@linkE}{\stylelabel{#1:} & \stylebody{\href{#3}{#2}}\\[\headercontactlinespacing]}%
  \fi%
}

% =============================================================================
% HEADER RENDERING
% =============================================================================
% Renders the complete header with two-column layout:
%   Left:  Name, tagline, phone, email
%   Right: Links (LinkedIn, GitHub, etc.)
%   Below: Summary (full width)
%
\newcommand{\makeheader}{%
  \noindent%
  % Left column: Name, Tagline, Phone, Email
  \begin{minipage}[t]{\headerleftwidth}%
    \raggedright%
    \stylename{\@resumename}%
    \par\vspace{\headernamespacing}%
    \ifdefempty{\@resumetagline}{}{%
      \styleheadertagline{\@resumetagline}%
      \par\vspace{\headersubtitlespacing}%
    }%
    \makebox[\contactlabelwidth][r]{\stylelabel{Phone:}}%
    \hspace{\headercontactgap}%
    \stylebody{\href{tel:\@resumephone}{\@resumephone}}%
    \\[\headercontactlinespacing]%
    \makebox[\contactlabelwidth][r]{\stylelabel{Email:}}%
    \hspace{\headercontactgap}%
    \stylebody{\href{mailto:\@resumeemail}{\@resumeemail}}%
  \end{minipage}%
  \hfill%
  % Right column: Links
  \begin{minipage}[t]{\headerrightwidth}%
    \raggedleft%
    \vspace{0pt}%
    \begin{tabular}[t]{@{}r@{\hspace{\headercontactgap}}l@{}}
      \@linkA\@linkB\@linkC\@linkD\@linkE
    \end{tabular}%
  \end{minipage}%
  \par%
  % Summary (full width, below contact info)
  \ifdefempty{\@resumesummary}{}{%
    \vspace{\headersummaryspacing}%
    \noindent%
    \begin{minipage}{\textwidth}%
      \fontsize{\summaryfontsize}{\summaryleading}\selectfont%
      \setlength{\baselineskip}{\summaryleading}%
      \color{text-secondary}\@resumesummary%
    \end{minipage}%
    \par%
  }%
  \vspace{\headergap}%
}

% =============================================================================
% SECTION TITLE
% =============================================================================
% Creates a section heading with a horizontal rule
% Usage: \cvsection{Experience}
%
\newcommand{\cvsection}[1]{%
  \needspace{\sectionminspace}%
  \vspace{\sectionbefore}%
  \noindent%
  \makebox[\dimexpr\textwidth-\contentrightpadding\relax][l]{%
    \stylesectiontitle{#1}%
    \hspace{\sectionrulespacing}%
    \textcolor{rule-color}{\leaders\hrule height \sectionruleheight\hfill\kern0pt}%
  }%
  \par\vspace{\sectionafter}%
  \nopagebreak[4]%
}

% =============================================================================
% SKILLS SECTION
% =============================================================================
% Skills are rendered with right-aligned labels and wrapped values
% Label width is automatically calculated to fit the longest label
%
% Usage:
%   \begin{skills}
%     \skill
%       {Languages}
%       {Python, Java, Go}
%     \skill
%       {Tools}
%       {Docker, Kubernetes, AWS}
%   \end{skills}
%

% Internal storage (supports up to 6 skill categories)
\newlength{\@skilltempmeasure}
\newcounter{@skillcount}
\newcommand{\@skillLabelA}{}
\newcommand{\@skillContentA}{}
\newcommand{\@skillLabelB}{}
\newcommand{\@skillContentB}{}
\newcommand{\@skillLabelC}{}
\newcommand{\@skillContentC}{}
\newcommand{\@skillLabelD}{}
\newcommand{\@skillContentD}{}
\newcommand{\@skillLabelE}{}
\newcommand{\@skillContentE}{}
\newcommand{\@skillLabelF}{}
\newcommand{\@skillContentF}{}

% Collect skills and track maximum label width
\newcommand{\skill}[2]{%
  \stepcounter{@skillcount}%
  \settowidth{\@skilltempmeasure}{\stylelabel{#1:}}%
  \ifdim\@skilltempmeasure>\skilllabelwidth%
    \setlength{\skilllabelwidth}{\@skilltempmeasure}%
  \fi%
  \ifnum\value{@skillcount}=1\renewcommand{\@skillLabelA}{#1}\renewcommand{\@skillContentA}{#2}\fi%
  \ifnum\value{@skillcount}=2\renewcommand{\@skillLabelB}{#1}\renewcommand{\@skillContentB}{#2}\fi%
  \ifnum\value{@skillcount}=3\renewcommand{\@skillLabelC}{#1}\renewcommand{\@skillContentC}{#2}\fi%
  \ifnum\value{@skillcount}=4\renewcommand{\@skillLabelD}{#1}\renewcommand{\@skillContentD}{#2}\fi%
  \ifnum\value{@skillcount}=5\renewcommand{\@skillLabelE}{#1}\renewcommand{\@skillContentE}{#2}\fi%
  \ifnum\value{@skillcount}=6\renewcommand{\@skillLabelF}{#1}\renewcommand{\@skillContentF}{#2}\fi%
}

% Render a single skill row
\newcommand{\@renderskill}[2]{%
  \noindent%
  \hangindent=\dimexpr\skilllabelwidth+\skilllabelgap\relax%
  \hangafter=1%
  \makebox[\skilllabelwidth][r]{\stylelabel{#1:}}\hspace{\skilllabelgap}\stylebody{#2}%
  \par%
}

% Skills environment
\newenvironment{skills}{%
  \setcounter{@skillcount}{0}%
  \setlength{\skilllabelwidth}{0pt}%
  \setlength{\parskip}{0pt}%
}{%
  \ifnum\value{@skillcount}>0\@renderskill{\@skillLabelA}{\@skillContentA}\fi%
  \ifnum\value{@skillcount}>1\@renderskill{\@skillLabelB}{\@skillContentB}\fi%
  \ifnum\value{@skillcount}>2\@renderskill{\@skillLabelC}{\@skillContentC}\fi%
  \ifnum\value{@skillcount}>3\@renderskill{\@skillLabelD}{\@skillContentD}\fi%
  \ifnum\value{@skillcount}>4\@renderskill{\@skillLabelE}{\@skillContentE}\fi%
  \ifnum\value{@skillcount}>5\@renderskill{\@skillLabelF}{\@skillContentF}\fi%
  \vspace{\skillsalistedbottom}%
}

% =============================================================================
% TENURE CALCULATION
% =============================================================================
% Automatic duration formatting: "Jan 2020 – Dec 2023 (4 years)"
% Loaded from separate module for easier testing
\input{resume-tenure.code.tex}

% =============================================================================
% EXPERIENCE SECTION
% =============================================================================
% Work experience with automatic tenure calculation
%
% Usage:
%   \begin{experience}
%     \expentry
%       {Company Name}
%       {Job Title}
%       {City, Country}
%       {2020-01}
%       {present}
%       {Optional tagline}
%       {
%         \item Achievement one
%         \item Achievement two
%       }
%   \end{experience}
%

% Bullet list for experience entries (supports 2 levels of nesting)
\newlist{expsubentry}{itemize}{2}
\setlist[expsubentry,1]{
  label=\textbullet,
  leftmargin=\bulletleftmargin,
  labelsep=\bulletlabelsep,
  itemsep=\bulletgap,
  parsep=0pt,
  topsep=0pt,
  partopsep=0pt,
}
\setlist[expsubentry,2]{
  label=\textbullet,
  leftmargin=\bulletleftmargin,
  labelsep=\bulletlabelsep,
  itemsep=\bulletgap,
  parsep=0pt,
  topsep=\subbullettopspacing,
  partopsep=0pt,
}

\newenvironment{experience}{}{}

% Experience entry command
\newcommand{\expentry}[7]{%
  \needspace{\expentryminspace}%
  \noindent%
  \hspace{-\entrybgextend}%
  \setlength{\fboxsep}{\entrybgextend}%
  \colorbox{entry-bg}{%
    \begin{minipage}{\dimexpr\textwidth-\contentrightpadding\relax}%
      \vspace{\entryheaderpadding}%
      \begin{tabular*}{\textwidth}{@{}l@{\extracolsep{\fill}}r@{}}
        \styleprimary{#1}%
        & \makebox[\entryrightcolwidth][r]{\stylelocation{#3}}\\
        \stylesecondary{#2}%
        & \makebox[\entryrightcolwidth][r]{\styleduration{\formatduration{#4}{#5}}}%
      \end{tabular*}%
      \vspace{\entryheaderpadding}%
    \end{minipage}%
  }%
  \par\vspace{\entryheaderspacing}%
  \ifstrempty{#6}{%
    \vspace{\taglinetopspacing}%
  }{%
    \vspace{\taglinetopspacing}%
    \begin{minipage}{\textwidth}%
      \raggedright\fontsize{\taglinefontsize}{\taglineleading}\selectfont%
      \setlength{\baselineskip}{\taglineleading}\itshape\color{text-light}#6%
    \end{minipage}%
    \vspace{\taglinebottomspacing}%
    \vspace{-\parskip}%
  }%
  \nopagebreak[4]%
  \begin{expsubentry}
    \stylebody{#7}
  \end{expsubentry}%
  \vspace{\entrygap}%
}

% =============================================================================
% CERTIFICATIONS SECTION
% =============================================================================
% Professional certifications with optional expiry dates and verification links
%
% Usage:
%   \begin{certifications}
%     \certentry
%       {AWS Solutions Architect}
%       {Amazon Web Services}
%       {Jan 2023 – Jan 2026}
%       {Renewed}
%       {https://verify.aws/123}
%   \end{certifications}
%

\newenvironment{certifications}{}{}

\newcommand{\certentry}[5]{%
  \noindent%
  \begin{minipage}{\textwidth}%
    \begin{tabular*}{\dimexpr\textwidth-\contentrightpadding\relax}{@{}l@{\extracolsep{\fill}}r@{}}
      \makebox[\dimexpr\bulletleftmargin-\bulletlabelsep\relax][r]{\textbullet}%
      \hspace{\bulletlabelsep}%
      \ifstrempty{#5}%
        {\styleprimary{#1}}%
        {{\semibold\fontsize{\primaryfontsize}{\primaryleading}\selectfont%
          \href{#5}{\MakeUppercase{#1}}}}%
      & \makebox[\entryrightcolwidth][r]{\styleduration{#3}}\\
      \hspace{\bulletleftmargin}\stylesecondary{#2} & \\
    \end{tabular*}%
    \ifstrempty{#4}{}{%
      \par\vspace{\taglinetopspacing}\hspace{\bulletleftmargin}\stylebody{#4}%
    }%
  \end{minipage}%
  \vspace{\entrygap}%
}

% =============================================================================
% AWARDS SECTION
% =============================================================================
% Awards, honors, and recognition
%
% Usage:
%   \begin{awards}
%     \awardentry
%       {Employee of the Year}
%       {Company Name}
%       {Dec 2023}
%       {For exceptional performance}
%       {https://example.com/award}
%   \end{awards}
%

\newenvironment{awards}{}{}

\newcommand{\awardentry}[5]{%
  \noindent%
  \begin{minipage}{\textwidth}%
    \begin{tabular*}{\dimexpr\textwidth-\contentrightpadding\relax}{@{}l@{\extracolsep{\fill}}r@{}}
      \makebox[\dimexpr\bulletleftmargin-\bulletlabelsep\relax][r]{\textbullet}%
      \hspace{\bulletlabelsep}%
      \ifstrempty{#5}%
        {\styleprimary{#1}}%
        {{\semibold\fontsize{\primaryfontsize}{\primaryleading}\selectfont%
          \href{#5}{\MakeUppercase{#1}}}}%
      & \makebox[\entryrightcolwidth][r]{\styleduration{#3}}\\
      \hspace{\bulletleftmargin}\stylesecondary{#2} & \\
    \end{tabular*}%
    \ifstrempty{#4}{}{%
      \par\vspace{\taglinetopspacing}\hspace{\bulletleftmargin}\stylebody{#4}%
    }%
  \end{minipage}%
  \vspace{\entrygap}%
}

% =============================================================================
% EDUCATION SECTION
% =============================================================================
% Educational background
%
% Usage:
%   \begin{education}
%     \educationentry
%       {University Name}
%       {B.S. in Computer Science}
%       {City, Country}
%       {Aug 2015 – May 2019}
%       {GPA: 3.8/4.0}
%   \end{education}
%

\newenvironment{education}{}{}

\newcommand{\educationentry}[5]{%
  \noindent%
  \begin{minipage}{\textwidth}%
    \begin{tabular*}{\dimexpr\textwidth-\contentrightpadding\relax}{@{}l@{\extracolsep{\fill}}r@{}}
      \makebox[\dimexpr\bulletleftmargin-\bulletlabelsep\relax][r]{\textbullet}%
      \hspace{\bulletlabelsep}\styleprimary{#1}%
      & \makebox[\entryrightcolwidth][r]{\stylelocation{#3}}\\
      \hspace{\bulletleftmargin}\stylesecondary{#2}%
      & \makebox[\entryrightcolwidth][r]{\styleduration{#4}}\\
    \end{tabular*}%
    \ifstrempty{#5}{}{%
      \par\vspace{\taglinetopspacing}\hspace{\bulletleftmargin}\stylebody{#5}%
    }%
  \end{minipage}%
  \vspace{\entrygap}%
}

% =============================================================================
% END OF CLASS
% =============================================================================
\endinput
