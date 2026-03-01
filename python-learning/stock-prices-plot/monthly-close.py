"""
Using the stock data from stocks.csv, draw a bar chart were:
- The x axis is the month
- The y axis is the median closing price
- Each stock should have it's own chart
"""
from pathlib import Path
import pandas as pd


# Load the data
here = Path(__file__).absolute().parent
csv_file = here / "stocks.csv"

df = pd.read_csv(
    csv_file,
    parse_dates=['Date'],
    index_col='Date'
)

# Create the plot
ax = (
  df.pivot(
    columns='Ticker',
    values='Close'
    ).resample('M').median().plot.bar(
      xticks=range(12),
      rot=0, 
      figsize=(10, 6)
    )
)
# Set the title and labels
ax.set_title("Median Closing Price by Month")
ax.set_xlabel("Month")
ax.set_ylabel("Median Closing Price")
ax.set_xticklabels([
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
])
ax.legend(title='Ticker')
