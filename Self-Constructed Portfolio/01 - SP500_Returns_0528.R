library(tidyquant)
library(timetk)
library(dplyr)
#輸出reg用
library(sjPlot)
library(sjmisc)
library(sjlabelled)
library(webshot)
#install phantomjs()
#webshot::install_phantomjs()

#Def 1
`+` <- function(e1, e2) {
  if (is.character(e1) | is.character(e2)) {
    paste0(e1, e2)
  } else {
    base::`+`(e1, e2)
  }
}
#Def 2
str_eval=function(x) {return(eval(parse(text=x)))}


#讀檔
setwd("/Users/Andy 1/Google 雲端硬碟 (r08323004@g.ntu.edu.tw)/0 Semesters/108-2/四234 文字探勘/0 中信 投資因子分析/crawling/Bill Ackman/Making Our Own Portfolio")

#Read Fama
fama = read.csv("raw data/Investors/F-F_Research_Data_5_Factors_2x3.csv")
colnames(fama)[1] = "Date"
for(i in 1:length(fama$Date)){
  fama$Date[i] = fama$Date[i]+"01"
} ##加上空字串，讓這個column都存string，才可以被time format讀
fama$Date = as.Date(fama$Date, "%Y%m%d")

#Read Price
#data = read.csv("raw data/Investors/ALL_Prices.csv")
#data$Date = as.Date(data$Date, "%Y-%m-%d")


#S&P 500's Stock Price
SP500 = read.csv("raw data/SP500/ALL_SP500_Prices.csv")
SP500$Date = as.Date(SP500$Date)
colnames(SP500)
SP500_lst = list()
for(name in colnames(SP500)[2:506]){
  nam = paste("r", name, sep = '.')
  assign(nam, SP500 %>%
           tq_transmute(select = name,
                        mutate_fun = periodReturn,
                        period = "monthly",
                        col_rename = name))
  SP500_lst[length(SP500_lst)+1] = list(str_eval(nam)) #append進list
}

#SP500成分股return (Conti.)
#把yyyy-mm-dd改成yyyy-mm
for(i in 1:length(SP500_lst)){
  #在list裡面
  SP500_lst[[i]]$Date = format(as.Date(SP500_lst[[i]]$Date, "%Y-%m-%d"), "%Y-%m")
}

#Merge rdf
rSP500 = SP500_lst[[1]]
for(SP500_item in SP500_lst[2:length(SP500_lst)]){
  rSP500 = merge(rSP500, SP500_item, by = 'Date', all = T)
}

#save file: S&P500成分股return
write.table(rSP500, "raw data/rS&P500.csv", sep = ',', row.names = F)

#把月資料的日期加上一日
for(i in 1:length(rSP500$Date)){
  rSP500$Date[i] = rSP500$Date[i]+"-01"
}
rSP500$Date = as.Date(rSP500$Date)

#save file: S&P500成分股return
write.table(rSP500, "raw data/rS&P500.csv", sep = ',', row.names = F)

##############################################################
