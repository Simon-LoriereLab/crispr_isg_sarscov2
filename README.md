# ISG focused CRISPR/Cas9 knockout screen for SARS-CoV-2

This repository contains [MAGeCK](https://sourceforge.net/projects/mageck/) (DOI: [10.1186/s13059-014-0554-4](https://doi.org/10.1186/s13059-014-0554-4)) output of CRISPR/Cas9 ISG screen of cells infected or non-infected with SARS-CoV-2, which is supplementary information to the preprint article (DOI: [10.1101/2021.05.06.442916](https://doi.org/10.1101/2021.05.06.442916)). If sharing these data, please cite the publication in complement or instead of this repository.

![MAGeCK scores plot for antivaral (positive) on proviral (negative) ISGs ](./manhattan_plot/mageck_score_plot.png)
*The R code used to generate the plot here [mageck_score_gene_plot.R](./manhattan_plot/mageck_score_gene_plot.R)*

MAGeCK was run with the following command:
```bash
mageck test -k read_count_table.txt -t Lib_isg_sort -c Lib_isg_ctrl -n MageckLibISG_CoVclust --pdf-report --keep-tmp --sort-criteria pos
```

MAGeCK input data [read_count_table.txt](./mageck/read_count_table.txt) and default output are provided in [mageck_output](./mageck).

Sample description, raw sequencing data and mapping analysis are provided in GEO (GSE173418).


[Data](./mageck) - [![License: CC BY 4.0](https://licensebuttons.net/l/by/4.0/80x15.png)](https://creativecommons.org/licenses/by/4.0/).
[Manhattan plot](./manhattan_plot/mageck_score_gene_plot.R) - [![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)
