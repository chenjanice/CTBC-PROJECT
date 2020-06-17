# CTBC Project
- 中信金第二組 : 投資名人堂
- Team Member : 曹泓鈞 陳柏瑜 陳佳淳 朱秦立 

# About us
### BTS&P Co. 
**Want to invest the Right target ?   
Why not choose to invest in Right person ?**

# 期末報告連結
[中信金CTBC_投資名人堂－投資因子分析_第二組](https://www.canva.com/design/DAD_VybQInQ/s2ptae3My8bXvohuJxfyCA/view?utm_content=DAD_VybQInQ&utm_campaign=designshare&utm_medium=link&utm_source=sharebutton)


## Content
- [Bill Ackman](https://github.com/chenjanice/CTBC-PROJECT#bill-ackman)
- [All Super Investor](https://github.com/chenjanice/CTBC-PROJECT#regression)
- [Self-Constructed Portfolio](https://github.com/chenjanice/CTBC-PROJECT#self-constructed-portfolio)
- [ChatBot](https://github.com/chenjanice/CTBC-PROJECT#chatbot)



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
>  - [Regression結果](https://github.com/chenjanice/CTBC-PROJECT/blob/master/Bill%20Ackman's%20Portfolio%20Return/readme.md)
## All Super Investor
> ### Preprocessing
> 1. Crawling Portfolio Weightings on Dataroma
> 2. Crawling Stock Prices from Yahoo Finance
> 3. Apply the matrix product on the two dataframe in R in order to get portfolio returns in different month.
> 4. Combine the port folio return with monthly fama 5 factors, and then run the regression.
>
> ### Regression
> * Fama French 5-factor Model
> ![R_p = \alpha + \beta_1 MKT + \beta_2 SMB + \beta_3 HML + \beta_4 RMW + \beta_5 CMA + u_i](https://render.githubusercontent.com/render/math?math=R_p%20%3D%20%5Calpha%20%2B%20%5Cbeta_1%20MKT%20%2B%20%5Cbeta_2%20SMB%20%2B%20%5Cbeta_3%20HML%20%2B%20%5Cbeta_4%20RMW%20%2B%20%5Cbeta_5%20CMA%20%2B%20u_i)
>
> ### Regression_Data
>   -  [All output](https://github.com/chenjanice/CTBC-PROJECT/tree/master/ALL%20Super%20Investors'%20Portfolio/ALL%20Super%20Investors'%20Portfolio%20in%20R/reg%20output/regression%20table)
>   -  [All Price](https://github.com/chenjanice/CTBC-PROJECT/blob/master/ALL%20Super%20Investors'%20Portfolio/ALL%20Super%20Investors'%20Portfolio%20in%20R/raw%20data/ALL_Prices.csv)
>   -  [Weight](https://github.com/chenjanice/CTBC-PROJECT/tree/master/ALL%20Super%20Investors'%20Portfolio/ALL%20Super%20Investors'%20Portfolio%20in%20R/raw%20data/super_investors)
>   -  [Weight(No shortening)](https://github.com/chenjanice/CTBC-PROJECT/tree/master/ALL%20Super%20Investors'%20Portfolio/ALL%20Super%20Investors'%20Portfolio%20in%20R/raw%20data/super_investors_without_shortening)
>   -  [5Factors](https://github.com/chenjanice/CTBC-PROJECT/blob/master/ALL%20Super%20Investors'%20Portfolio/ALL%20Super%20Investors'%20Portfolio%20in%20R/raw%20data/F-F_Research_Data_5_Factors_2x3.CSV)
> 
> ### Regression_Code
> - [All Stock](https://github.com/chenjanice/CTBC-PROJECT/blob/master/ALL%20Super%20Investors'%20Portfolio/2020-05-09_ALL_STOCKS.ipynb)
>   -  [Factor_Construct](https://github.com/chenjanice/CTBC-PROJECT/tree/master/Factor_Construct)
> - Dataroma
>   - [0509](https://github.com/chenjanice/CTBC-PROJECT/blob/master/ALL%20Super%20Investors'%20Portfolio/2020-05-09_Dataroma.ipynb)
>   - [0514](https://github.com/chenjanice/CTBC-PROJECT/blob/master/ALL%20Super%20Investors'%20Portfolio/2020-05-14_Dataroma.ipynb)

## Self-Constructed Portfolio
> - [Raw data](https://github.com/chenjanice/CTBC-PROJECT/tree/master/Self-Constructed%20Portfolio/raw%20data)
>   - [Investors](https://github.com/chenjanice/CTBC-PROJECT/tree/master/Self-Constructed%20Portfolio/raw%20data/Investors)
>   - [S&P500](https://github.com/chenjanice/CTBC-PROJECT/tree/master/Self-Constructed%20Portfolio/raw%20data/SP500)
> - [S&P500_Returns](https://github.com/chenjanice/CTBC-PROJECT/blob/master/Self-Constructed%20Portfolio/01%20-%20SP500_Returns_0528.R)
> - [Lasso_Weight](https://github.com/chenjanice/CTBC-PROJECT/blob/master/Self-Constructed%20Portfolio/02%20-%20Lasso_weight_0530-3.R)
> - [Output](https://github.com/chenjanice/CTBC-PROJECT/tree/master/Self-Constructed%20Portfolio/R%20files/output)

## ChatBot
> - [Project](https://github.com/chenjanice/CTBC-PROJECT/tree/master/chatbot)

  
