install.packages("waveslim")
library(waveslim)

x = 1:1024
## 
# Figures 4.17 and 4.18 in Gencay, Selcuk and Whitcher (2001).
data(ibm)     
yy = diff(log(ibm))
yy = DJ.EX()$doppler;
yy = ifelse(x <= 100, 0, ifelse(x < 600, 1, 0))
yy = ifelse(x <= 100, 0, ifelse(x < 102, 1, 0))


#yy = ifelse(x <= 100, 0, ifelse(x < 102, 1, 0)); yy; plot(yy, type = "l", axes = FALSE, mmain = "Data signal")
par(mfcol=c(3,1))
## Figures 4.17 and 4.18 in Gencay, Selcuk and Whitcher (2001).

## Haar
dwtoutput <- dwt(yy, wf="d4", n.levels=4, boundary="periodic")
names(dwtoutput) <- c("level1", "level2", "level3", "level4", "smoothed")

# plot default data
par(mfcol=c(6,1), pty="m", mar=c(5-2,4,4-2,2))
plot.ts(yy, axes=FALSE, ylab="", main="Calculating wavelet from specified (yy) signal")

# plot 4 steps of dwt transforms
for(i in 1:4)
  plot.ts(up.sample(dwtoutput[[i]], 2^i), type="h", axes=FALSE,
          ylab=names(dwtoutput)[i])

# plot transformed signal
plot.ts(up.sample(dwtoutput$smoothed, 2^4), type="h", axes=FALSE,
        ylab=names(dwtoutput)[5])

