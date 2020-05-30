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
library(glmnet) #Lasso

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

#Read S&P500 成分股return
rSP500 = read.csv("raw data/rS&P500.csv")
rSP500$Date = as.Date(rSP500$Date)
#Read investor's return
rInvestors = read.csv("raw data/rInvestors.csv")
rInvestors$Date = as.Date(rInvestors$Date)

#Use only S&P100
#SP100_sym = strsplit(x = "AAPL ABBV ABT ACN ADBE AIG ALL AMGN AMT AMZN AXP BA BAC BIIB BK BKNG BLK BMY BRK.B C CAT CHTR CL CMCSA COF COP COST CRM CSCO CVS CVX DD DHR DIS DOW DUK EMR EXC F FB FDX GD GE GILD GM GOOG GOOGL GS HD HON IBM INTC JNJ JPM KHC KMI KO LLY LMT LOW MA MCD MDLZ MDT MET MMM MO MRK MS MSFT NEE NFLX NKE NVDA ORCL OXY PEP PFE PG PM PYPL QCOM RTX SBUX SLB SO SPG T TGT TMO TXN UNH UNP UPS USB V VZ WBA WFC WMT XOM", split = " ")
#SP100_sym = c('AAPL','ABBV','ABT','ACN','ADBE','AIG','ALL','AMGN','AMT','AMZN','AXP','BA','BAC','BIIB','BK','BKNG','BLK','BMY','BRK.B','C','CAT','CHTR','CL','CMCSA','COF','COP','COST','CRM','CSCO','CVS','CVX','DD','DHR','DIS','DOW','DUK','EMR','EXC','F','FB','FDX','GD','GE','GILD','GM','GOOG','GOOGL','GS','HD','HON','IBM','INTC','JNJ','JPM','KHC','KMI','KO','LLY','LMT','LOW','MA','MCD','MDLZ','MDT','MET','MMM','MO','MRK','MS','MSFT','NEE','NFLX','NKE','NVDA','ORCL','OXY','PEP','PFE','PG','PM','PYPL','QCOM','RTX','SBUX','SLB','SO','SPG','T','TGT','TMO','TXN','UNH','UNP','UPS','USB','V','VZ','WBA','WFC','WMT','XOM')

#rSP100 = rSP500[,c("Date", SP100_sym)]
#rSP100$Date = as.Date(rSP100$Date)

##############################################################
### Lasso ####

#weight是505 by 1的vector
dim(rInvestors)
dim(rSP500)
beta = rnorm(dim(rSP500)[2])

#Y是特定投資人的portfolio return
#Y = rInvestors[c("Date", "psc")]
Y = rInvestors[c("Date", "LPC")]
Y = na.omit(Y)

#X是S&P500成分股的各期Return，根據Y有資料的期間決定期間
X = rSP500[rSP500$Date>=min(Y$Date) & rSP500$Date<=max(Y$Date),]


#X是S&P100成分股的各期Return，根據Y有資料的期間決定期間
#X = rSP100[rSP100$Date>=min(Y$Date) & rSP100$Date<=max(Y$Date),]

#如果在Y的期間內，X有na，就drop那該欄
#temp = subset(X, !is.na(colnames(X)[2])) #用subset只能一次挑一欄來刪
#dim(temp)

#轉置後刪掉有na的row，再轉置回來
#X = X %>% t %>% na.omit %>% t
#X = t(X)
#X = na.omit(X)
#X = t(X)
#X = as.data.frame(X)
#dim(X)
#colnames(X)
#X$Date = as.Date(X$Date)

#法二：把na填上0 ##有問題，需謹慎
X[is.na(X)] = -10^6


#先另存時間標籤
date_preserved = Y$Date
date_preserved == X$Date

#去掉時間標籤
Y = as.matrix(Y[, 2])
#X = as.matrix(X[,2:length(X)])
X = X[,2:length(X)]
dim(Y); dim(X)
class(X)
X = as.matrix(X)
#######################################################
#K>n 解釋變數數量k=505大於樣本數n
#Recall our OLS estimator: beta_hat = (X'X)^(-1)X'Y
solve(t(X)%*%X)%*%t(X)%*%Y #OLS is not feasible
summary(lm(Y~X))

#Trying different tuning parameter: lambda
grid = 10^seq(10, -2, length = 100)
lasso.mod = glmnet(X, Y, alpha = 1, lambda = grid, intercept = F)
plot(lasso.mod)

#先用Cross Validation找出合適的lambda
#ref: https://www.youtube.com/watch?v=ctmNq7FgbvI
##############################################################

train_rows = sample(1:length(Y), 0.66*length(Y))
X.train = X[train_rows,]
X.test = X[-train_rows,]

Y.train = Y[train_rows,]
Y.test = Y[-train_rows,]

#Obtain the optimal lambda through cross validation
alpha1.fit = cv.glmnet(X.train, Y.train, type.measure = "mse", alpha = 1, family = "gaussian")

alpha1.predict = predict(alpha1.fit, s = alpha1.fit$lambda.1se, newx = X.test)

mean((Y.test - alpha1.predict)^2)

alpha1.fit$lambda.1se

################################################
#看表現


lasso.coef = predict(lasso.mod, type = 'coefficients', s = alpha1.fit$lambda.1se)
lasso.coef
lasso.coef[lasso.coef>0 | lasso.coef<0]
sum(lasso.coef)
lasso.coef@Dimnames[[1]][lasso.coef@i+1] #有找出weight的stock name
print(c(lasso.coef@Dimnames[[1]][lasso.coef@i+1], lasso.coef@x))

###
P_weight_found = data.frame(lasso.coef@Dimnames[[1]][lasso.coef@i+1], as.numeric(lasso.coef@x))
colnames(P_weight_found) = c("Stock", "weight")
sum(P_weight_found[,2]) #sum of weight
P_weight_found = t(P_weight_found)
colnames(P_weight_found) = lasso.coef@Dimnames[[1]][lasso.coef@i+1]
#P_weight_found = drop(as.numeric(P_weight_found[2,]))

#看表現 -> 把自建的portfolio 拿去跑 5 factor model
Rp_star = 0 #自建的portfolio return
for(s in colnames(P_weight_found)){
  temp = rSP500[s]*as.numeric(P_weight_found[,s][2])
  temp[is.na(temp),] = 0
  Rp_star = Rp_star+temp
}
colnames(Rp_star) = "Rp_star"
#抓期間
Test_table = cbind(rSP500, Rp_star)
Test_table = drop(Test_table[c("Date", "Rp_star")])
Test_table = merge(fama, Test_table, by = "Date", all = T) #併到fama table
hist(Test_table$Rp_star, freq = F)

#Run Regression
reg1 = lm(Rp_star~Mkt.RF,
          data = Test_table)
summary(reg1)
reg2 = lm(Rp_star~Mkt.RF+SMB+HML,
          data = Test_table)
summary(reg2)
reg3 = lm(Rp_star~Mkt.RF+SMB+HML+RMW+CMA,
          data = Test_table)
summary(reg3)
reg4 = lm(Rp_star~Mkt.RF+SMB+HML+RMW+CMA+R_ME,
          data = Test_table)
summary(reg4)
reg5 = lm(Rp_star~Mkt.RF+SMB+HML+RMW+CMA+R_IA,
          data = Test_table)
summary(reg5)
reg6 = lm(Rp_star~Mkt.RF+SMB+HML+RMW+CMA+R_ROE,
          data = Test_table)
summary(reg6)
reg7 = lm(Rp_star~Mkt.RF+SMB+HML+RMW+CMA+R_ME+R_IA+R_ROE,
          data = Test_table)
summary(reg7)
##############################################################

##Questions:
#1. 如何限定只要估出（比如）20個coef? => 調整lambda?
#2. 如何限定估出的beta總和是1? => 自行修改objective fcn

#Try
#1. 試著用`nlm()`寫寫看非套件的版本
#2. 試著自行修改objective fcn

##############################################################



beta = rnorm(dim(X)[2])
beta = as.matrix(beta)

dim(X); dim(beta)
#Def L2-norm
norm_vec = function(x){sqrt(sum(x^2))}
#Def L1-norm
norm_vec = function(x){sum(abs(x))}


lambda = 10

loss_fcn = function(beta, lambda=30, mu = 1){
  loss = t(Y-X%*%beta)%*%(Y-X%*%beta) + lambda*norm_vec(beta) + mu*(1-sum(beta))
  loss = as.numeric(loss)
  return(loss)
}
#Not added to 1
loss_fcn = function(beta, lambda=10){
  loss = t(Y-X%*%beta)%*%(Y-X%*%beta) + lambda*norm_vec(beta)
  loss = as.numeric(loss)
  return(loss)
}


#loss_fcn(rnorm(dim(X)[2]))
#est_lasso = nlm(loss_fcn, rnorm(dim(X)[2]), print.level = 2, iterlim = 1000, steptol = 10^(-3))
est_lasso$estimate[est_lasso$estimate>0.01 | est_lasso$estimate< (-0.01)]
sum(est_lasso$estimate[est_lasso$estimate>0.01 | est_lasso$estimate< (-0.01)]); sum(est_lasso$estimate)
length(est_lasso$estimate[est_lasso$estimate>0.01 | est_lasso$estimate< (-0.01)])

#est_lasso = optim(rnorm(dim(X)[2]), loss_fcn)
sum(est_lasso$par)


#############################################################################
# Normalized weight to 1
#看表現
###
P_weight_found = data.frame(lasso.coef@Dimnames[[1]][lasso.coef@i+1], as.numeric(lasso.coef@x))
colnames(P_weight_found) = c("Stock", "weight")
sum_of_weight = sum(P_weight_found[,2]) #sum of weight
P_weight_found = t(P_weight_found)
colnames(P_weight_found) = lasso.coef@Dimnames[[1]][lasso.coef@i+1]

#看表現 -> 把自建的portfolio 拿去跑 5 factor model
Rp_star = 0 #自建的portfolio return
for(s in colnames(P_weight_found)){
  temp = rSP500[s]*as.numeric(P_weight_found[,s][2])/sum_of_weight #一個個股在所有的期間都只用一個weight
  temp[is.na(temp),] = 0 #如果沒有資料，算做zero return
  Rp_star = Rp_star+temp
}
colnames(Rp_star) = "Rp_star"

#抓期間
Test_table = cbind(rSP500, Rp_star)
Test_table = drop(Test_table[c("Date", "Rp_star")]) #至此，是所有S&P500有價格資料期間的
##要跟investor開始的時間一樣
#把自建的portfolio bind起來
Test_table = merge(fama, Test_table, by = "Date", all = T) #併到fama table
#把investor的portfolio bind起來
Test_table = merge(Test_table, rInvestors[c("Date", "LPC")], by = "Date", all = T) #併到fama table

hist(na.omit(Test_table$Rp_star), breaks = 50) #全部期間的return
plot(density(na.omit(Test_table$Rp_star)))
plot(Test_table$Date, Test_table$Rp_star, type = "l")

################################################################
#投組單位價格價格折線圖
par(mfrow = c(2,2))
#$1 #全部期間的倍數
Rp_star_ = Test_table$Rp_star[!is.na(Test_table$Rp_star)]
Rp_star_date = Test_table$Date[!is.na(Test_table$Rp_star)]
price = 1
accum_price = c()
for(i in Rp_star_){
  price = price*(1+i)
  accum_price = cbind(accum_price, price)
}
plot(Rp_star_date, accum_price, type = 'l', xlab = "year", ylab = "Dollars (initial value = $1)",
     main = "Performance of Self-Constructed Portfolio")

#期間跟Mandell一樣的話
Rp_star_ = Test_table$Rp_star[!is.na(Test_table$LPC)]
Rp_star_date = Test_table$Date[!is.na(Test_table$LPC)]
price = 1
accum_price = c()
for(i in Rp_star_){
  price = price*(1+i)
  accum_price = cbind(accum_price, price)
}
plot(Rp_star_date, accum_price, type = 'l', xlab = "year", ylab = "Dollars (initial value = $1)",
     main = "Performance of Self-Constructed Portfolio")


##compared to Mandell
rInvestor_ = rInvestors["LPC"][rInvestors$Date>=min(Rp_star_date) & rInvestors$Date<=max(Rp_star_date),]
rInvestor__date = rInvestors$Date[rInvestors$Date>=min(Rp_star_date) & rInvestors$Date<=max(Rp_star_date)]

rInvestor__date = rInvestor__date[!is.na(rInvestor_)]
rInvestor_ = rInvestor_[!is.na(rInvestor_)]

price = 1
accum_price_rInvestor = c()
for(i in rInvestor_){
  price = price*(1+i/100)
  accum_price_rInvestor = cbind(accum_price_rInvestor, price)
}
plot(rInvestor__date, accum_price_rInvestor, type = 'l', xlab = "year", ylab = "Dollars (initial value = $1)",
     main = "Performance of Mandell")

##compared to S&P500
#同樣的期間
rSP500_ = fama$rSP500[fama$Date>=min(Rp_star_date) & fama$Date<=max(Rp_star_date)]
rSP500__date = fama$Date[fama$Date>=min(Rp_star_date) & fama$Date<=max(Rp_star_date)]
price = 1
accum_price_rSP500 = c()
for(i in rSP500_){
  price = price*(1+i)
  accum_price_rSP500 = cbind(accum_price_rSP500, price)
}
plot(rSP500__date, accum_price_rSP500, type = 'l', xlab = "year", ylab = "Dollars (initial value = $1)",
     main = "Performance of S&P500")

################################################################

#畫在同一張圖
par(mfrow = c(2,2))
#Self-Constructed Port
plot(Rp_star_date, accum_price, type = 'l', xlab = "year", ylab = "Dollars (initial value = $1)",
     main = "Performance of Self-Constructed Portfolio")
#全部期間回測
plot(Rp_star_date, accum_price, type = 'l', xlab = "year", ylab = "Dollars (initial value = $1)",
     main = "Performance of Self-Constructed Portfolio")
#同期Mandell績效
plot(rInvestor__date, accum_price_rInvestor, type = 'l', xlab = "year", ylab = "Dollars (initial value = $1)",
     main = "Performance of Mandell")
#同期S&P500績效
plot(rSP500__date, accum_price_rSP500, type = 'l', xlab = "year", ylab = "Dollars (initial value = $1)",
     main = "Performance of S&P500")



################################################################


#Run Regression
reg1 = lm(Rp_star~Mkt.RF,
          data = Test_table)
summary(reg1)
reg2 = lm(Rp_star~Mkt.RF+SMB+HML,
          data = Test_table)
summary(reg2)
reg3 = lm(Rp_star~Mkt.RF+SMB+HML+RMW+CMA,
          data = Test_table)
summary(reg3)
reg4 = lm(Rp_star~Mkt.RF+SMB+HML+RMW+CMA+R_ME,
          data = Test_table)
reg5 = lm(Rp_star~Mkt.RF+SMB+HML+RMW+CMA+R_IA,
          data = Test_table)
summary(reg5)
reg6 = lm(Rp_star~Mkt.RF+SMB+HML+RMW+CMA+R_ROE,
          data = Test_table)
summary(reg6)
reg7 = lm(Rp_star~Mkt.RF+SMB+HML+RMW+CMA+R_ME+R_IA+R_ROE,
          data = Test_table)
summary(reg7)
