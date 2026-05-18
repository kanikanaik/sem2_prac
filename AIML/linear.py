# Linear Regression Practical
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from sklearn.linear_model import LinearRegression
# Sample Data (Experience vs Salary)
X = np.array([[1], [2], [3], [4], [5]])
y = np.array([20000, 25000, 30000, 35000, 40000])
# Create Model
model = LinearRegression()
# Train Model
model.fit(X, y)
# Prediction
predicted_salary = model.predict([[6]])
print("Predicted Salary for 6 years experience:", predicted_salary)
# Plot Graph
plt.scatter(X, y)
plt.plot(X, model.predict(X))
plt.xlabel("Experience")
plt.ylabel("Salary")
plt.title("Linear Regression")
plt.show()