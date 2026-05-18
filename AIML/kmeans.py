from sklearn.cluster import KMeans
import matplotlib.pyplot as plt
# Data points
X = [[45,50],[46,48],[85,90],[88,92],[25,30],[27,28]]
# Apply KMeans
kmeans = KMeans(n_clusters=3)
kmeans.fit(X)
# Print cluster labels
print(kmeans.labels_)
# Plot clusters
plt.scatter([x[0] for x in X], [x[1] for x in X], c=kmeans.labels_)
plt.show()