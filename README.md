# ECO346 Assignment 1 — FA24-BED-057

**Course:** ECO346 — Data Visualization Techniques for Economists  
**Student registration:** FA24-BED-057  
**Variant:** 1 (57 mod 8 = 1) — Punjab, urban households  
**Dataset:** PSLM person and household subsets supplied for Assignment 1

## Project map

- `data/` — the supplied person-level and household-level CSV datasets.
- `scripts/01_prepare.R` — joins the files, filters the sample, calculates weighted quantiles and builds the age-band table.
- `scripts/02_q2_histogram.R` — weighted earnings histogram on the log10 scale.
- `scripts/03_q3_age.R` — jittered age/earnings scatter with five-year weighted mean overlays.
- `scripts/04_q4_default.R` — intentionally plain baseline scatterplot for the design comparison.
- `scripts/05_q5_python.py` — Python replication of the weighted age-band table and a corresponding SVG chart.
- `outputs/` — filtered data, summary values, age-band tables and short written interpretations.
- `figures/` — SVG figures plus PNG previews for the slides.
- `slides/FA24-BED-057.pptx` — four-slide presentation draft.

## How to run in RStudio

1. Open `ECO346-A1-FA24-BED-057.Rproj`.
2. Run `scripts/01_prepare.R` first. It creates `analysis_data.csv`, `q2_summary_R.csv` and `q3_age_band_table_R.csv` inside `outputs/`.
3. Run `scripts/02_q2_histogram.R`, then `scripts/03_q3_age.R`, then `scripts/04_q4_default.R`.
4. From a terminal opened in the project root, run `python scripts/05_q5_python.py` to reproduce the Q3 table and Python SVG.

Required R packages: `readr`, `dplyr`, `ggplot2`, `svglite`. Python packages: `pandas`, `numpy`, `matplotlib`.

## Sample definition

Join people to household data using `hhid`, retain `prov_code == 2` and `urban_rural == 2`, then keep ages 15–64 with positive, non-missing `earn_annual` and a positive, non-missing `hhweight`. Weighted quantiles sort earnings in ascending order and select the smallest earnings value where cumulative weight reaches at least the requested proportion of total weight. Five-year bands use the midpoints 17, 22, …, 62; a band is labelled thin when its unweighted count is below 30.

## Main numbers (confirm after running scripts)

- Analysis sample: **3,768** observations
- Weighted p10: **PKR 96,000**
- Weighted median: **PKR 240,000**; unweighted median: **PKR 240,000**
- Weighted p90: **PKR 660,000**; p90/p10 ratio: **6.875**
- Weighted mean, ages 25–29: **PKR 320,775.81**
- Weighted mean, ages 45–49: **PKR 465,073.38**
- Largest age-band mean: **55-59**, PKR **523,751.39**

Because registration 057 maps to Variant 1, the sample definition and resulting numeric estimates are the same as other students assigned Variant 1. Wording, visual choices, filenames and presentation layout here are specific to this project, but the interpretation should be reviewed and explained by the student.

## GitHub submission sequence — do this deliberately

Create a public repository named `ECO346-A1-FA24-BED-057`. To respect the required before/after sequence, do not upload all figures in one initial commit:

1. Commit the README, data, scripts, outputs and **only** `figures/default.svg` in the first commit.
2. Commit `figures/q2_weighted_histogram.svg` and `figures/q3_earnings_by_age.svg` in a later commit that adds the redesigned visualizations.
3. Add the remaining files and slides in separate meaningful commits until there are at least five commits overall.

Before submission, run the R scripts locally, compare the R and Python age-band tables to the nearest rupee, open the SVGs and all four PowerPoint slides, update any wording to what you understand, then complete the assigned Google Form. Creating this ZIP does not publish a GitHub repository or submit the form.
