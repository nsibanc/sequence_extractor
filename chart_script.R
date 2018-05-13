#!/usr/bin/env Rscript
args <- commandArgs(trailingOnly = TRUE)

library(vegan)
library(car)


Kar_cor<-read.table(args[1], header=TRUE, sep="\t", row.names=1, dec=",")
Kar_cor_ENV<-read.table(args[2], header=TRUE, sep="\t", row.names=1, dec=",")

Kar_cor_ENV$Dat <- paste(Kar_cor_ENV$Year, Kar_cor_ENV$Month, sep="_")

PCH <- as.numeric(as.character(Recode(Kar_cor_ENV$veg, "'For'=16; 'Mead'=17; 'Trans'=18")))
COL <- as.character(Recode(Kar_cor_ENV$location, "'Cern'='green'; 'Pet'='blue'; 'Soc'='red'"))

ord <- metaMDS(Kar_cor)
metaMDS(comm = Kar_cor)
sco <- scores(ord)

for(izbor in args[-(1:2)]){
	pdf(paste(izbor,"pdf",sep="."))
	plot(ord, type="n")
	points(ord, display = "species", cex = 1, pch=21, col="grey", bg="grey")
	select <- which(Kar_cor_ENV$Dat==izbor)
	points(sco[select,], cex = 1, pch=PCH[select], col=COL[select])
	legend ("bottomright", legend=c("Crnotice", "Petrinje","Socerb", "Meadow", "Transition", "Forest"), col=c("green", "blue", "red", "grey", "grey", "grey"), pch=c(16, 16, 16, 2, 5, 1), cex=1,pt.cex=2)
	title(izbor)
	dev.off()
}
