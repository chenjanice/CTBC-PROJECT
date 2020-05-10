library(tidyquant)
library(timetk)
library(dplyr)
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
setwd("/Users/Andy 1/Google 雲端硬碟 (r08323004@g.ntu.edu.tw)/0 Semesters/108-2/四234 文字探勘/0 中信 投資因子分析/crawling/Bill Ackman/holdings/R/preserved_0509")

#Yahoo Finance
data = read.csv("raw/Bill_Miller_Price.csv")
data$Date = as.Date(data$Date, "%Y-%m-%d")
data = data[data$Date>="2016-01-01",]

weight = read.csv("raw/Bill_Miller_weights.csv")
#把NA填上0
weight[is.na(weight)] = 0
stock_names = colnames(weight)
only_weight = weight[colnames(data)[2:length(data)]]
only_weight = colnames(only_weight)



#存所有的return
stocks = list()
for(stock in colnames(data)[2:length(data)]){
  nam = paste("r", stock, sep = '.')
  assign(nam, data %>%
           tq_transmute(select = stock,
                        mutate_fun = periodReturn,
                        period = "monthly",      # This argument calculates Monthly returns
                        col_rename = stock))
  stocks[length(stocks)+1] = list(str_eval(nam)) #append進list
}

#把yyyy-mm-dd改成yyyy-mm
for(i in 1:length(stocks)){
  stocks[[i]]$Date = format(as.Date(stocks[[i]]$Date, "%Y-%m-%d"), "%Y-%m")
}

#Merge
rdf = stocks[[1]]
for(stock in stocks[2:47]){
  rdf = merge(rdf, stock, by = 'Date', all = T)
}
