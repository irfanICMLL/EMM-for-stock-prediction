
# EMM-for-stock-prediction
We propose a model to analyze sentiment of online stock forum and use the information to predict stock volatility in the Chinese market. By generating a sentimental dictionary, we analyze the sentimental tendencies of each post as sentiment indicators. Such sentimental information will be fused with market data for prediction based on Recurrent Neural Networks (RNNs). We manually labeled the sentiment of forum post and make the data public available for research. Empirical evidence shows that 8 of the 10 stocks perform better with sentimental indicators.

Code for reproducing main results in the paper [Stock Volatility Prediction Using Recurrent
Neural Networks with Sentiment Analysis](https://arxiv.org/abs/1705.02447) by Yifan Liu, Zengchang Qin, Pengyu Li, Tao Wan

### Dependencies
python 2.7 for sentiment analysis

matlab for stock prediction

please add the folder "stock_pre_tool" to the path of the matlab

### Dependencies
sentiment analysis/data: orginal comments with label

stock_pre_tool/stock_price.xlsx: orginal prices for stocks


### Quick start

EMM-for-stock-prediction/stock_pre_tool/total_analysis/ get the accuracy from main.m. The pre-processing data is already in the folder named with its stock number.

Read EMM-for-stock-prediction/sentiment_analysis/tips.txt to learn how to extract emotion index.

EMM-for-stock-prediction/sentiment_analysis/gen_word/ is used for training the comments classifier and get the emotion weight dictionary.
