# BridgeDTM-GRU v1.0.0 — Initial public release (for C&G submission)

**Repository**: https://github.com/m17335722023/BridgeDTM-GRU  
**License**: Apache-2.0  
**Release date**: 2025-09-09

## ✨ Highlights
- First open-source release accompanying the manuscript.
- MATLAB scripts for reproducing figures and comparing predicted vs. target responses.
- Small SDOF Bouc–Wen example datasets + precomputed predictions for quick reproduction.
- Integrity verification via SHA256 checksums listed in `README.txt`.

## 📦 Artifacts
- Source code (`src/`), examples (`examples/`), and figure files (`figures/`).  
- Journal-compliant `README.txt` and GitHub `README.md`.
- `CITATION.cff`, `.gitattributes` (LFS rules), `.gitignore`.

## 🧪 Quick start
1. `addpath(genpath(pwd))` in MATLAB.
2. `load('examples/1data_DOFBoucWen.mat'); load('examples/1model_prediction.mat');`
3. `open('src/untitled.m');` adjust `n` as commented and run.

## 🔗 Fixed reference
This tag: **v1.0.0**  
Source for this version: `https://github.com/m17335722023/BridgeDTM-GRU/tree/v1.0.0`

## 📜 Citation
Use the **CITATION.cff** or the paper citation when available. Add DOI if archiving on Zenodo.

## Changelog
- v1.0.0 — Initial public release.
