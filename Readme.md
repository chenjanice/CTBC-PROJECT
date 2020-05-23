# CTBC Project

## 中信：投資因子分析
 - 投資人1：Bill Ackman
 - 投資人2：Chuck Akre
 - 投資人3：Stephen Mandel


## Bill Ackman
> ### DATA
>  - Bill Ackman歷年新聞   
>    - [CBNC-Bill Ackman](https://github.com/chenjanice/CTBC-PROJECT/blob/master/%E5%85%B1%E7%8F%BE%E5%9C%96/Data_BillAckman%E6%96%B0%E8%81%9E.csv)    
>  - Bill Ackman歷年持股   
>    - [Dataroma-Bill Ackman](https://github.com/chenjanice/CTBC-PROJECT/blob/master/%E5%85%B1%E7%8F%BE%E5%9C%96/Data_%E6%8C%81%E8%82%A1%E8%B3%87%E6%96%99.csv)

>  - Bill Ackman投組報酬
>    - [報酬計算](https://github.com/chenjanice/CTBC-PROJECT/tree/master/Bill%20Ackman's%20Portfolio%20Return/Return%20of%20Portfolio/R)
>    - [Weighting](https://github.com/chenjanice/CTBC-PROJECT/tree/master/Bill%20Ackman's%20Portfolio%20Return/Dataroma%20Weight%20Crawling)
>    - [Yahoo Finance](https://github.com/chenjanice/CTBC-PROJECT/tree/master/Bill%20Ackman's%20Portfolio%20Return/Yahoo%20Finance)
>    - [Bill Ackman經濟預測模型指標](https://github.com/chenjanice/CTBC-PROJECT/tree/master/%E7%B6%93%E6%BF%9F%E9%A0%90%E6%B8%AC%E6%A8%A1%E5%9E%8B/Data)

> ### Project
> - [視覺化資料](https://github.com/chenjanice/CTBC-PROJECT/blob/master/%E5%85%B1%E7%8F%BE%E5%9C%96/%E8%A6%96%E8%A6%BA%E5%8C%96.ipynb)
>  - [共現圖_基金持有](https://github.com/chenjanice/CTBC-PROJECT/blob/master/%E5%85%B1%E7%8F%BE%E5%9C%96/%E5%85%B1%E7%8F%BE%E5%9C%96_%E5%9F%BA%E9%87%91%E6%8C%81%E6%9C%89.ipynb)
>  - [共現圖_美股新聞](https://github.com/chenjanice/CTBC-PROJECT/blob/master/%E5%85%B1%E7%8F%BE%E5%9C%96/%E5%85%B1%E7%8F%BE%E5%9C%96_%E7%BE%8E%E8%82%A1%E6%96%B0%E8%81%9E.ipynb)
>  - [經濟預測模型](https://github.com/chenjanice/CTBC-PROJECT/tree/master/%E7%B6%93%E6%BF%9F%E9%A0%90%E6%B8%AC%E6%A8%A1%E5%9E%8B)
>  - [Regression結果]

 ## Preprocessing

1. Crawling Portfolio Weightings on Dataroma
2. Crawling Stock Prices from Yahoo Finance
3. Apply the matrix product on the two dataframe in R in order to get portfolio returns in different month.
4. Combine the port folio return with monthly fama 5 factors, and then run the regression.

 ## Regression

* Fama French 5-factor Model
  
  ![R_p = \alpha + \beta_1 MKT + \beta_2 SMB + \beta_3 HML + \beta_4 RMW + \beta_5 CMA + u_i](https://render.githubusercontent.com/render/math?math=R_p%20%3D%20%5Calpha%20%2B%20%5Cbeta_1%20MKT%20%2B%20%5Cbeta_2%20SMB%20%2B%20%5Cbeta_3%20HML%20%2B%20%5Cbeta_4%20RMW%20%2B%20%5Cbeta_5%20CMA%20%2B%20u_i)
  
