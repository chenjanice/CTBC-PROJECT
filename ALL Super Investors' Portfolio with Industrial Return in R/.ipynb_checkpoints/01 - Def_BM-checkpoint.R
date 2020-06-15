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
setwd("/Users/Andy 1/Google 雲端硬碟 (r08323004@g.ntu.edu.tw)/0 Semesters/108-2/四234 文字探勘/0 中信 投資因子分析/crawling/Bill Ackman/holdings/ALL Super Investors/ALL Super Investors' Portfolio in R")

#Read Price
data = read.csv("raw data/ALL_Prices.csv")
data$Date = as.Date(data$Date, "%Y-%m-%d")
#data = data[data$Date>="2016-01-01",]


#讀權重 investor by investor
#先列出權重的清單
filenames = list.files(getwd()+"/raw data/super_investors")
numfiles = length(filenames)

#for (i in filenames[1:10]){  
#  name <- gsub("-",".",i)
#  name <- gsub(".csv","",name)  
#  assign(name,read.csv(i, header=FALSE))
#}

for(file in filenames[1:5]){
  file_path = getwd()+"/raw data/super_investors/"+file
  weight = read.csv(file_path, header=T)
  #把NA填上0
  weight[is.na(weight)] = 0
  stock_names = colnames(weight)
  only_data = data[stock_names]
  only_weight = weight[colnames(data)[2:length(data)]]
  #only_weight = colnames(only_weight)
}






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
