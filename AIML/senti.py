from textblob import TextBlob
# Input text
text = "This mobile phone is excellent and very easy to use."
# Sentiment analysis
analysis = TextBlob(text)
# Print polarity
print("Sentiment Polarity:", analysis.sentiment.polarity)
# Classify sentiment
if analysis.sentiment.polarity > 0:
    print("Positive Sentiment")
elif analysis.sentiment.polarity < 0:
    print("Negative Sentiment")
else:
    print("Neutral Sentiment")