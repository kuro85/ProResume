# ProResume

A clean, professional, ATS-friendly resume template built with LaTeX.

## Why LaTeX?

- **Version control** — Track changes with Git, diff between versions, branch for different roles
- **Separation of content and style** — Focus on what you write, not how it looks
- **Consistency** — Fonts, spacing, and alignment are always perfect
- **Reproducible** — Same source always generates the same PDF
- **Plain text** — No proprietary formats, works with any editor
- **Programmable** — Auto-calculate tenure, dynamic layouts, conditional content

## Features

- **ATS-friendly** — Clean structure, parseable by applicant tracking systems
- **Auto-calculated tenure** — Durations like "3 years" or "2.5+ years" computed automatically
- **Dynamic skill alignment** — Label column adjusts to fit the longest category
- **Modular structure** — Edit sections independently in separate files
- **Hyperlinked contacts** — Clickable email, phone, and profile links
- **Customizable** — Colors, fonts, and spacing defined as constants

## Quick Start

```bash
git clone https://github.com/avmnu-sng/ProResume.git
cd ProResume
xelatex resume.tex
```

### Requirements

**macOS:**
```bash
brew install --cask mactex
```

**Ubuntu/Debian:**
```bash
sudo apt-get install texlive-xetex texlive-fonts-extra
```

**Windows:**
Install [MiKTeX](https://miktex.org/download) or [TeX Live](https://tug.org/texlive/).

## File Structure

```
resume/
├── resume.cls                  # Class file (styling, commands)
├── resume.tex                  # Main document
├── resume-tenure.code.tex      # Tenure calculation module
├── resume/
│   ├── header.tex              # Name, contact, links, summary
│   ├── skills.tex              # Skills by category
│   ├── experience.tex          # Work history
│   ├── certifications.tex      # Professional certifications
│   ├── awards.tex              # Awards and recognition
│   └── education.tex           # Education background
├── fonts/                      # Included fonts
├── samples/                    # Sample PDFs for each theme
└── tests/
    └── tenure-test.tex         # Unit tests for tenure calculation
```

## Customization

Edit files in `resume/` folder. Each file has documentation at the top.

**Remove a section** — Comment out its `\input` line in `resume.tex`:
```latex
% \input{resume/certifications}
```

**Reorder sections** — Change the order of `\input` lines.

**Change colors** — Edit `\definecolor` in `resume.cls`:
```latex
\definecolor{accent}{HTML}{164476}
\definecolor{entry-bg}{HTML}{DCE6ED}
```

**Adjust spacing** — Edit `\setlength` in `resume.cls`:
```latex
\setlength{\sectionbefore}{6pt}
\setlength{\entrygap}{4pt}
```

## Font Themes

Five built-in themes — set via class option in `resume.tex`:

```latex
\documentclass[classic]{resume}              % classic (default)
\documentclass[scholar]{resume}     % scholar
\documentclass[modern]{resume}      % modern
\documentclass[silicon]{resume}     % silicon
\documentclass[harmony]{resume}     % harmony
```

| Theme | Body Font | Header Font | Style |
|-------|-----------|-------------|-------|
| **classic** | Source Sans 3 | Playfair Display | Elegant, traditional |
| **scholar** | Lato | EB Garamond | Warm, academic |
| **modern** | Inter | Inter | Clean, minimal |
| **silicon** | Roboto | Roboto Slab | Tech, contemporary |
| **harmony** | Source Sans 3 | Source Serif 4 | Balanced, professional |

See sample PDFs in [`samples/`](samples/) folder. All fonts are included in `fonts/`.

## Troubleshooting

**"Font not found" error:**
```bash
xelatex resume.tex    # Correct
pdflatex resume.tex   # Won't work
```

**Content overflows to second page:**
- Reduce bullet points or entries
- Adjust spacing constants in `resume.cls`

## License

MIT License. Fonts are [SIL Open Font License](https://scripts.sil.org/OFL).
