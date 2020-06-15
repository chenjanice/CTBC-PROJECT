# Read ME

* This file contains the first step of our project:
  1. We look at Bill Ackman's portfolio on Dataroma
  2. We then crawl his weights.
  3. We find the price of the stock which he invest.
* After that, we run regression of Bill Ackman's portfolio on fama-french 5 factor model.
* We decide to include all investors on dataroma. There are 65 investors.
* We find 15xx stock prices and 65 weights, running 65 regressions.
* We start to construct our own portfolio. That is, we want to find weights in S&P500 stocks.
* 因為想看Stephan Mandell，又是投科技股，所以改成都看科技股，加入NASDQ return

* After the meeting with 石百達老師, we need to modify some approach in finding weights. We not only need to find weights through Lasso, but also have to make our weights a function of good times and bad times.
  * Concept:
    * 基本要求：
    * 1. 權重和是一（接近一）
      2. 權重不可為負
      3. 隨著好的時期與不好的時期而有所不同
    * 我們的做法：
    * 1. 取得S&P500歷年的月報酬，找出quantile：10%-80%-10%，分別切為好-持平-壞的時期，用這些時期來訓練三個不同的lasso regression
      2. Train Set為~2018.12.31；Test Set為2019.1.1~2020
      3. 先不做Moving Window
      4. 投資人先選Stephen Mandell（以科技股為主，要加進NASDQ100的return做控制變數）