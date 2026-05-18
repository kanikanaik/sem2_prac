from sklearn.metrics import confusion_matrix, precision_score, recall_score,accuracy_score
# Actual and predicted values
y_true = [1,0,1,1,0,1,0,0,1,0]
y_pred = [1,0,1,0,0,1,0,1,1,0]
# Confusion Matrix
cm = confusion_matrix(y_true, y_pred)
print("Confusion Matrix:")
print(cm)
# Precision
print("Precision:", precision_score(y_true, y_pred))
# Recall
print("Recall:", recall_score(y_true, y_pred))
# Accuracy
print("Accuracy:", accuracy_score(y_true, y_pred))