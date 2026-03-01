import yfinance as yf
import pandas as pd

print("yfinance version:", yf.__version__)

tickers = ["GOOG", "MSFT", "ORCL"]

# Download all tickers in one call
df = yf.download(
    tickers,
    start="2020-01-01",
    end="2020-12-31",
    group_by="ticker"
)

# Convert multi-index columns to a flat structure
df = df.stack(level=0).reset_index()
df.rename(columns={"level_1": "Ticker"}, inplace=True)

# Save to CSV
output_path = "stocks.csv"
df.to_csv(output_path, index=False)

print("Saved:", output_path)
print(df.head())
