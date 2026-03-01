# %%
from sklearn.datasets import load_digits

digits = load_digits()
X, y = digits['data'], digits['target']

# %%
import matplotlib.pyplot as plt

i = 353
print(y[i])
img = digits['images'][i]
plt.figure(figsize=(4, 4))
plt.imshow(img, cmap='gray')
plt.show()

# %%
img.shape

# %%
X.shape

# %%

"""
Write a pipeline that will learn to predict digits.
It should reduce the number of features to 10 and use a KNeighborsClassifier.

Split the data to train and test, and answer:
- What is the score of the pipeline on the test data?
- What is the size (in kb) of the serialized pipeline?
"""

# %%
from sklearn.decomposition import PCA
from sklearn.pipeline import Pipeline
from sklearn.preprocessing import StandardScaler
from sklearn.model_selection import train_test_split
from sklearn.neighbors import KNeighborsClassifier
import pickle

# %%
pipe = Pipeline([
    ('scaler', StandardScaler()),
    ('pca', PCA(n_components=10)),
    ('knn', KNeighborsClassifier(n_neighbors=5))
])

X_train, X_test, y_train, y_test = train_test_split(
  X, y, 
  test_size=0.3
  )

# %%
pipe.fit(X_train, y_train)
pipe.score(X_test, y_test)

# %%
out_file = "digits.pkl"

with open(out_file, 'wb') as out:
    pickle.dump(pipe, out)

# %%

with open(out_file, 'rb') as out:
    data = out.read()

size_kb = len(data) / 1024

print(f"Model size: {size_kb:.2f} KB")