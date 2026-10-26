# Q3: Individual earnings by age and weighted five-year means.
library(readr); library(dplyr); library(ggplot2)
dat <- read_csv("outputs/analysis_data.csv", show_col_types=FALSE)
bands <- read_csv("outputs/q3_age_band_table_R.csv", show_col_types=FALSE)
set.seed(570346)
dat <- dat |> mutate(jitter_age=age+runif(n(),-.4,.4))
highest <- bands |> slice_max(weighted_mean_earnings,n=1,with_ties=FALSE)
p <- ggplot(dat,aes(x=jitter_age,y=earn_annual)) +
  geom_point(alpha=.14,size=.85,color="#7663A6") +
  geom_line(data=bands,aes(x=age_midpoint,y=weighted_mean_earnings),inherit.aes=FALSE,color="#E07A5F",linewidth=1.1) +
  geom_point(data=filter(bands,!thin_band),aes(x=age_midpoint,y=weighted_mean_earnings),inherit.aes=FALSE,color="#263746",size=2.7) +
  geom_point(data=filter(bands,thin_band),aes(x=age_midpoint,y=weighted_mean_earnings),inherit.aes=FALSE,shape=1,color="#263746",size=3,stroke=1) +
  geom_text(data=highest,aes(x=age_midpoint,y=weighted_mean_earnings,label=paste0("Peak band: ",age_band)),inherit.aes=FALSE,vjust=-1,size=3.5,color="#263746") +
  scale_y_log10(limits=c(10000,10000000)) + scale_x_continuous(breaks=seq(15,65,5),limits=c(14.5,64.5)) +
  labs(title="Earnings across the life course: individual records and age-band averages",
       subtitle="Punjab • Urban • positive earnings • age 15–64",x="Age (years)",y="Annual earnings (PKR, log scale)") +
  theme_minimal(base_size=12) + theme(plot.title=element_text(face="bold"),panel.grid.minor=element_blank())
ggsave("figures/q3_earnings_by_age.svg",p,width=9.5,height=6)
print(bands)
