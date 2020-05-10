weight = read.csv("weights.csv")
#把NA填上0
weight[is.na(weight)] = 0
weight = weight[order(as.numeric(rownames(weight)), decreasing = T),,drop = FALSE]
weight$X = as.character(weight$X)

#################################
m_weight = data_frame()
for(row in 1:dim(weight)[1]){
  #weight[row,][["X"]] #該row的季標籤
  sea = strsplit(weight[row,][["X"]], ' ')[[1]][2] #只看第幾季
  if(sea == "Q1"){
    dupli = rbind(weight[row,], weight[row,], weight[row,])
    rownames(dupli) = c(strsplit(weight[row,][["X"]], ' ')[[1]][1] + "-01",
                        strsplit(weight[row,][["X"]], ' ')[[1]][1] + "-02",
                        strsplit(weight[row,][["X"]], ' ')[[1]][1] + "-03")
  }else if(sea == "Q2"){
    dupli = rbind(weight[row,], weight[row,], weight[row,])
    rownames(dupli) = c(strsplit(weight[row,][["X"]], ' ')[[1]][1] + "-04",
                        strsplit(weight[row,][["X"]], ' ')[[1]][1] + "-05",
                        strsplit(weight[row,][["X"]], ' ')[[1]][1] + "-06")
  }else if(sea == "Q3"){
    dupli = rbind(weight[row,], weight[row,], weight[row,])
    rownames(dupli) = c(strsplit(weight[row,][["X"]], ' ')[[1]][1] + "-07",
                        strsplit(weight[row,][["X"]], ' ')[[1]][1] + "-08",
                        strsplit(weight[row,][["X"]], ' ')[[1]][1] + "-09")
  }else if(sea == "Q4"){
    dupli = rbind(weight[row,], weight[row,], weight[row,])
    rownames(dupli) = c(strsplit(weight[row,][["X"]], ' ')[[1]][1] + "-10",
                        strsplit(weight[row,][["X"]], ' ')[[1]][1] + "-11",
                        strsplit(weight[row,][["X"]], ' ')[[1]][1] + "-12")
  }
  #再把複製的row rbind起來
    m_weight = rbind(m_weight, dupli)
}
#################################

#把rowname放作一個col
m_weight$X = rownames(m_weight)
colnames(m_weight)[1] = "Date"
#或者把month拿掉
#m_weight = m_weight[,2:59]

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
min(m_weight$Date)
max(m_weight$Date)
rdf = rdf[rdf$Date >=min(m_weight$Date) & rdf$Date<=max(m_weight$Date), ]

#取一樣個股的資料（在return中沒的資料就捨棄weight）
m_weight = m_weight[,colnames(rdf)]

#拿掉日期
rdf = rdf[,2:48]
m_weight = m_weight[,2:48]

#就可以直接row by row相乘
Rp = rdf*m_weight
#把NA填上0
Rp[is.na(Rp)] = 0
Rp = apply(Rp, 1, sum)
summary(Rp)

#接著就丟進Fama & French
fama = read.csv("F-F_Research_Data_5_Factors_2x3.csv")
