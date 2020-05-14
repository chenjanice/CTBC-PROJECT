library(tidyquant)
library(timetk)
library(dplyr)
#輸出reg用
library(sjPlot)
library(sjmisc)
library(sjlabelled)

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

#Read Fama
fama = read.csv("raw data/F-F_Research_Data_5_Factors_2x3.csv")
colnames(fama)[1] = "Date"
for(i in 1:length(fama$Date)){
  fama$Date[i] = fama$Date[i]+"01"
} ##加上空字串，讓這個column都存string，才可以被time format讀
fama$Date = as.Date(fama$Date, "%Y%m%d")

#Read Price
data = read.csv("raw data/ALL_Prices.csv")
data$Date = as.Date(data$Date, "%Y-%m-%d")
#data = data[data$Date>="2016-01-01",]


#讀權重 investor by investor
#先列出權重的清單
filenames = list.files(getwd()+"/raw data/super_investors")
numfiles = length(filenames)
#short_filenames = list()
#for (i in filenames){
#  short_filename = strsplit(i, '_')[[1]][1]
#  short_filenames[length(short_filenames)+1] = list(short_filename)
#}


###############################
for(file in filenames){
  short_filename = strsplit(file, '_')[[1]][1] #拿到像是ABC_weight.csv中的"ABC"檔名
  file_path = getwd()+"/raw data/super_investors/"+file
  weight = read.csv(file_path, header=T)
  #把NA填上0
  weight[is.na(weight)] = 0
  #把col: Date填上
  colnames(weight)[1] = "Date"
  #取交集
  intersect_nam = intersect(colnames(data), colnames(weight))
  weight = weight[intersect_nam] #手上有的權重
  price = data[intersect_nam] #手上有的價格資料
  
  #存所有的return
  stocks = list()
  for(stock in colnames(price)[2:length(price)]){
    nam = paste("r", stock, sep = '.')
    assign(nam, price %>%
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
  
  #Merge rdf
  rdf = stocks[[1]]
  for(stock in stocks[2:length(stocks)]){
    rdf = merge(rdf, stock, by = 'Date', all = T)
  }
  
  #把weight從以前排到現在
  weight = weight[order(as.numeric(rownames(weight)), decreasing = T),,drop = FALSE]
  weight$Date = as.character(weight$Date)
  
  #把季資料插成月資料
  m_weight = data_frame()
  for(row in 1:dim(weight)[1]){
    #weight[row,][["Date"]] #該row的季標籤
    sea = strsplit(weight[row,][["Date"]], ' ')[[1]][2] #只看第幾季
    if(sea == "Q1"){
      dupli = rbind(weight[row,], weight[row,], weight[row,])
      rownames(dupli) = c(strsplit(weight[row,][["Date"]], ' ')[[1]][1] + "-01",
                          strsplit(weight[row,][["Date"]], ' ')[[1]][1] + "-02",
                          strsplit(weight[row,][["Date"]], ' ')[[1]][1] + "-03")
    }else if(sea == "Q2"){
      dupli = rbind(weight[row,], weight[row,], weight[row,])
      rownames(dupli) = c(strsplit(weight[row,][["Date"]], ' ')[[1]][1] + "-04",
                          strsplit(weight[row,][["Date"]], ' ')[[1]][1] + "-05",
                          strsplit(weight[row,][["Date"]], ' ')[[1]][1] + "-06")
    }else if(sea == "Q3"){
      dupli = rbind(weight[row,], weight[row,], weight[row,])
      rownames(dupli) = c(strsplit(weight[row,][["Date"]], ' ')[[1]][1] + "-07",
                          strsplit(weight[row,][["Date"]], ' ')[[1]][1] + "-08",
                          strsplit(weight[row,][["Date"]], ' ')[[1]][1] + "-09")
    }else if(sea == "Q4"){
      dupli = rbind(weight[row,], weight[row,], weight[row,])
      rownames(dupli) = c(strsplit(weight[row,][["Date"]], ' ')[[1]][1] + "-10",
                          strsplit(weight[row,][["Date"]], ' ')[[1]][1] + "-11",
                          strsplit(weight[row,][["Date"]], ' ')[[1]][1] + "-12")
    }
    #再把複製的row rbind起來
    m_weight = rbind(m_weight, dupli)
  }
  #把rowname放作一個col (把季標籤換成月)
  m_weight$Date = rownames(m_weight)
  
  #把Return跟Weight的monthly data對齊
  #先給日期
  for(i in 1:length(rdf$Date)){
    rdf$Date[i] = rdf$Date[i]+"-01"
  }
  rdf$Date = as.Date(rdf$Date)
  for(i in 1:length(m_weight$Date)){
    m_weight$Date[i] = m_weight$Date[i]+"-01"
  }
  m_weight$Date = as.Date(m_weight$Date)
  
  #取一樣期間的資料
  rdf = rdf[rdf$Date >=min(m_weight$Date) & rdf$Date<=max(m_weight$Date), ]
  FF = fama[fama$Date >=min(m_weight$Date) & fama$Date<=max(m_weight$Date),]
  
  #先存下來
  out_path_weight = "reg output/paired weight and return/"+short_filename+"_weight.csv"
  out_path_return = 'reg output/paired weight and return/'+short_filename+"_return.csv"
  write.table(rdf, out_path_weight, sep = ',', row.names = F)
  write.table(m_weight, out_path_return, sep = ',', row.names = F)
  
  #拿掉日期
  rdf = rdf[,2:length(rdf)]
  m_weight = m_weight[,2:length(m_weight)]
  #就可以直接row by row相乘
  Rp = rdf*m_weight
  #把NA填上0
  Rp[is.na(Rp)] = 0
  Rp = apply(Rp, 1, sum)
  
  #接著就丟進Fama & French
  FF = cbind(FF, Rp)
  Rp.Rf = FF$Rp - FF$RF
  FF = cbind(FF, Rp.Rf)
  
  #Regression
  reg1 = lm(Rp.Rf~Mkt.RF,
            data = FF)
  summary(reg1)
  reg2 = lm(Rp.Rf~Mkt.RF+SMB+HML,
            data = FF)
  summary(reg2)
  reg3 = lm(Rp.Rf~Mkt.RF+SMB+HML+RMW+CMA,
            data = FF)
  summary(reg3)
  
  #reg out
  reg_out_file = "reg output/"+short_filename+"_reg.html"
  x = tab_model(reg1, reg2, reg3, show.p = T, file = reg_out_file)
  cat(x[["page.style"]], x[["page.complete"]], file = reg_out_file)
}

#cat(x[["page.style"]], x[["page.complete"]], file = reg_out_file)


#tab_model(reg1, reg2, reg3, show.p = T, file = 'reg_out.html')
#Ref: https://cran.r-project.org/web/packages/sjPlot/vignettes/tab_model_estimates.html
