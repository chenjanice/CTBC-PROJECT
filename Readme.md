# CTBC Project

## 中信：投資因子分析
 - 投資人：Bill Ackman


## DATA
 - EDA
   - [News & Holdings](https://github.com/chenjanice/CTBC-PROJECT/blob/master/HW3_EDA.ipynb)
 - 歷年新聞   
   - [CBNC-Bill Ackman](https://github.com/chenjanice/CTBC-PROJECT/blob/master/BillAckman.csv)    
   - [News-crawler](https://github.com/chenjanice/CTBC-PROJECT/blob/master/CNBC_News_BillAckman.ipynb)
 - 歷年持股   
   - [Dataroma-Bill Ackman](https://github.com/chenjanice/CTBC-PROJECT/blob/master/dataroma_history.csv)

 - 歷年財報 

 ## Preprocessing

1. Crawling Portfolio Weightings on Dataroma
2. Crawling Stock Prices from Yahoo Finance
3. Apply the matrix product on the two dataframe in R in order to get portfolio returns in different month.
4. Combine the port folio return with monthly fama 5 factors, and then run the regression.

 ## Regression

* Fama French 5-factor Model
  
  ![R_p = \alpha + \beta_1 MKT + \beta_2 SMB + \beta_3 HML + \beta_4 RMW + \beta_5 CMA + u_i](https://render.githubusercontent.com/render/math?math=R_p%20%3D%20%5Calpha%20%2B%20%5Cbeta_1%20MKT%20%2B%20%5Cbeta_2%20SMB%20%2B%20%5Cbeta_3%20HML%20%2B%20%5Cbeta_4%20RMW%20%2B%20%5Cbeta_5%20CMA%20%2B%20u_i)
  

 ## Model training

