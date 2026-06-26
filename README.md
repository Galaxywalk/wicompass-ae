# WiCompass Artifact Evaluation Appendix

This repository contains the Artifact Evaluation appendix draft for
"WiCompass: Oracle-driven Data Scaling for mmWave Human Pose Estimation".

## Files

- `ae.tex`: working appendix draft based on the official cTuning AE template, using `template/sigplanconf.cls` for local compilation.
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

- Anonymous artifact repository is set to https://github.com/MobiCom26AE/WiCompass.
- Paper DOI is https://doi.org/10.1145/3795866.3796684; artifact archive is available at https://zenodo.org/records/20907837.
- Badge request: Artifacts Available, Artifacts Evaluated - Functional, and Validated - Results Reproduced.
- Confirm the remaining AE venue policy details: anonymity policy and acceptable review/archive links.
