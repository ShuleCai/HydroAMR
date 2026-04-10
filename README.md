# HydroAMR

## Overview
This repository provides a reproducible workflow for literature-based synthesis and visualization of hydrocycle-related antimicrobial resistance (AMR) research. The project includes R scripts for generating figures, pre-processed input tables and RDS objects, and exported PDF graphics. Running a script in `Scripts/` from the project root regenerates its corresponding figure file(s) in `Figures/`.

## Directory structure
```text
HydroAMR/
├── README.md
├── LICENSE
├── Data/
│   ├── Fig1a.csv
│   ├── Fig1b.csv
│   ├── Fig1c.rds
│   ├── Fig1d.rds
│   ├── Fig2a_income.csv
│   ├── Fig2a_region.csv
│   ├── Fig2b.csv
│   ├── Fig3a.csv
│   ├── Fig3b.csv
│   ├── Fig3c.csv
│   ├── Fig3d.csv
│   ├── Fig3e.csv
│   ├── Fig3f.csv
│   ├── Fig3g_hydro.csv
│   ├── Fig3g_other.csv
│   ├── Fig4_country.csv
│   ├── Fig4_total.csv
│   ├── Fig5_palette.rds
│   ├── Fig5b.csv
│   ├── Fig5b_total.csv
│   ├── Fig5c.csv
│   ├── Fig5c_total.csv
│   ├── Fig5e.csv
│   ├── Fig5e_total.csv
│   ├── Fig5f.csv
│   └── Fig5f_total.csv
├── Figures/
│   ├── Fig1a.pdf
│   ├── Fig1b.pdf
│   ├── Fig1c.pdf
│   ├── Fig1d.pdf
│   ├── Fig2a.pdf
│   ├── Fig2b.pdf
│   ├── Fig3a.pdf
│   ├── Fig3b.pdf
│   ├── Fig3c.pdf
│   ├── Fig3d.pdf
│   ├── Fig3e.pdf
│   ├── Fig3f.pdf
│   ├── Fig3g.pdf
│   ├── Fig4a.pdf
│   ├── Fig4d.pdf
│   ├── Fig5abc.pdf
│   └── Fig5def.pdf
└── Scripts/
    ├── Fig1a.R
    ├── Fig1b.R
    ├── Fig1c.R
    ├── Fig1d.R
    ├── Fig2a.R
    ├── Fig2b.R
    ├── Fig3a.R
    ├── Fig3b.R
    ├── Fig3c.R
    ├── Fig3d.R
    ├── Fig3e.R
    ├── Fig3f.R
    ├── Fig3g.R
    ├── Fig4.R
    ├── Fig5abc.R
    └── Fig5def.R
```

## Requirements
* R (version 4.0 or higher recommended).
* Packages used across scripts: `ComplexHeatmap`, `dplyr`, `extrafont`, `ggpattern`, `ggplot2`, `ggrepel`, `ggthemes`, `gridExtra`, `patchwork`, `RColorBrewer`, `scatterpie`, `scales`, `stringr`, `tibble`, `tidyr`, `viridis`.

## Instruction of scripts
### Figure 1
- `Scripts/Fig1a.R` reads `Data/Fig1a.csv` → `Figures/Fig1a.pdf`: [**Figure 1a**](./Figures/Fig1a.pdf) shows the annual number of hydrocycle-related AMR studies compared with other AMR studies.
- `Scripts/Fig1b.R` reads `Data/Fig1b.csv` → `Figures/Fig1b.pdf`: [**Figure 1b**](./Figures/Fig1b.pdf) shows yearly publication trends for hydrology-related, other, and total AMR studies.
- `Scripts/Fig1c.R` reads `Data/Fig1c.rds` → `Figures/Fig1c.pdf`: [**Figure 1c**](./Figures/Fig1c.pdf) maps the country-level proportion of hydrocycle-related AMR publications.
- `Scripts/Fig1d.R` reads `Data/Fig1d.rds` → `Figures/Fig1d.pdf`: [**Figure 1d**](./Figures/Fig1d.pdf) maps the number of hydrocycle-related AMR publications per million population.

### Figure 2
- `Scripts/Fig2a.R` reads `Data/Fig2a_region.csv` and `Data/Fig2a_income.csv` → `Figures/Fig2a.pdf`: [**Figure 2a**](./Figures/Fig2a.pdf) shows side-by-side comparisons of hydrocycle-related publication intensity and total AMR output across world regions and income groups.
- `Scripts/Fig2b.R` reads `Data/Fig2b.csv` → `Figures/Fig2b.pdf`: [**Figure 2b**](./Figures/Fig2b.pdf) shows the relationship between total publications and hydrocycle-related publications per million population across regions.

### Figure 3
- `Scripts/Fig3a.R` reads `Data/Fig3a.csv` → `Figures/Fig3a.pdf`: [**Figure 3a**](./Figures/Fig3a.pdf) shows a yearly heatmap of publication frequencies across environmental settings such as treatment plants, aquaculture, agriculture, and natural waters.
- `Scripts/Fig3b.R` reads `Data/Fig3b.csv` → `Figures/Fig3b.pdf`: [**Figure 3b**](./Figures/Fig3b.pdf) shows a symbol-coded comparison of environmental settings across the total dataset, income groups, and regions.
- `Scripts/Fig3c.R` reads `Data/Fig3c.csv` → `Figures/Fig3c.pdf`: [**Figure 3c**](./Figures/Fig3c.pdf) shows a yearly heatmap of publication frequencies for major technical methods used in the literature.
- `Scripts/Fig3d.R` reads `Data/Fig3d.csv` → `Figures/Fig3d.pdf`: [**Figure 3d**](./Figures/Fig3d.pdf) shows a symbol-coded comparison of technical methods across the total dataset, income groups, and regions.
- `Scripts/Fig3e.R` reads `Data/Fig3e.csv` → `Figures/Fig3e.pdf`: [**Figure 3e**](./Figures/Fig3e.pdf) shows a yearly heatmap of AST-related sub-methods, including microbial culturing, MICs, isolate identification, and chromosomal sequencing.
- `Scripts/Fig3f.R` reads `Data/Fig3f.csv` → `Figures/Fig3f.pdf`: [**Figure 3f**](./Figures/Fig3f.pdf) shows a symbol-coded comparison of AST-related sub-methods across the total dataset, income groups, and regions.
- `Scripts/Fig3g.R` reads `Data/Fig3g_hydro.csv` and `Data/Fig3g_other.csv` → `Figures/Fig3g.pdf`: [**Figure 3g**](./Figures/Fig3g.pdf) shows smoothed temporal trends of technical-method use in hydrocycle-related AMR studies versus other AMR studies.

### Figure 4
- `Scripts/Fig4.R` reads `Data/Fig4_total.csv` and `Data/Fig4_country.csv` → `Figures/Fig4a.pdf` and `Figures/Fig4d.pdf`: [**Figure 4a**](./Figures/Fig4a.pdf) shows a radial bar chart of topic frequencies across four major AMR topic categories, and [**Figure 4d**](./Figures/Fig4d.pdf) shows a country-by-topic bubble chart of publication counts and proportions.

### Figure 5
- `Scripts/Fig5abc.R` reads `Data/Fig5_palette.rds`, `Data/Fig5b.csv`, `Data/Fig5b_total.csv`, `Data/Fig5c.csv`, and `Data/Fig5c_total.csv` → `Figures/Fig5abc.pdf`: [**Figure 5abc**](./Figures/Fig5abc.pdf) summarizes hydrocycle-related publication share, hydro-only share, and the research-area composition of publication counts across aquaculture, wastewater, water, human, other animal, other environment, and plant topics.
- `Scripts/Fig5def.R` reads `Data/Fig5_palette.rds`, `Data/Fig5e.csv`, `Data/Fig5e_total.csv`, `Data/Fig5f.csv`, and `Data/Fig5f_total.csv` → `Figures/Fig5def.pdf`: [**Figure 5def**](./Figures/Fig5def.pdf) summarizes hydrocycle-related publication share, hydro-only share, and the research-area composition of funding amounts since 2017 across the same topic groups.

## Usage
1. Install R and the packages listed above.
2. Open the project with the repository root as the working directory.
3. Run any script in `Scripts/` to regenerate the corresponding PDF figure(s).
4. Generated outputs are written to `Figures/`.
