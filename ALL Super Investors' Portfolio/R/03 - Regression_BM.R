#接著就丟進Fama & French
fama = read.csv("raw/F-F_Research_Data_5_Factors_2x3.csv")

for(i in 1:length(fama$X)){
  fama$X[i] = fama$X[i]+"01"
} ##加上空字串，讓這個column都存string，才可以被time format讀

#set date format and re-naming
fama$X = as.Date(fama$X, "%Y%m%d")
colnames(fama)[1] = "Date"

#取有的資料期間就好
fama = fama[fama$Date>="2016-01-01" & fama$Date<="2019-12-31",]
dim(fama)

fama = cbind(fama, Rp)
dim(fama)

#(rp-rf = Rp)
Rp.Rf = fama$Rp - fama$RF
fama = cbind(fama, Rp.Rf)

#Regression
reg1 = lm(Rp.Rf~Mkt.RF,
          data = fama)
summary(reg1)
reg2 = lm(Rp.Rf~Mkt.RF+SMB+HML,
          data = fama)
summary(reg2)
reg3 = lm(Rp.Rf~Mkt.RF+SMB+HML+RMW+CMA,
          data = fama)
summary(reg3)


#Save file
write.csv(fama_BM, file = "Rp.csv", row.names = F)

#Export Regression Table
library(stargazer)
tex_BM = stargazer(reg1, reg2, reg3, title="Results", align=TRUE)

#輸出LaTeX
write(tex_BM, file = 'table.tex', sep = '')

#HTML Table
#Ref: https://cran.r-project.org/web/packages/sjPlot/vignettes/tab_model_estimates.html