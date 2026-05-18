from tensorflow.keras.datasets import mnist
from tensorflow.keras.models import Sequential
from tensorflow.keras.layers import Dense, Flatten
# Load dataset
(X_train, y_train), (X_test, y_test) = mnist.load_data()
# Normalize data
X_train = X_train / 255.0
X_test = X_test / 255.0
# Build model
model = Sequential([
Flatten(input_shape=(28,28)),
Dense(128, activation="relu"),
Dense(10, activation="softmax")
])
# Compile model
model.compile(optimizer="adam",
loss="sparse_categorical_crossentropy",
metrics=["accuracy"])
# Train model
model.fit(X_train, y_train, epochs=5)
# Evaluate model
model.evaluate(X_test, y_test)