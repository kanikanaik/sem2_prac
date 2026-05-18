from sklearn.datasets import load_iris
from sklearn.model_selection import GridSearchCV
from sklearn.neighbors import KNeighborsClassifier
# Load dataset
data = load_iris()
X = data.data
y = data.target
# Model
model = KNeighborsClassifier()
# Hyperparameter grid
param_grid = {'n_neighbors': [3,5,7,9]}
# Grid Search with Cross Validation
grid = GridSearchCV(model, param_grid, cv=5)
grid.fit(X, y)
# Best parameter
print("Best Parameter:", grid.best_params_)
# Best accuracy
print("Best Accuracy:", grid.best_score_)