# WiCompass AE Validation Report

Date: 2026-06-26 UTC

Paper repo: `/root/autodl-tmp/github/WiCompass`
AE repo: `/root/autodl-tmp/github/wicompass-ae`

## Environment

- Python: 3.11.15 from `/root/autodl-tmp/conda_envs/wicompass/bin/python`
- PyTorch: 2.5.1+cu124
- GPUs: 4 x NVIDIA GeForce RTX 4090, 24 GB each
- Workspace links in paper repo:
  - `logs -> /root/autodl-tmp/data/wicompass_workspace/wicompass_logs`
  - `model_zoo -> /root/autodl-tmp/data/wicompass_workspace/model_zoo`
  - `datasets/{AMASS_preproc,MMFi,mmBody,real_world,simulation_datasets}` all linked

## Reproduction Levels

We validated the artifact using three levels:

1. Level 1: reproduce paper plots from released logs/intermediate results.
2. Level 2: recompute results from released weights/intermediate data.
3. Level 3: smoke-test from-scratch training entry points.

All validation outputs were written under `/tmp/wicompass-ae-*` except dataset cache files created by the repository's own loaders.

## Level 1: Cached Results and Paper Figures

Executed paper-related notebooks with `nbconvert` using a temporary WiCompass Jupyter kernel.

Directly passed:

- `experiments/knn_coverage/knn_coverage.ipynb`: 5 s
- `experiments/knn_coverage/intra_knn_distribution.ipynb`: 10 s after selecting WiCompass kernel
- `experiments/simulation_scaling/simulation_results.ipynb`: 5 s
- `experiments/real_world_scaling/training_curves.ipynb`: 6 s
- `experiments/real_world_scaling/real_world_paper_figure.ipynb`: 4 s
- `experiments/pilot_study/model_size/model_size_paper_figure.ipynb`: 5 s
- `experiments/pilot_study/leave_one_out/leave_one_out_paper_figure.ipynb`: 3 s

Passed after temporary compatibility patches to notebook copies under `/tmp`:

- `experiments/vqvae_microbenchmark/vqvae_performance.ipynb`: original path points to `../../../logs/vqvae`; patched to `../../logs/vqvae`; 4 s.
- `experiments/pilot_study/data_efficiency/data_efficiency_paper_figure.ipynb`: original mutates read-only arrays returned by Pandas/NumPy; patched `.values` to `.values.copy()`; 4 s.

Details are recorded in the paper repo `problem.md`.

## Level 2: Recompute From Weights / Intermediate Data

### VQ-VAE MMBody Evaluation

Re-evaluated all 12 released VQ-VAE checkpoints on MMBody using 4 GPUs in parallel. Outputs were written to `/tmp/wicompass-ae-level2/vqvae_eval`.

- Models evaluated: 12/12
- Test samples per model: 68,001
- Per-model elapsed time: 3.3 s to 5.5 s
- Maximum absolute difference from released `testing_results.json` recon loss: `8.25e-10`

Conclusion: released VQ-VAE MMBody evaluation results are reproduced to floating-point tolerance.

### Token Encoding

Re-encoded representative datasets with released VQ-VAE weights.

| Dataset | Fresh shape | Released shape | Result |
| --- | ---: | ---: | --- |
| MMBody | `(68001, 16)` | `(68001, 16)` | exact token match |
| MMFi | `(320760, 16)` | `(320760, 16)` | 4 token entries differ out of 5,132,160 |
| A_dance_val | `(3878, 16)` | `(4522, 16)` | count mismatch |
| benchmark | `(40000, 16)` | no same-name released encoded-token file | generated successfully |

Conclusion: MMBody exactly reproduces; MMFi effectively reproduces but is not bitwise identical; `A_dance_val` needs artifact clarification or data/cache alignment.

### KNN Coverage

Ran representative KNN coverage recomputation with `k=2`, `sample-ratio=0.01`, and multi-GPU FAISS. Outputs were written to `/tmp/wicompass-ae-level2/knn`.

Generated both dedup and nodedup outputs for MMBody and MMFi comparisons. The scripts reported `gpu_used: Multi-GPU (4)` and generated JSON/HDF5 outputs successfully.

Representative outputs:

- MMBody dedup: A count 48,394; B count 328; B-to-A hole rate 0.7012
- MMBody nodedup: A count 89,859; B count 680; B-to-A hole rate 0.8941
- MMFi dedup: A count 48,394; B count 2,542; B-to-A hole rate 0.8899
- MMFi nodedup: A count 89,859; B count 3,207; B-to-A hole rate 0.9177

Conclusion: representative multi-GPU KNN recomputation is functional. Full KNN remains a long-running path.

### PPS Sampling and Token-to-Pose Decoding

Ran capped PPS sampling on AMASS tokens with `sample-ratio=0.01`, `budget=500`, `k=8`, `cap-quantile=0.9`, multi-GPU enabled.

Outputs:

- `capped_pps_selected_vectors.npy`: `(500, 16)`
- `capped_pps_selected_labels.npy`: `(500,)`
- metadata reports original sampled size 89,859; unique size 48,394; selected count 500; device `multi-GPU (4)`

Decoded the sampled tokens with the released VQ-VAE checkpoint:

- Output poses: `(500, 22, 3)`
- Wrote `converted_poses.npy`, `converted_labels.npy`, and `conversion_stats.json`

Conclusion: token-space sampling and token-to-pose conversion are functional on a representative subset.

## Level 3: Training Smoke Tests

### VQ-VAE Training

Ran a 1-epoch smoke test on `PosePrior` with batch size 16, output under `/tmp/wicompass-ae-level3/vqvae_smoke/run`.

Observed actual dataset expansion:

- `PosePrior`: 35 source files, 74,978 cached frames
- 4,218 training batches for one epoch
- Runtime: about 2.6 minutes on one RTX 4090

Outputs:

- `checkpoint_epoch_000.pth`
- `best_model.pth`
- `final_model.pth`
- `training_results.json`
- TensorBoard event file

Final metrics:

- Train total loss: 0.014485
- Validation total loss: 0.001736

Conclusion: VQ-VAE training entry point works, but the repository needs a truly tiny smoke config to keep reviewer runtime predictable.

### HPE Training

Ran a 1-epoch PointTransformer tiny smoke test with simulation data, output under `/tmp/wicompass-ae-level3/hpe_smoke`.

Config changes:

- `model.scale: tiny`
- `used_data_quantity: 0.01`
- `full_scaling_ratio: 0.25`
- `batch_size: 8`
- `epochs: 1`

Observed:

- Training subset: 100 samples out of 400 selected training samples
- Test set still reported 40,000 samples
- Runtime: tens of seconds

Outputs:

- `best_model.pth`
- `best_metrics.json`
- `epoch_history.json`
- TensorBoard event file

Best metrics:

- Train MPJPE: 424.10 mm
- Test MPJPE: 376.92 mm

Conclusion: HPE training entry point works, but smoke-test configuration does not cap validation/test size.

## Problems Found

The paper repo now has `problem.md` with nine recorded issues/notes:

1. Wrong VQ-VAE notebook log path.
2. Jupyter kernel must be the WiCompass Python environment.
3. Data-efficiency notebook mutates read-only NumPy arrays.
4. Dataset loaders write cache files inside dataset directories even with `/tmp` output paths.
5. `nbconvert` path behavior for copied notebooks can be fragile.
6. `A_dance_val` re-encoding count mismatch: 3,878 fresh vs 4,522 released.
7. MMFi re-encoding has 4 token-entry mismatches.
8. VQ-VAE smoke test is larger than source file count suggests.
9. HPE smoke test does not limit validation/test split.

## Recommended AE Claims

- Artifacts Available badge: requested; the separate artifact archive DOI is pending. The paper DOI is https://doi.org/10.1145/3795866.3796684.
- Functional badge: requested; setup, workspace links, notebook execution, and representative recomputation paths were validated.
- Results Reproduced badge: requested; the artifact supports complete reproduction, with cached-figure reproduction, VQ-VAE checkpoint evaluation, token checks, representative KNN/PPS checks, smoke tests, and full training scripts.
- Avoid claiming bitwise equality for all intermediate files. Use tolerance/trend-level wording, and call out the `A_dance_val` mismatch explicitly unless fixed before submission.
