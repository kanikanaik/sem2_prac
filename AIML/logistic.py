# Logistic Regression Practical
import numpy as np
from sklearn.linear_model import LogisticRegression


# Sample Data (Study Hours vs Pass(1)/Fail(0))
X = np.array([[1], [2], [3], [4], [5], [6]])
y = np.array([0, 0, 0, 1, 1, 1])
# Create Model
model = LogisticRegression()
# Train Model
model.fit(X, y)
# Prediction
prediction = model.predict([[3.5]])
print("Prediction (0 = Fail, 1 = Pass):", prediction)