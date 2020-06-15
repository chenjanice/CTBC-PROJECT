library(glmnet) #Lasso

#Def 1
`+` <- function(e1, e2) {
  if (is.character(e1) | is.character(e2)) {
    paste0(e1, e2)
  } else {
    base::`+`(e1, e2)
  }
}

#讀檔
setwd("/Users/Andy 1/Google 雲端硬碟 (r08323004@g.ntu.edu.tw)/0 Semesters/108-2/四234 文字探勘/0 中信 投資因子分析/crawling/Bill Ackman/ALL Super Investors' Portfolio with Industrial Return in R/03 Lasso")

#Read Fama
fama = read.csv("raw data/F-F_Research_Data_5_Factors_2x3.csv")
colnames(fama)[1] = "Date"
for(i in 1:length(fama$Date)){
  fama$Date[i] = fama$Date[i]+"01"
} ##加上空字串，讓這個column都存string，才可以被time format讀
fama$Date = as.Date(fama$Date, "%Y%m%d")

# #Read S&P500 成分股return
# rSP500 = read.csv("raw data/rS&P500.csv")
# rSP500$Date = as.Date(rSP500$Date)

#Read investor's return
rInvestors = read.csv("raw data/rInvestors.csv")
rInvestors$Date = as.Date(rInvestors$Date)
 
# #Use only S&P100
# SP100_sym = c('AAPL','ABBV','ABT','ACN','ADBE','AIG','ALL','AMGN','AMT','AMZN','AXP','BA','BAC','BIIB','BK','BKNG','BLK','BMY','BRK.B','C','CAT','CHTR','CL','CMCSA','COF','COP','COST','CRM','CSCO','CVS','CVX','DD','DHR','DIS','DOW','DUK','EMR','EXC','F','FB','FDX','GD','GE','GILD','GM','GOOG','GOOGL','GS','HD','HON','IBM','INTC','JNJ','JPM','KHC','KMI','KO','LLY','LMT','LOW','MA','MCD','MDLZ','MDT','MET','MMM','MO','MRK','MS','MSFT','NEE','NFLX','NKE','NVDA','ORCL','OXY','PEP','PFE','PG','PM','PYPL','QCOM','RTX','SBUX','SLB','SO','SPG','T','TGT','TMO','TXN','UNH','UNP','UPS','USB','V','VZ','WBA','WFC','WMT','XOM')
# rSP100 = rSP500[,c("Date", SP100_sym)]
# rSP100$Date = as.Date(rSP100$Date)
# rm(SP100_sym)

#Use only NASDAQ + sector=="info tech"
rNASDAQ = read.csv("raw data/rNASDAQ.csv")
rNASDAQ$Date = as.Date(rNASDAQ$Date)

##############################################################
### Lasso ####

#Y是特定投資人的portfolio return
#例如Stephen Mandel的Lone Pine Capital (LPC)
CertainInvestor = "LPC"
Y = rInvestors[c("Date", CertainInvestor)]
Y = na.omit(Y)

#X是NASDAQ成分股以及被標為InfoTech的公司的各期Return，根據Y有資料的期間來決定期間
X = rNASDAQ[rNASDAQ$Date>=min(Y$Date) & rNASDAQ$Date<=max(Y$Date),]

#如果在Y的期間內，X包含na，就drop那該欄
col_keep = c()
for(col in colnames(X)){
  if(sum(is.na(X[col]))==0){
    col_keep = c(col_keep, col)
  }
}
X = X[,col_keep]; rm(col_keep); rm(col)
dim(X)


# 把returns of investors and returns of stocks切成train和test
# 2008-01-01~2018-12-31是train；2019-01-01~ 是test
##############################################################
X.train = X[X$Date <= "2018-12-31",]
X.test = X[X$Date > "2018-12-31",]

Y.train = Y[Y$Date <= "2018-12-31",]
Y.test = Y[Y$Date > "2018-12-31",]

# #先另存時間標籤
# date_preserved_X.train = Y.train$Date; date_preserved_X.train == X.train$Date #check: 期間必須一樣
# date_preserved_X.test = Y.test$Date; date_preserved_X.test == X.test$Date #check: 期間必須一樣

#去掉時間標籤，以做矩陣相乘
Y.train = as.matrix(Y.train[, 2])
X.train = as.matrix(X.train[,2:length(X.train)])
dim(X.train); dim(Y.train)

#######################################################
# If K>n 解釋變數數量k大於樣本數n
# Recall our OLS estimator: beta_hat = (X'X)^(-1)X'Y
solve(t(X.train)%*%X.train)%*%t(X.train)%*%Y.train #OLS is not feasible
summary(lm(Y.train~X.train))

# Using Ridge
#Trying different tuning parameter: lambda
lasso.mod = glmnet(X.train, Y.train, alpha = 0, lambda = grid, intercept = F)
plot(lasso.mod, xvar = 'lambda')
plot(lasso.mod)

# Using Elastic Net
#Trying different tuning parameter: lambda
lasso.mod = glmnet(X.train, Y.train, alpha = 0.5, lambda = grid, intercept = F)
plot(lasso.mod, xvar = 'lambda')
plot(lasso.mod)

# Using Lasso
#Trying different tuning parameter: lambda
grid = 10^seq(2, -2, length = 1000)
lasso.mod = glmnet(X.train, Y.train, alpha = 1, lambda = grid, intercept = F)
plot(lasso.mod, xvar = 'lambda')
plot(lasso.mod)


#先用Cross Validation找出合適的lambda
##############################################################

train_rows = sample(1:length(Y.train), 0.66*length(Y.train))
X.tune.train = X.train[train_rows,]
X.tune.test = X.train[-train_rows,]

Y.tune.train = Y.train[train_rows,]
Y.tune.test = Y.train[-train_rows,]

#Obtain the optimal lambda through cross validation: Lasso
lambda = c()
for(i in 1:100){
  alpha1.fit = cv.glmnet(X.tune.train, Y.tune.train, type.measure = "mse", alpha = 1, family = "gaussian")
  alpha1.predict = predict(alpha1.fit, s = alpha1.fit$lambda.1se, newx = X.tune.test)
  mean((Y.tune.test - alpha1.predict)^2)
  lambda = rbind(lambda, alpha1.fit$lambda.1se)
}
hist(lambda); mean(lambda)
lambda = mean(lambda)

################################################
#看看得到的weight
lasso.coef = predict(lasso.mod, type = 'coefficients', s = lambda)
lasso.coef #估出的係數(投資某檔股票的權重)
lasso.coef[lasso.coef>0 | lasso.coef<0] #只看那些不為零的
sum(lasso.coef) #權重之和大於一表示有槓桿

###整理權重的table
P_weight_found = data.frame(lasso.coef@Dimnames[[1]][lasso.coef@i+1], as.numeric(lasso.coef@x))
colnames(P_weight_found) = c("Stock", "weight")
sum_of_weight = sum(P_weight_found[,2]) #sum of weight
P_weight_found = t(P_weight_found)
colnames(P_weight_found) = lasso.coef@Dimnames[[1]][lasso.coef@i+1]

# 依得到的權重建構投資組合並找出Portfolio return
Rp_star = 0
for(s in colnames(P_weight_found)){
  temp = rNASDAQ[s]*as.numeric(P_weight_found[,s][2])
  Rp_star = Rp_star+temp
}
colnames(Rp_star) = "Rp_star"

#拿到對應的時間標籤
Test_table = cbind(rNASDAQ, Rp_star)
Test_table = drop(Test_table[c("Date", "Rp_star")])
#對齊特定投資人所投資的時間
Test_table = merge(fama, Test_table, by = "Date", all = T) #併到fama table
#加入特定投資人的portfolio return
Test_table = merge(Test_table, rInvestors[c("Date", CertainInvestor)], by = "Date", all = T) #併到fama table

# Distribution of Portfolio Return
hist(na.omit(Test_table$Rp_star), breaks = 50) #全部期間的return
plot(density(na.omit(Test_table$Rp_star)))
plot(Test_table$Date, Test_table$Rp_star, type = "l")
plot(Test_table$Date, Test_table$Rp_star, type = "l", xlim = c(min(Test_table$Date[!is.na(Test_table$Rp_star)]), max(Test_table$Date[!is.na(Test_table$Rp_star)])))


# Run Regression: Fama-French 5 Factor Model
# 分成train和test，即2018-12-31前與後
reg1 = lm(Rp_star~Mkt.RF+SMB+HML+NASDAQ,
          data = Test_table[Test_table$Date <= "2018-12-31",])
summary(reg1)
reg2 = lm(Rp_star~Mkt.RF+SMB+HML+RMW+CMA+NASDAQ,
          data = Test_table[Test_table$Date <= "2018-12-31",])
summary(reg2)

# Test
reg3 = lm(Rp_star~Mkt.RF+SMB+HML+NASDAQ,
          data = Test_table[Test_table$Date >= "2018-12-31",])
summary(reg3)
reg4 = lm(Rp_star~Mkt.RF+SMB+HML+RMW+CMA+NASDAQ,
          data = Test_table[Test_table$Date >= "2018-12-31",])
summary(reg4)

################################################################
# Compare Portfolio Return
mean(na.omit(Test_table$Rp_star)); var(na.omit(Test_table$Rp_star))
mean(na.omit(Test_table[,CertainInvestor])); var(na.omit(Test_table[,CertainInvestor]))

#投組單位價格價格折線圖
par(mfrow = c(2,2))
#$1 #無槓桿
Rp_star_ = Test_table$Rp_star[!is.na(Test_table[,CertainInvestor])]
Rp_star_date = Test_table$Date[!is.na(Test_table[,CertainInvestor])]
price = 1
accum_price = c()
for(i in Rp_star_){
  price = price*(1+i/(100*sum_of_weight))
  accum_price = cbind(accum_price, price)
}
plot(Rp_star_date, accum_price, type = 'l', xlab = "year", ylab = "Dollars (initial value = $1)",
     main = "Performance of Self-Constructed Portfolio")

#With Leverage
Rp_star_ = Test_table$Rp_star[!is.na(Test_table[,CertainInvestor])]
Rp_star_date = Test_table$Date[!is.na(Test_table[,CertainInvestor])]
price = 1
accum_price = c()
for(i in Rp_star_){
  price = price*(1+i/100)
  accum_price = cbind(accum_price, price)
}
plot(Rp_star_date, accum_price, type = 'l', xlab = "year", ylab = "Dollars (initial value = $1)",
     main = "Performance of Self-Constructed Portfolio")

##compared to Mandell
rInvestor_ = rInvestors[CertainInvestor][rInvestors$Date>=min(Rp_star_date) & rInvestors$Date<=max(Rp_star_date),]
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
     main = "Performance of "+CertainInvestor)

# ##compared to S&P500
# #同樣的期間
# rSP500_ = fama$rSP500[fama$Date>=min(Rp_star_date) & fama$Date<=max(Rp_star_date)]
# rSP500__date = fama$Date[fama$Date>=min(Rp_star_date) & fama$Date<=max(Rp_star_date)]
# price = 1
# accum_price_rSP500 = c()
# for(i in rSP500_){
#   price = price*(1+i)
#   accum_price_rSP500 = cbind(accum_price_rSP500, price)
# }
# plot(rSP500__date, accum_price_rSP500, type = 'l', xlab = "year", ylab = "Dollars (initial value = $1)",
#      main = "Performance of S&P500")

##compared to NASDAQ
#同樣的期間
rNASDAQ_ = fama$NASDAQ[fama$Date>=min(Rp_star_date) & fama$Date<=max(Rp_star_date)]
rNASDAQ__date = fama$Date[fama$Date>=min(Rp_star_date) & fama$Date<=max(Rp_star_date)]
price = 1
accum_price_rNASDAQ = c()
for(i in rNASDAQ_){
  price = price*(1+i)
  accum_price_rNASDAQ = cbind(accum_price_rNASDAQ, price)
}
plot(rNASDAQ__date, accum_price_rNASDAQ, type = 'l', xlab = "year", ylab = "Dollars (initial value = $1)",
     main = "Performance of NASDAQ100")

graphics.off()
