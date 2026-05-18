from sklearn.tree import DecisionTreeClassifier
# Training data
X = [[35,50000],[22,20000],[30,35000],[25,18000]]
y = ["Yes","No","Yes","No"]
# Create model
model = DecisionTreeClassifier()
model.fit(X,y)
# Prediction
print(model.predict([[28,30000]]))