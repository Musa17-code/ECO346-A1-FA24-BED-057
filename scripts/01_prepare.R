# FA24-BED-057 | Variant 1: Punjab urban
# Prepare the weighted analysis sample and five-year age-band table.
pkgs <- c("readr", "dplyr", "ggplot2", "svglite")
missing <- pkgs[!vapply(pkgs, requireNamespace, logical(1), quietly = TRUE)]
if (length(missing)) stop("Install these R packages first: ", paste(missing, collapse=", "))
library(readr); library(dplyr)
dir.create("outputs", showWarnings=FALSE, recursive=TRUE)
person <- read_csv("data/pslm_person_subset.csv", show_col_types=FALSE)
hh <- read_csv("data/pslm_hh_subset.csv", show_col_types=FALSE) |> select(hhid, hhweight, prov_code, urban_rural)
joined <- person |> left_join(hh, by="hhid")
if (any(is.na(joined$hhweight))) stop("Some person records did not match household weights.")
regional <- joined |> filter(prov_code == 2, urban_rural == 2)
age_eligible <- regional |> filter(age >= 15, age <= 64)
analysis <- age_eligible |> filter(!is.na(earn_annual), earn_annual > 0, !is.na(hhweight), hhweight > 0) |>
  mutate(log10_earn=log10(earn_annual), age_band_start=15 + 5*floor((age-15)/5),
         age_band=paste0(age_band_start, "-", age_band_start+4), age_midpoint=age_band_start+2)
write_csv(analysis, "outputs/analysis_data.csv")
wquantile <- function(x, w, p) {
  ok <- !is.na(x) & !is.na(w) & w > 0
  d <- data.frame(x=x[ok], w=w[ok]) |> arrange(x)
  d$x[which(cumsum(d$w) >= p*sum(d$w))[1]]
}
wp10 <- wquantile(analysis$earn_annual, analysis$hhweight, .10)
wmed <- wquantile(analysis$earn_annual, analysis$hhweight, .50)
wp90 <- wquantile(analysis$earn_annual, analysis$hhweight, .90)
summary <- tibble(final_sample_n=nrow(analysis), weighted_p10=wp10, weighted_median=wmed,
                  weighted_p90=wp90, unweighted_median=median(analysis$earn_annual),
                  p90_p10_ratio=wp90/wp10)
write_csv(summary, "outputs/q2_summary_R.csv")
band_table <- analysis |> group_by(age_band_start, age_band, age_midpoint) |>
  summarise(n_unweighted=n(), weight_sum=sum(hhweight),
            weighted_mean_earnings=weighted.mean(earn_annual, hhweight), .groups="drop") |>
  arrange(age_band_start) |> mutate(thin_band=n_unweighted < 30)
write_csv(band_table, "outputs/q3_age_band_table_R.csv")
print(summary); print(band_table)
