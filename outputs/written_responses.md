# Working answers — FA24-BED-057

## Q2 interpretation (under 80 words)

For this urban Punjab sample, 3,768 earners aged 15–64 remain after excluding records outside the age range or without positive annual earnings. The weighted and unweighted medians are both PKR 240,000. The weighted 10th percentile is PKR 96,000, while the 90th percentile is PKR 660,000; their ratio is 6.88. This gap indicates a sizeable spread between lower-end and upper-end earnings in the retained sample.

## Q3 interpretation (under 100 words)

The age-band averages rise overall from younger adulthood to later working ages, but the progression is uneven. The weighted mean is PKR 320,776 for ages 25–29 and PKR 465,073 for ages 45–49. The highest five-year-band mean is PKR 523,751 among ages 55-59. The scattered individual observations overlap widely, so the age pattern describes an association rather than showing that age alone determines annual earnings.

## Q4 design changes (under 150 words)

The redesigned version makes five choices. First, it uses a direct title and labels that spell out the age and PKR earnings measures. Second, annual earnings use a logarithmic axis to show low and high values together without letting the upper tail dominate the display. Third, transparent points and small horizontal age jitter make dense clusters easier to see. Fourth, a contrasting line and markers summarize the household-weighted mean for each five-year age group. Finally, the highest-mean group is called out with an annotation, while restrained grid lines keep attention on the data. The baseline `default.svg` remains a separate unmodified scatterplot for the before-and-after comparison.

## Q5 cross-language comparison (under 80 words)

The independent Python calculation returns PKR 320,775.81 for the 25–29 age band. The R script uses the same retained rows, household weights and weighted-mean definition, so its result should agree to the nearest rupee. After running both programs, compare `q3_age_band_table_R.csv` with `q3_age_band_table_Python.csv`; any displayed decimal differences should be checked against the full-precision values before reporting agreement.
