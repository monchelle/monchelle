# Draw the running track from track.csv
#
# - Sample data to a minute interval
# - Markers should be blue if the height is below 100 meter, otherwise red

import pandas as pd
import folium
import matplotlib.pyplot as plt
from shapely.geometry import Point, Polygon
import numpy as np


df = pd.read_csv('track.csv',
    parse_dates=['time'],
    index_col='time',
)

mid_lat, max_lat = \
    df['lat'].mean(), df['lat'].max() # Calculate the mean and maximum latitude from the DataFrame

mid_lng, max_lng = \
    df['lng'].mean(), df['lng'].max() # Calculate the mean and maximum longitude from the DataFrame

poly = Polygon([
    [mid_lat, mid_lng],
    [mid_lat, max_lng],
    [max_lat, max_lng],
    [max_lat, mid_lng],
]) # Create a polygon using the calculated mean and maximum latitude and longitude

center = [df['lat'].mean(), df['lng'].mean()] # Calculate the center of the map based on the mean latitude and longitude
m = folium.Map(location=center, zoom_start=15) # Create a folium map centered at the calculated location

points = np.stack(poly.exterior.xy).T # Create a list of points from the exterior of the polygon

m.add_child(folium.PolyLine(points)) # Add a polyline to the map using the list of points

def add_marker(row): # Define a function to add a marker for each row in the DataFrame
    loc = tuple(row[['lat', 'lng']]) # Create a tuple of the latitude and longitude for the marker location
    high = row['height'] > 100 # Determine if the height is greater than 100

    marker = folium.CircleMarker(
        loc,
        radius=5,
        color='blue' if high else 'red', # Set the color of the marker based on the height 
        popup=row.name.strftime('%H:%M') # Set the popup to show the time of the marker in hours and minutes format
    )
    marker.add_to(m)

df.apply(add_marker, axis=1) # Apply the add_marker function to each row of the DataFrame to add markers to the map
m
