# GitHub checklist — FA24-BED-057

This file is a practical checklist. The project ZIP does not create a GitHub repository or submit the assignment form.

## Create the public repository

1. Sign in to GitHub and create a **public** repository named `ECO346-A1-FA24-BED-057`.
2. On Windows, install/open GitHub Desktop and choose **Add an Existing Repository** if using the local project folder. If it says the folder is not a Git repository, choose **Create a Repository** and select the `ECO346-A1-FA24-BED-057` project folder.
3. Check the repository path points to the extracted project folder, not the ZIP and not a parent Downloads folder.

## Preserve the required Q4-before-redesign history

The assignment asks that the untouched default chart be committed before the redesigned charts. Before your first commit, temporarily move these three files outside the project folder (for example, to a temporary folder on your Desktop):

- `figures/q2_weighted_histogram.svg`
- `figures/q2_weighted_histogram.png`
- `figures/q3_earnings_by_age.svg`
- `figures/q3_earnings_by_age.png`

Do **not** move `figures/default.svg`. Make the first commit with the project setup, data, scripts, outputs, README and `figures/default.svg`. Use a message such as `Add project setup and Q4 baseline figure`.

Then move the four redesigned figure files back into `figures/` and commit them with a clear message such as `Add redesigned weighted earnings figures`. Keep the Python reproduction figure (`q3_earnings_by_age_python.svg`) for a separate later commit after the Python script has been run.

## Make at least five meaningful commits

For example:

1. `Add project setup and Q4 baseline figure`
2. `Add weighted Q2 histogram`
3. `Add redesigned Q3 age earnings plot`
4. `Add Python replication and comparison table`
5. `Add four-slide presentation and final interpretation notes`

Commit messages should match the changes actually included. If using GitHub Desktop, review the changed-file list before each commit.

## Before submission

- Run `scripts/01_prepare.R`, `02_q2_histogram.R`, `03_q3_age.R`, and `04_q4_default.R` from RStudio.
- Run `python scripts/05_q5_python.py` and compare `outputs/q3_age_band_table_R.csv` with `outputs/q3_age_band_table_Python.csv` to the nearest rupee.
- Open the two redesigned SVGs and the four-slide PowerPoint.
- Submit the Google Form separately, including the public repository URL and the requested results/responses.
