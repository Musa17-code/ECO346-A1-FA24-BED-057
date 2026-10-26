# Q2: Weighted histogram with ten-bin-per-log-decade widths.
library(readr); library(ggplot2)
dat <- read_csv("outputs/analysis_data.csv", show_col_types=FALSE)
s <- read_csv("outputs/q2_summary_R.csv", show_col_types=FALSE)
p10 <- s$weighted_p10; med <- s$weighted_median; p90 <- s$weighted_p90
dat$log10_earn <- log10(dat$earn_annual)
p <- ggplot(dat, aes(x=log10_earn, weight=hhweight)) +
  geom_histogram(aes(y=after_stat(density)), breaks=seq(4,7,by=.1), closed="left",
                 fill="#2A9D8F", color="#FAF8F2", linewidth=.25) +
  geom_vline(xintercept=log10(med), color="#263746", linetype="dashed", linewidth=.9) +
  geom_vline(xintercept=log10(p90), color="#E07A5F", linetype="dotted", linewidth=1.0) +
  scale_x_continuous(breaks=4:7, labels=c("10,000","100,000","1,000,000","10,000,000"), limits=c(4,7)) +
  labs(title="Where do urban Punjab earners fall in the income distribution?",
       subtitle=paste0("N = ",format(s$final_sample_n,big.mark=",")," | weighted p10 PKR ",format(p10,big.mark=","),
                      " | p90/p10 = ",round(p90/p10,2)),
       x="Annual earnings (PKR, logarithmic axis)", y="Weighted density per log10 unit") +
  theme_minimal(base_size=12) + theme(plot.title=element_text(face="bold"), panel.grid.minor=element_blank())
ggsave("figures/q2_weighted_histogram.svg",p,width=9.5,height=5.6)
print(p)
