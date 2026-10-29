## flowchart LR
##   A(Known Task) --> B(All Context Provided)
##   B --> C(Verifiable Output)

## flowchart TB
##   subgraph ONE ["One big prompt"]
##     direction TB
##     L1["Prompt 1<br/>Complete a scRNAseq analysis on this mouse PBMC dataset"]
##     L2{{"Review results"}}
##     L1 --> L2
##   end
## 
##   subgraph STEP ["Step-by-step with checkpoints"]
##     direction TB
##     R1["Prompt 1<br/>With this scRNAseq mouse PBMC dataset read the cells into Seurat in R and do some basic QC. Make a report."]
##     R2{{"Review report<br/>Any QC concerns?"}}
##     R3["Prompt 2<br/>Add filtering for cells with mt rate > 1, regress out cell cycle,<br/>and check for doublets using Scrublet."]
##     R4{{"Re-review results"}}
##     R5(["...and many more steps"])
##     R1 --> R2
##     R2 --> R3
##     R3 --> R4
##     R4 -.-> R5
##   end
## 
##   classDef prompt fill:#23373B,stroke:#23373B,color:#ffffff
##   classDef review fill:#EB811B,stroke:#EB811B,color:#000000
##   classDef more fill:#ffffff,stroke:#999999,stroke-dasharray: 5 5,color:#555555
##   class L1,R1,R3 prompt
##   class L2,R2,R4 review
##   class R5 more

# Pulled live from Bioconductor each time the slides are built
suppressPackageStartupMessages({library(ggplot2); library(dplyr); library(ggrepel)})
scores <- read.delim("https://bioconductor.org/packages/stats/bioc/bioc_pkg_scores.tab", stringsAsFactors = FALSE)
scores <- scores |> arrange(desc(Download_score)) |> mutate(rank = row_number())
lab <- filter(scores, Package %in% c("limma", "DESeq2", "scran", "DropletUtils", "scHiCcompare"))
ggplot(scores, aes(rank, Download_score)) +
  geom_area(fill = "grey85") +
  geom_point(data = lab, colour = "#EB811B", size = 3) +
  geom_text_repel(data = lab, aes(label = Package), seed = 42, min.segment.length = 0,
                  nudge_x = 300, direction = "y", hjust = 0) +
  scale_y_continuous(labels = scales::comma) +
  labs(x = "Package rank (most to least downloaded)", y = "Bioconductor download score",
       title = "Bioconductor packages: a long tail of usage") +
  theme_minimal(base_size = 14)
