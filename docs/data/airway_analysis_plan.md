# Analysis plan: dexamethasone response in airway smooth muscle cells

*Example `plan.md` for the course. Keep it in the project root, update it after every step, and read it at the start of each new session.*

## 1. Question

Which genes change expression when human airway smooth muscle cells are treated with dexamethasone (a glucocorticoid), and are the changes consistent with known glucocorticoid biology?

## 2. Data

- `data/counts.csv`: raw gene-level counts, 63,677 Ensembl genes x 8 samples. **Read-only. Never modify.**
- `data/coldata.csv`: sample sheet. Key columns: `cell` (cell line, 4 lines), `dex` (`untrt` / `trt`).
- Source: Bioconductor `airway` package (GEO series GSE52778, Himes et al. 2014). Human, Illumina RNA-seq, 4 cell lines each with and without dexamethasone.
- Annotation: Ensembl gene IDs. **[verify]** which genome build / Ensembl release the counts used before doing any ID mapping or coordinate work.

## 3. Design and decisions

| Decision | Choice | Why | Status |
|---|---|---|---|
| Software | R, DESeq2 | Standard count-based model for bulk RNA-seq, designed for small n | decided |
| Design formula | `~ cell + dex` | Each cell line was treated and untreated, so this is a paired design; `cell` absorbs line-to-line differences | decided |
| Contrast | `dex`: `trt` vs `untrt` | A positive log2 fold change then means higher in treated | decided |
| Gene filter | keep genes with at least 10 counts in at least 4 samples | Remove near-empty genes before testing; threshold is a starting point, report how many genes remain | **[check]** |
| Normalization | DESeq2 size factors for testing; variance stabilizing transform for PCA and heatmaps only | Raw counts go into the model, transformed values are for visualization only | decided |
| Significance | adjusted p-value (Benjamini-Hochberg) < 0.05, no fold-change cutoff at first | Control the false discovery rate; look at the effect-size distribution before deciding on a cutoff | **[check]** |
| Fold-change shrinkage | apply shrinkage for ranking and plots, report unshrunk values in tables | Noisy low-count genes otherwise dominate the extremes | **[check]** |
| Sample exclusion | none planned | Only exclude with a written reason decided *before* seeing the DE results | decided |
| Random seed | 42 for anything stochastic | Reproducibility | decided |

## 4. Steps, with expectations written before running

Work **one step at a time**. After each step: look at the output, compare it with the expectation, and record what happened in section 7.

| Step | What to do | What I expect to see |
|---|---|---|
| 1. Load and check | Read counts and sample sheet, confirm sample order matches, count genes and samples | 63,677 genes, 8 samples, sample IDs identical in both files |
| 2. QC | Library sizes, count distributions, filter genes | Library sizes of similar magnitude (a few tens of millions of counts); many genes with zero counts; roughly 20,000 genes remain after filtering |
| 3. Exploration | PCA and sample-distance heatmap on VST data | Samples separate by cell line on at least one early PC; treatment effect visible on a later PC or within each cell line |
| 4. Test | Fit DESeq2 with `~ cell + dex`, extract results | A few thousand genes at adjusted p < 0.05; p-value histogram with a spike near 0 and a flat tail |
| 5. Check controls | Look at known glucocorticoid-responsive genes, for example *DUSP1*, *FKBP5*, *PER1*, *KLF15* | These should be up in treated samples. If they are not, suspect a labelling or contrast error |
| 6. Interpret | MA plot, volcano plot, top gene table, optional pathway analysis | Pathway results should be treated as hypotheses, checked against the gene tables |
| 7. Report | One Quarto report that runs from raw files to figures | Every number and figure traceable to code |

## 5. Reproducibility

- Project folder layout: `data/` (read-only inputs), `scripts/`, `results/`, `reports/`, `plan.md`, `CLAUDE.md`.
- Pin the software environment (`environment.yml` or `renv.lock`) before the first analysis step. Do not update packages mid-project.
- All analysis lives in saved code. No numbers or plots from chat answers.
- Record in the final report: R and package versions (`sessionInfo()`), AI tool and exact model name and version, date.
- Put the project under git, on a branch, and commit after each reviewed step.

## 6. Hard lines (also in `CLAUDE.md`)

- Never modify or delete anything in `data/`.
- Do not install or update packages without asking.
- Do only the step I ask for, then stop and wait for my review.
- Ask before running anything that takes more than a few minutes.

## 7. Log (update after each step)

| Date | Step | What I found | Surprises | Decision for next step |
|---|---|---|---|---|
| | | | | |

## 8. Open questions

- Is the filter threshold reasonable for this sample size?
- Do the treatment effects differ between cell lines, and is a simple `~ cell + dex` model adequate?
- Which of the interpretation steps should I take to a bioinformatician before reporting?
