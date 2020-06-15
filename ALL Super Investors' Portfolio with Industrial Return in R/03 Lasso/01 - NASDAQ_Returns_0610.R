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
setwd("/Users/Andy 1/Google 雲端硬碟 (r08323004@g.ntu.edu.tw)/0 Semesters/108-2/四234 文字探勘/0 中信 投資因子分析/crawling/Bill Ackman/ALL Super Investors' Portfolio with Industrial Return in R")

#Use only NASDAQ + sector=="info tech"

# Sector==
# Sector = read.csv("raw data/產業.csv")
# info_tech_names = Sector[Sector["sector"]=="Information Technology",]["name"]

# NASDAQ Stock Price
NASDAQ = read.csv("02 爬NASDAQ跟科技股股池股價/DASDAQ100&InfoTech_price.csv")
NASDAQ$Date = as.Date(NASDAQ$Date)
colnames(NASDAQ)
NASDAQ_lst = list()
for(name in colnames(NASDAQ)[2:length(colnames(NASDAQ))]){
  nam = paste("r", name, sep = '.')
  assign(nam, NASDAQ %>%
           tq_transmute(select = name,
                        mutate_fun = periodReturn,
                        period = "monthly",
                        col_rename = name))
  NASDAQ_lst[length(NASDAQ_lst)+1] = list(str_eval(nam)) #append進list
}

#SP500成分股return (Conti.)
#把yyyy-mm-dd改成yyyy-mm
for(i in 1:length(NASDAQ_lst)){
  #在list裡面
  NASDAQ_lst[[i]]$Date = format(as.Date(NASDAQ_lst[[i]]$Date, "%Y-%m-%d"), "%Y-%m")
}

#Merge rdf
rNASDAQ = NASDAQ_lst[[1]]
for(NASDAQ_item in NASDAQ_lst[2:length(NASDAQ_lst)]){
  rNASDAQ = merge(rNASDAQ, NASDAQ_item, by = 'Date', all = T)
}

#save file: S&P500成分股return
write.table(rNASDAQ, "03 Lasso/R_output/rNASDAQ.csv", sep = ',', row.names = F)

#把月資料的日期加上一日
for(i in 1:length(rNASDAQ$Date)){
  rNASDAQ$Date[i] = rNASDAQ$Date[i]+"-01"
}
rNASDAQ$Date = as.Date(rNASDAQ$Date)

#save file: S&P500成分股return
write.table(rNASDAQ, "03 Lasso/R_output/rNASDAQ.csv", sep = ',', row.names = F)

##############################################################
