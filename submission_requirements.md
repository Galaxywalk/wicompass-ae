# MobiCom 2026 Artifact Evaluation Submission Requirements

Source: <https://www.sigmobile.org/mobicom/2026/artifact_cfp.html>

This document summarizes the MobiCom 2026 Call for Artifacts and turns it into a working checklist for the WiCompass artifact submission.

## Scope and Goal

- Artifact evaluation is open to accepted ACM MobiCom 2026 papers.
- The process aims to promote public distribution of research artifacts, including data, hardware, software, scripts, instructions, survey results, proofs, models, test suites, benchmarks, and other materials associated with a paper.
- The AE committee evaluates whether submitted artifacts are correct, complete, properly documented, functional, and reproducible with respect to the paper's claims.
- The process can award three independent artifact badges:
  - Artifacts Available
  - Artifacts Evaluated - Functional
  - Validated - Results Reproduced
- The AE committee may provide feedback and ask authors to improve artifacts before public distribution.

## Important Dates

| Milestone | Date |
| --- | --- |
| Artifact submission deadline, summer round | June 26, 2026, 23:59 AoE |
| Notification + review available, summer round | July 24, 2026 |
| Artifact final version, summer round | July 31, 2026 |
| Artifact submission deadline, winter round | August 14, 2026, tentative |
| Notification + review available, winter round | September 11, 2026 |
| Artifact final version, winter round | September 18, 2026 |

## Submission Site and Process

- Submit accepted papers for artifact evaluation through HotCRP: <https://mobicom26ae.hotcrp.com>.
- The committee independently reviews artifacts for availability, functionality, and reproducibility in relation to the paper's claims.
- Reviewers may contact authors during review to clarify questions or request additional information.
- Authors may be asked to revise artifacts based on committee suggestions.
- The process may involve several iterations.
- Authors apply for the specific ACM badges they want evaluated.
- Approved badges will be printed on the paper and included as ACM Digital Library metadata.

## Artifact Description Requirements

The submission must include a short artifact description.

Hard requirements:

- The description must explain how to install and run the artifact.
- The description must be at most 3 pages. It can be shorter.
- It must include a full list of hardware requirements.
- It must include a full list of software requirements.
- It should use the official AE template linked by the CFP.
- It should use the linked artifact checklist to verify all necessary information is present.

WiCompass status:

- `ae.tex` compiles to 2 pages locally using the official cTuning `sigplanconf` template/style.
- The anonymous artifact URL is set. The paper DOI is `https://doi.org/10.1145/3795866.3796684`; the artifact archive DOI is still pending. Data/license terms are summarized at a high level in `ae.tex`.

## Artifact Packaging Requirements

Required or strongly expected:

- Provide a minimum working example, such as workflow scripts, to demonstrate that the artifact works.
- Prefer workflow scripts that let reviewers automatically repeat listed experiments with minimal author involvement.
- If automation is not possible because of proprietary/custom hardware or software, provide remote access to the artifact instead.
- Specify how long it takes to run each component.
- Specify the hardware requirements for each component.
- Source code can be shared through openly accessible repositories such as GitHub/GitLab or through dedicated links sent to reviewers.
- The process is best-effort double-blind. Authors should try to anonymize artifact submissions.
- After artifact acceptance, place the artifact in a public archival repository such as Zenodo, Figshare, or Dryad to receive the Artifacts Available badge. These services generate DOI links.
- For software-only artifacts, submit the artifact as a container, for example VirtualBox or Docker.
- For hardware-dependent artifacts, provide anonymous remote access for reviewers to connect to the hardware setup, for example using Zoom, Microsoft Teams, or Google Hangouts with anonymous accounts.

WiCompass implications:

- The repository README now provides quick setup and minimal figure-reproduction commands.
- `ae.tex` records per-path runtime and hardware estimates for setup, Level 1, Level 2, smoke tests, and full long-running paths.
- Docker/video packaging is not planned; the review path uses Conda, submodules, and the released workspace.
- The anonymous artifact link is set to the MobiCom26AE GitHub repository.
- The paper DOI is `https://doi.org/10.1145/3795866.3796684`; the separate artifact archive DOI is still pending.
- Remote access is not required for the standard review path; full reproduction can be run from the released artifact on suitable GPU hardware.

## Badge-Specific Criteria

### Artifacts Available

MobiCom follows ACM guidelines for this badge.

For software artifacts:

- Provide a publicly accessible DOI or link to the source-code repository.
- Provide a unique identifier.

For hardware artifacts:

- Provide accessible source files for hardware designs.
- Provide source code for associated firmware.

WiCompass action items:

- Decide whether the artifact can be public at AE submission or only after acceptance.
- Archive the final artifact on Zenodo/Figshare/Dryad or another acceptable permanent repository.
- Record the DOI or permanent identifier in `ae.tex`.
- Ensure third-party dataset redistribution terms are correctly stated.

### Artifacts Evaluated - Functional

For software artifacts that do not require hardware modification:

- Reviewers with the listed hardware/software should bid on and evaluate the artifact.
- Reviewers will use the submitted workflow scripts to operate the artifact on their own systems.
- Reviewers follow standard ACM guidelines for Artifacts Evaluated - Functional.
- Reviewers may ask authors for explanations or request script revisions during review.

If reviewers with required hardware/software cannot be found:

- Use remote access to the authors' machines.

For hardware artifacts:

- Authors must provide remote access to let reviewers operate the artifact.
- Tools such as TeamViewer can be used.
- Authors are responsible for scheduling evaluation appointments.
- Reviewers must have full control over the artifact workflow, including compiling source code, uploading binaries, configuring hardware, starting hardware operations, and executing listed experiments.
- Authors may communicate with reviewers by audio/video chat and provide instructions.

WiCompass action items:

- Make the Functional badge path executable without full retraining.
- Provide scripts or notebooks that exercise core functionality from released data:
  - workspace link check
  - package import check
  - model checkpoint load check
  - cached result parsing and figure regeneration
  - optional small evaluation on a subset
- Document the exact machine class expected for reviewer-side execution.
- Prepare remote access only if reviewer-side CUDA/GPU setup or storage is impractical.

### Validated - Results Reproduced

Reviewers judge whether the key results listed in the artifact description can be fully reproduced using the submitted artifact.

Important details:

- Authors must list the key results to be reproduced in the artifact description.
- Reviewers may decide whether the listed key results cover all main paper results.
- Reviewers may add more paper results to evaluate.
- Exact reproduction may be hard for mobile systems papers with repeated experiments, environment-specific results, long-running computations, data collection, transmissions, or human subjects.

Special-case guidance:

- For large repeated statistical experiments, authors and reviewers may mutually agree to use a demo video showing workflow scripts and key system functionality.
- Reviewers decide whether the demo video sufficiently reflects the paper's key results.
- For environment-specific experiments, the demo video must reflect the relevant environmental settings and conditions.
- If remote access is used, the authors' side must replicate the paper's environmental settings and conditions.
- For experiments requiring large computation, data collection, or time-consuming transmission, authors and reviewers may agree on a reduced but representative scope.
- Examples of acceptable reduced scope include a subset of a public dataset with the same dimensionality or a reduced amount of data transmission under the same link conditions.
- For human-subject experiments, authors must provide access to deployed system artifacts under the same conditions and system configurations as the paper, and provide a safe-operation demo video. Remote access for human-subject artifacts is subject to institutional IRB approval.

WiCompass action items:

- Explicitly list the key results we want reviewers to reproduce:
  - VQ-VAE microbenchmark figure/trends.
  - KNN coverage figures/trends.
  - Simulation data-scaling figure/trends.
  - Real-world validation figure/trends.
  - Pilot-study figure/trends.
- Define both a quick reviewer path and the full Results Reproduced path. Full retraining is about 400 GPU-hours and full KNN recomputation is about 12 GPU-hours, but the artifact includes the scripts and data needed for complete reproduction.
- Prepare optional demo videos for long-running or environment-specific stages:
  - full workspace setup and sanity check
  - figure reproduction from cached logs
  - selected KNN recomputation
  - selected pose-estimation training/evaluation subset
- State acceptable numerical tolerances and expected trend-level agreement.
- Clarify which results are reproduced from cached logs versus recomputed from model weights or raw/intermediate data.

## Double-Blind and Anonymization Checklist

The CFP says the process is best-effort double-blind and asks authors to try their best to anonymize submissions.

Before submission:

- Use anonymized repository names and links if required by HotCRP or chairs.
- Remove or mask author-identifying names from artifact URLs, README text, and scripts where practical.
- Avoid personal Google Drive names/accounts in reviewer-visible instructions.
- Use anonymous communication accounts if remote access or video meetings are needed.
- Check whether the accepted paper identity makes full anonymization unnecessary or impossible; ask chairs if unclear.

## WiCompass-Specific Submission Checklist

Must finish before submission:

- `ae.tex` is under the 3-page limit using the official cTuning `sigplanconf` template/style.
- Anonymous review repository link is set to https://github.com/MobiCom26AE/WiCompass.
- Badge request is set to all three ACM badges: Artifacts Available, Artifacts Evaluated - Functional, and Validated - Results Reproduced.
- Paper DOI is set to `https://doi.org/10.1145/3795866.3796684`; separate artifact archive DOI remains pending.
- Minimum working example command has been validated in the anonymous repository README.
- Runtime and hardware estimates are summarized in `ae.tex` and the repository README using the official cTuning checklist fields.
- Results Reproduced evidence is summarized in `ae.tex` and `validation_report.md`; the artifact also includes full training scripts for complete reproduction.
- Reproduction plan is documented as Level 1/2/3 in `ae.tex`, with quick checks plus full training paths.
- Data-license notes are set in `ae.tex`: Code: MIT License; Dataset/model: CC BY 4.0.
- Official checklist estimates are set in `ae.tex`: about 200 GB disk, download-bound preparation, about 1 hour for Level 1, about 2 hours for Level 2, and about 450 GPU-hours for full from-scratch reproduction.
- Public availability is marked yes; code license is MIT License; dataset/model license is CC BY 4.0; artifact archive DOI is marked pending, not confused with the paper DOI.
- Docker/container packaging is not planned; the artifact uses Conda plus the released workspace because of CUDA extensions and large data.
- Demo videos are not planned; long-running paths are documented directly, with quick sanity checks provided in addition to the full reproduction workflow.
- Clean-reviewer account link/download verification passed.
- Workspace download was verified through public review links without private rclone credentials.

Current local workspace facts to reflect in the submission:

- Minimal figure-reproduction workspace: `model_zoo` plus `wicompass_logs`, about 36 GB.
- Full extracted workspace components:
  - `model_zoo`: about 1.6 GB
  - `wicompass_logs`: about 34 GB
  - `AMASS_preproc`: about 3.2 GB
  - `mmfi`: about 1.6 GB
  - `mmbody`: about 34 GB
  - `real_world`: about 431 MB
  - `simulation_datasets`: about 8.2 GB
- Full extracted workspace total: about 83 GB, plus archive/download overhead; about 200 GB is recommended for full review use including temporary outputs and build artifacts.
- Current local Python environment used for verification: Python 3.11, PyTorch 2.5.1+cu124.

## Open Questions for Chairs or Final Author Decision

- Page-limit decision: current `ae.pdf` is 2 pages under the official cTuning `sigplanconf` template/style.
- Should the artifact repository be anonymous for accepted papers, or is best-effort anonymization enough?
- Are Google Drive links acceptable during review if the final accepted artifact is later archived with DOI?
- License decision: Code: MIT License; Dataset/model: CC BY 4.0.
- Badge decision: request Results Reproduced in addition to Available and Functional; large-compute paths are documented rather than omitted.
