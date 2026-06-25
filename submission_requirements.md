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

- `ae.tex` currently follows the cTuning-style structure but is 5 pages in local `article` format. It must be compressed to the venue's 3-page limit before submission.
- `ae.tex` currently contains TODOs for artifact URL, DOI, data license terms, and anonymity policy.

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

- We need a minimum working example that can run quickly. Candidate: a script that verifies environment, symlinks, model import, one small model evaluation or cached-log figure reproduction.
- We should add explicit per-component runtimes to `ae.tex`: install, workspace download, minimal figure reproduction, selected model evaluation, selected KNN recomputation, full retraining.
- We should decide whether to provide a Docker container. Because WiCompass depends on CUDA, PyTorch, FAISS GPU, PointNet++ CUDA extensions, and large external data, a Dockerfile or image would reduce reviewer setup risk.
- We need an anonymized artifact link for double-blind review, if the AE process expects anonymity at submission time.
- We need a permanent DOI-backed archive after acceptance if requesting Artifacts Available.
- If any experiment requires our local GPU server or special setup, we need a remote-access plan with anonymous accounts and reviewer control.

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
- Define a reduced but representative Results Reproduced path, because full retraining is about 400 GPU-hours and full KNN recomputation is about 12 GPU-hours.
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

- Compress `ae.tex` to at most 3 pages under the required template/style.
- Replace TODO artifact URL with final anonymous review link.
- Decide which badges to request.
- Add final DOI/unique identifier if requesting Artifacts Available.
- Add a clear minimum working example command.
- Add exact expected runtime and hardware for each review path.
- Add explicit key results for Results Reproduced.
- Add a reduced-scope plan for long-running experiments.
- Add data-license and redistribution notes for AMASS, MMFi, mmBody, real-world data, and RF-Genesis generated simulation data.
- Consider adding a Dockerfile or container instructions.
- Consider adding demo videos for long-running or environment-specific workflows.
- Verify all links work from a clean reviewer account.
- Verify the artifact can be downloaded without relying on private rclone credentials.

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
- Full extracted workspace total: about 83 GB, plus archive/download overhead.
- Current local Python environment used for verification: Python 3.11, PyTorch 2.5.1+cu124.

## Open Questions for Chairs or Final Author Decision

- Is the three-page artifact description limit enforced under the exact cTuning template, ACM format, or plain PDF?
- Should the artifact repository be anonymous for accepted papers, or is best-effort anonymization enough?
- Are Google Drive links acceptable during review if the final accepted artifact is later archived with DOI?
- Can processed AMASS/MMFi/mmBody derivatives be redistributed publicly, or should they be gated/instructions-only?
- Should WiCompass request Results Reproduced, or only Available + Functional, given the large compute and dataset scale?
