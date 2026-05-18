from sklearn import svm
# Training data
X = [[150,7],[170,8],[130,6],[140,6.5]]
y = ["Apple","Apple","Orange","Orange"]
# Create SVM model
model = svm.SVC(kernel="linear")
model.fit(X,y)

# Prediction
print(model.predict([[160,7]]))