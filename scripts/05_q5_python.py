"""Q5: independent Python reproduction of the weighted age-band table and chart.
Run from any directory with: python scripts/05_q5_python.py
"""
from pathlib import Path
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
ROOT=Path(__file__).resolve().parents[1]
person=pd.read_csv(ROOT/"data/pslm_person_subset.csv")
hh=pd.read_csv(ROOT/"data/pslm_hh_subset.csv",usecols=["hhid","hhweight","prov_code","urban_rural"])
d=person.merge(hh,on="hhid",how="left",validate="many_to_one")
d=d[(d.prov_code==2)&(d.urban_rural==2)&d.age.between(15,64)&d.earn_annual.notna()&(d.earn_annual>0)&d.hhweight.notna()&(d.hhweight>0)].copy()
d["age_band_start"]=(15+5*np.floor((d.age-15)/5)).astype(int)
d["age_band"]=d.age_band_start.astype(str)+"-"+(d.age_band_start+4).astype(str)
d["age_midpoint"]=d.age_band_start+2
rows=[]
for (start,label,mid),g in d.groupby(["age_band_start","age_band","age_midpoint"],sort=True):
    rows.append({"age_band_start":int(start),"age_band":label,"age_midpoint":int(mid),"n_unweighted":int(len(g)),
                 "weight_sum":float(g.hhweight.sum()),"weighted_mean_earnings":float(np.average(g.earn_annual,weights=g.hhweight)),"thin_band":bool(len(g)<30)})
bands=pd.DataFrame(rows)
( ROOT/"outputs" ).mkdir(exist_ok=True)
bands.to_csv(ROOT/"outputs/q3_age_band_table_Python.csv",index=False,float_format="%.10f")
# A separate, independent rendering of the same age-band pattern.
NAVY="#263746"; CORAL="#E07A5F"; PURPLE="#7663A6"; BG="#FAF8F2"; GRID="#DAD7CD"
plt.rcParams.update({"font.family":"DejaVu Sans","font.size":10,"svg.fonttype":"none"})
rng=np.random.default_rng(570346)
fig,ax=plt.subplots(figsize=(10,6),facecolor=BG); ax.set_facecolor(BG)
ax.scatter(d.age.to_numpy()+rng.uniform(-.4,.4,len(d)),d.earn_annual,s=10,alpha=.14,color=PURPLE,linewidths=0,rasterized=True)
ax.plot(bands.age_midpoint,bands.weighted_mean_earnings,color=CORAL,linewidth=2.4,label="Weighted mean by age band")
normal=bands[~bands.thin_band]; thin=bands[bands.thin_band]
ax.scatter(normal.age_midpoint,normal.weighted_mean_earnings,s=48,color=NAVY,edgecolors=BG,zorder=4)
if len(thin):ax.scatter(thin.age_midpoint,thin.weighted_mean_earnings,s=60,facecolors="none",edgecolors=NAVY,zorder=4)
top=bands.loc[bands.weighted_mean_earnings.idxmax()]
ax.annotate(f"Peak band: {top.age_band}\nPKR {top.weighted_mean_earnings:,.0f}",xy=(top.age_midpoint,top.weighted_mean_earnings),xytext=(top.age_midpoint-9,top.weighted_mean_earnings*1.5),arrowprops={"arrowstyle":"->","color":CORAL},fontsize=9,color=NAVY)
ax.set_yscale("log"); ax.set_ylim(10000,10000000); ax.set_xlim(14.5,64.5); ax.set_xticks(range(15,66,5))
ax.set_xlabel("Age (years)"); ax.set_ylabel("Annual earnings (PKR, log scale)")
ax.set_title("Python reproduction: earnings by age",loc="left",fontweight="bold",fontsize=13)
ax.grid(axis="y",color=GRID,alpha=.7); ax.spines[["top","right","left"]].set_visible(False); ax.spines["bottom"].set_color(GRID); ax.legend(frameon=False,loc="lower right")
fig.tight_layout(); fig.savefig(ROOT/"figures/q3_earnings_by_age_python.svg",format="svg",bbox_inches="tight",facecolor=BG); plt.close(fig)
print(bands.to_string(index=False))
print("25–29 weighted mean (PKR):",format(bands.loc[bands.age_band=="25-29","weighted_mean_earnings"].iloc[0],".2f"))
