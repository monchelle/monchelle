# What is the mean speed (mile/hour) in taxi.parquet?

# - Run download_data.py to download the data
# %%
import numpy as np
import pandas as pd
import seaborn as sb
import matplotlib.pyplot as plt

df = pd.read_parquet(r'C:\Users\Monchelle\OneDrive\Documents\Python\DS_Foundations_Python_Scientific_Stack\Ch03\challenge\taxi.parquet')

# %%
dist = df.trip_distance

times = df['tpep_dropoff_datetime'] - df['tpep_pickup_datetime']

times = times[times > pd.Timedelta(0)]

times_hour = times / pd.Timedelta(1, 'hour')

speed = dist / times_hour

# %%
times.describe()

# %%
speed.mean()
# %%
