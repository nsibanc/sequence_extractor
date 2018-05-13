#!/usr/bin/env Rscript
args <- commandArgs(trailingOnly = TRUE)

library(vegan)
library(car)
 

Kar_cor<-read.table(args[1], header=TRUE, sep="\t", row.names=1, dec=",")
Kar_cor_ENV<-read.table(args[2], header=TRUE, sep="\t", row.names=1, dec=",")

Kar_cor_ENV$Dat <- paste(Kar_cor_ENV$Year, Kar_cor_ENV$Month, sep="_")
 
PCH <- as.numeric(as.factor(Kar_cor_ENV$veg))+15
COL <- as.character(Recode(Kar_cor_ENV$location, "'Cern'='green'; 'Pet'='blue'; 'Soc'='red'"))

ord <- metaMDS(Kar_cor)
metaMDS(comm = Kar_cor)
sco <- scores(ord)

x11()
for(izbor in args[-(1:2)]){
	plot(ord, type="n")
	points(ord, display = "species", cex = 0.8, pch=21, col="grey", bg="grey")
	select <- which(Kar_cor_ENV$Dat==izbor)
	points(sco[select,], cex = 0.8, pch=PCH[select], col=COL[select])
	title(izbor)
}
locator(1)
