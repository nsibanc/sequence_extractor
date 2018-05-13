#!/usr/bin/env Rscript

# naložiš potrebne pakete
library(vegan)
library(car)

#prebereš podatke iz datotek(karst-cores_otu.txt, karst-cores_env.txt)
Kar_cor<-read.table("karst-cores_otu.txt", header=TRUE, sep="\t", row.names=1, dec=",")
Kar_cor_ENV<-read.table("karst-cores_env.txt", header=TRUE, sep="\t", row.names=1, dec=",")

#dodaš vstico ki ti združi ime leta in meseca
Kar_cor_ENV$Dat <- paste(Kar_cor_ENV$Year, Kar_cor_ENV$Month, sep="_")

#funkcije ki ti določajo obliko
PCH <- as.numeric(as.character(Recode(Kar_cor_ENV$veg, "'For'=16; 'Mead'=17; 'Trans'=18")))
COL <- as.character(Recode(Kar_cor_ENV$location, "'Cern'='green'; 'Pet'='blue'; 'Soc'='red'"))

#statistični magic
ord <- metaMDS(Kar_cor)
metaMDS(comm = Kar_cor)
sco <- scores(ord)

#zanka, ki ti hodi po mesecik in ti nariše pdf za vsakega (zaenkrat samo 2 dodja več če hočeš)
for(izbor in c("2014_Aug","2014_Nov")){
  #odpre(ustvari) pdf datoteko
	pdf(paste(izbor,"pdf",sep="."))
  plot(ord, type="n")
  #vse točke v datasetu
  points(ord, display = "species", cex = 1, pch=21, col="grey", bg="grey")
  #katera vstica je izbrana v env datoteki
  select <- which(Kar_cor_ENV$Dat==izbor)
  #pobarvane točke glede na env datoteko
	points(sco[select,], cex = 1, pch=PCH[select], col=COL[select])
  #legenda
	legend ("bottomright", legend=c("Crnotice", "Petrinje","Socerb", "Meadow", "Transition", "Forest"), col=c("green", "blue", "red", "grey", "grey", "grey"), pch=c(16, 16, 16, 2, 5, 1), cex=1,pt.cex=2)
  #naslov
  title(izbor)
  #zapre pd datotko
	dev.off()
}
