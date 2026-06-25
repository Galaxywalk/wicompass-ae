# WiCompass Artifact Evaluation Appendix

This repository contains the Artifact Evaluation appendix draft for
"WiCompass: Oracle-driven Data Scaling for mmWave Human Pose Estimation".

## Files

- `ae.tex`: working appendix draft based on the cTuning AE template, using a self-contained standard LaTeX class for local compilation.
- `template/ae-original.tex`: unmodified upstream template for reference.
- `Makefile`: convenience targets for building the PDF.

## Build

```bash
make
```

If `latexmk` is unavailable, try:

```bash
make pdflatex
```

## Open items before submission

- Replace placeholder artifact URLs with the final anonymous or public review links.
- Add the permanent archival DOI if requesting the ACM Artifacts Available badge.
- Confirm the exact AE venue policy, page limit, anonymity policy, and PDF format.
- Confirm hardware timing estimates for reviewers on the target AE machine class.
