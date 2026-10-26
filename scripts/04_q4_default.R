# Q4 baseline: intentionally unmodified ggplot scatterplot.
# Keep this figure as a separate commit before committing redesigned charts.
library(readr); library(ggplot2)
dat <- read_csv("outputs/analysis_data.csv", show_col_types=FALSE)
p <- ggplot(dat, aes(age, earn_annual)) + geom_point()
ggsave("figures/default.svg", p, width=7, height=5)
print(p)
