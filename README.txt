    ======================================================================
    README.txt  —  Code & Data Package for Computers & Geosciences
    ======================================================================

    Program name
    ------------
    BridgeDTM‑GRU (Seismic Response Predictor)

    Related manuscript
    ------------------
    Title: Digital twin model of a high-speed railway bridge based on deep learning and high-precision prediction of its seismic responses
    Authors: Haoxiang Yang¹, Youliang Ding¹,*, Fangfang Geng²,*, Kang Yang³
    Affiliations: ¹ Key Laboratory of Concrete and Prestressed Concrete Structures of Ministry of Education, Southeast University, Nanjing 210096, China; ² School of Architecture Engineering, Nanjing Institute of Technology, Nanjing 211167, China; ³ Shanghai Institute of Technology, Shanghai 201418, China
    Contact: civilding@seu.edu.cn (Youliang Ding); j00000002962@njit.edu.cn (Fangfang Geng)

    Repository & license
    --------------------
    • Public repository (required by journal): https://github.com/m17335722023/BridgeDTM-GRU
    • Open‑source license (required): Apache‑2.0.
    • (Optional) Upon acceptance, C&G may fork your repo under https://github.com/CAGEO to
      improve discoverability of the original code and data.

    Package contents
    ----------------
    This archive contains MATLAB source code, precomputed data, and example outputs:
    • Source code:      ./…/untitled.m   (plot/visualization script using variables in workspace)
    • Test data:        ./…/1data_DOFBoucWen.mat, ./…/2data_DOFBoucWen.mat
                        (single‑DOF Bouc–Wen datasets for nonlinear response examples)
    • Predicted output: ./…/1model_prediction.mat, ./…/2model_prediction.mat
                        (precomputed model predictions for comparison/reproduction)
    • Figures:          several .fig files including training loss and result plots (GRUloss*, etc.)

    IMPORTANT on filenames
    ----------------------
    Some paths appear garbled if your unzip tool assumes a non‑UTF‑8 code page.
    If you see unreadable characters, re‑extract using a tool that preserves UTF‑8
    filenames (e.g., 7‑Zip) or set your system’s ZIP encoding to UTF‑8.

    System requirements
    -------------------
    • MATLAB R2020b or newer (tested versions recommended); Octave may work for loading/plotting,
      but Deep Learning Toolbox features are NOT used directly by the provided plotting script.
    • No executables (.exe) are included (discouraged by the journal).
    • OS: Windows/macOS/Linux.

    Quick start (reproduce figures with provided data)
    --------------------------------------------------
    1) Launch MATLAB and add the unzipped folder to the path:
         addpath(genpath('UNZIPPED_FOLDER_PATH'))
    2) Load one of the provided datasets and predictions (example):
         load('…/1data_DOFBoucWen.mat');       % dataset variables
         load('…/1model_prediction.mat');      % predicted series
    3) Open and adapt the plotting script:
         open('…/untitled.m')
       • In the script, set the row index n (e.g., n = 76) and ensure the variables in workspace
         correspond to ‘target_pred_tf1’, ‘y_pure_preds1/2/3’, ‘y6’ (loss), etc.
       • Run the script to produce comparison plots and loss curves.
    4) To reproduce the second example, load ‘2data_DOFBoucWen.mat’ + ‘2model_prediction.mat’
       and repeat Step 3 (set n = 116 as suggested in script comments).

    Data description
    ----------------
    • 1data_DOFBoucWen.mat / 2data_DOFBoucWen.mat:
      Single‑degree‑of‑freedom nonlinear hysteretic (Bouc–Wen) response datasets used for
      feasibility and model‑comparison experiments.
    • 1model_prediction.mat / 2model_prediction.mat:
      Precomputed predictions for RNN/LSTM/GRU used in figure reproduction.
    • GRUloss*.mat / .fig and other .fig files:
      Saved training‑loss curves and visualization figures for the manuscript.

    Expected outputs & verification
    -------------------------------
    • Running the plotting script should regenerate the time‑history comparison figures and loss curves.
    • Integrity checks (SHA256) for all files in this ZIP are listed below.
      After transfer, recompute SHA256 to confirm no corruption occurred.

    File listing with sizes and checksums (SHA256)
    ----------------------------------------------
    | Path in ZIP | Size (bytes) | SHA256 |
|---|---:|---|
| ╘¡╩╝╩²╛▌/1data_DOFBoucWen.mat | 9340062 | 1501acb736f440e4589fa6d3627c0ea6a74cf9987eca39eab7be357d20784908 |
| ╘¡╩╝╩²╛▌/1model_prediction.mat | 3842288 | 927325759f54deac544527286aa33a95abc8ad9a7b6bbddc602302b931c228d8 |
| ╘¡╩╝╩²╛▌/2data_DOFBoucWen.mat | 9341015 | f0c11145cd3fd29747b77c71dba0d6fa01a4ed16713273c0dc97d6aca43af80c |
| ╘¡╩╝╩²╛▌/2model_prediction.mat | 3842288 | 2a4d69fcaae930150d391d8cbca36188db3b1221ffd6667251c728b401282d01 |
| ╘¡╩╝╩²╛▌/untitled.m | 1833 | 9467fda468d37b1befa5f4ac34a9362df430e892638931c1ac7bfd2b641e623a |
| ╘¡╩╝╩²╛▌/╡╪╒≡╢»1.fig | 66788 | a0e74c59d035aebb5b603236a73b46fc9573dd7668355abc3b947f25dc572460 |
| ╘¡╩╝╩²╛▌/╡╪╒≡╢»2.fig | 65391 | c250d5546f7549bf6699e3366ce5cc1c489e760a63d60de746181fdd3c9f6b76 |
| ╘¡╩╝╩²╛▌/╦π└²1GRUloss.fig | 156076 | 35d097e752f7b06ab3acb85d283a66905f122dd612f38b65ea22a348e82fc3d0 |
| ╘¡╩╝╩²╛▌/╦π└²1GRUloss.mat | 80184 | a073211a974dcfc3114652f7235ec865d4a0e1e4caa7129f1b79a94831c03eda |
| ╘¡╩╝╩²╛▌/╦π└²2GRUloss.fig | 262461 | 64fb9aa63555be32ef4351c9f01235069b2793928d8ecb0f264b4e55d4f90730 |
| ╘¡╩╝╩²╛▌/╦π└²2GRUloss.mat | 80184 | 20b2bc3d47d156ea73a79b50df4390e574d55c0133a510cc70b8f54d82f410ce |
| ╘¡╩╝╩²╛▌/═╝5 ╚²╓╓╔ε╢╚╤º╧░─ú╨═╘ñ▓Γ╜ß╣√.fig | 166207 | 6ddc7dea7bb28af2f954b2b86163fcfb9d2a49747e9a58b0837040ce41aaa982 |
| ╘¡╩╝╩²╛▌/═╝8 ╚²╓╓╔ε╢╚╤º╧░─ú╨═╞└╣└╓╕▒Ω▒╚╜╧ú¿─≤┬ú╨º╙ªú⌐.fig | 162515 | fbd4a4715c29d874901f138f0b6680909c9b4f589a1736c1f3e0536261b84b05 |

    Reuse & extensibility
    ---------------------
    • You may extend the examples to other SDOF or bridge‑scale simulations by replacing the
      input .mat files with your own data, keeping variable names consistent.
    • For end‑to‑end training code (data preparation → model training → evaluation), place
      your scripts in a ‘/src’ folder and document them here. If training code lives in the
      public repository, provide a link and commit hash in this section.

    Reproducibility notes
    ---------------------
    • Randomness: precomputed predictions avoid seed sensitivity; if you train new models,
      fix RNG seeds and record software versions.
    • Report the Git commit SHA, OS, MATLAB version, and toolbox versions in your runs.

    Citation
    --------
    If you use this package, please cite the related manuscript and the repository:
    • Manuscript: Digital twin model of a high-speed railway bridge based on deep learning and high-precision prediction of its seismic responses
      (full citation as in the paper’s reference list)
    • Code: https://github.com/m17335722023/BridgeDTM-GRU (release tag v1.0.0). If using Zenodo, include DOI.

    Contact
    -------
    Contact: civilding@seu.edu.cn (Youliang Ding); j00000002962@njit.edu.cn (Fangfang Geng)

    Acknowledgments
    ---------------
    See the manuscript for project funding and acknowledgments.

    Changelog
    ---------
    v1.0.0 — Initial public release accompanying the manuscript.

    中文快速说明（简要）
    -------------------
    • 本压缩包包含：MATLAB 脚本（untitled.m）、Bouc–Wen 示例数据（1/2data_DOFBoucWen.mat）、
      预计算预测结果（1/2model_prediction.mat）以及若干 .fig 图。
    • 直接在 MATLAB 中加载 .mat 数据与预测结果，按脚本中的注释修改 n 值并运行，即可复现对比图与 loss 曲线。
    • 如遇中文文件名乱码，请使用 7‑Zip 并选择 UTF‑8 再次解压。
    • 本项目已在 GitHub 公布：https://github.com/m17335722023/BridgeDTM-GRU ，许可证 Apache‑2.0。