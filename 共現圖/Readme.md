# HW3  文字探勘共現性進行資料視覺化

## 目標
- 透過持股資料、研究Bill Ackman 在挑選投組時是否存在關聯性
- 透過Bill Ackman新聞的歷年新聞、觀察其作風與反應

## DATA來源
- [CNBC](https://www.cnbc.com/bill-ackman/?page=2)
- [DATA ROMA](https://www.dataroma.com/m/home.php)
# EDA
![image](https://raw.githubusercontent.com/chenjanice/CTBC-PROJECT/master/HW3/images/1.png)
![image](https://raw.githubusercontent.com/chenjanice/CTBC-PROJECT/master/HW3/images/2.png)
![image](https://raw.githubusercontent.com/chenjanice/CTBC-PROJECT/master/HW3/images/3.png)
![image](https://raw.githubusercontent.com/chenjanice/CTBC-PROJECT/master/HW3/images/4.png)
![image](https://raw.githubusercontent.com/chenjanice/CTBC-PROJECT/master/HW3/images/5.png)


# 歷年持股共現圖
1. 讀取歷年持股資料
![image](https://raw.githubusercontent.com/chenjanice/CTBC-PROJECT/master/HW3/images/h1.png)
2. Co-Occurence Martrix
![image](https://raw.githubusercontent.com/chenjanice/CTBC-PROJECT/master/HW3/images/h2.png)
3. 持股關係共現圖
![image](https://raw.githubusercontent.com/chenjanice/CTBC-PROJECT/master/HW3/images/h3.png)
4. 持股關係熱度圖
![image](https://raw.githubusercontent.com/chenjanice/CTBC-PROJECT/master/HW3/images/h4.png)

-------------------
# 歷年新聞共現圖
1. 美股新聞
![image](https://raw.githubusercontent.com/chenjanice/CTBC-PROJECT/master/HW3/images/n1.png)
2. 載入金融字典
3. 詞性分類：動詞/名詞/形容詞
4. 歷年新聞共現圖（金融字典篩選＋動詞＋形容詞）
![image](https://raw.githubusercontent.com/chenjanice/CTBC-PROJECT/master/HW3/images/n2.png)
4. 歷年新聞共現圖（動詞＋形容詞+名詞）
![image](https://raw.githubusercontent.com/chenjanice/CTBC-PROJECT/master/HW3/images/n3.png)
5. 歷年新聞熱度圖（金融字典篩選＋動詞＋形容詞）
![image](https://raw.githubusercontent.com/chenjanice/CTBC-PROJECT/master/HW3/images/n4.png)
