# E7 ELISA FEC

library(httr)
library(Rmisc)
library(RCurl)

##### add clean tables
E1_std <- "https://raw.githubusercontent.com/derele/Eimeria_Lab/master/data/3_recordingTables/E7_112018_Eim_fecal_ELISAs/E7_112018_Eim_FEC_ELISA1_std.csv"
E1_std <- read.csv(text = getURL(E1_std))

E1_samples <- "https://raw.githubusercontent.com/derele/Eimeria_Lab/master/data/3_recordingTables/E7_112018_Eim_fecal_ELISAs/E7_112018_Eim_FEC_ELISA1_samples.csv"
E1_samples <- read.csv(text = getURL(E1_samples))
E1_samples$label <- sub("^", "E7", E1_samples$label)

###### use drc to construct standard curve and pinpointprotein content

model1<-drm(OD~Conc,
            fct=LL.4(names=c("Slope", "Lower", "Upper", "ED50")),
            data=E1_std)
plot(model1)

E1<-ED(model1, E1_samples$OD, type="absolute", display=F)
row.names(E1) <- E1_samples$label

points(y=E1_samples$OD,x=E1[,1],col="lightblue",pch=19,cex=2)
text(y =E1_samples$OD, x = E1[,1], labels=E1_samples$label, data=E1, cex=0.9, font=2)

E1 <- data.frame(E1)
colnames(E1)[1] <- "IFNy"
E1 <- dplyr::select(E1, IFNy)
# the 0 replacement is just temporary
E1[E1=="NaN"]<- 0
# write out plate 1
write.csv(E1, "./Eimeria_Lab/data/3_recordingTables/E7_112018_Eim_fecal_ELISAs/E7_112018_Eim_FEC_ELISA1_clean.csv")

#load in plate 2
E2_std <- "https://raw.githubusercontent.com/derele/Eimeria_Lab/master/data/3_recordingTables/E7_112018_Eim_fecal_ELISAs/E7_112018_Eim_FEC_ELISA2_std.csv"
E2_std <- read.csv(text = getURL(E2_std))

E2_samples <- "https://raw.githubusercontent.com/derele/Eimeria_Lab/master/data/3_recordingTables/E7_112018_Eim_fecal_ELISAs/E7_112018_Eim_FEC_ELISA2_samples.csv"
E2_samples <- read.csv(text = getURL(E2_samples))
E2_samples$label <- sub("^", "E7", E2_samples$label)

model2<-drm(OD~Conc,
            fct=LL.4(names=c("Slope", "Lower", "Upper", "ED50")),
            data=E2_std)

plot(model1)

E2<-ED(model2, E2_samples$OD, type="absolute", display=F)
row.names(E2) <- E2_samples$label

points(y=E2_samples$OD,x=E2[,1],col="lightblue",pch=19,cex=2)
text(y =E2_samples$OD, x = E2[,1], labels=E2_samples$label, data=E2, cex=0.9, font=2)

E2 <- data.frame(E2)
colnames(E2)[1] <- "IFNy"
E2 <- dplyr::select(E2, IFNy)
# the 0 replacement is just temporary
E2[E2=="NaN"]<- 0
# write out plate 1
write.csv(E1, "./Eimeria_Lab/data/3_recordingTables/E7_112018_Eim_fecal_ELISAs/E7_112018_Eim_FEC_ELISA2_clean.csv")

##### merge and combine in a big table
E7_ELISAs <- rbind(E1, E2)

write.csv(E7_ELISAs, "./Eimeria_Lab/data/3_recordingTables/E7_112018_Eim_fecal_ELISAs/E7_112018_Eim_FEC_ELISAs_complete.csv")
