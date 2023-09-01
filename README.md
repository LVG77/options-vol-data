# Scrape options volatility data
Scrape free weekly options volatility data from https://www.optionstrategist.com/calculators/free-volatility-data.

## Column Headings

`hv20`: 20-day HISTORICAL (actual) volatility of the underlying

`hv50`: 50-day historical volatility

`hv100`: 100-day historical volatility

`date`: date of last OPTION data (options don't trade every day on every underlying)

`cur_iv`: the implied volatility of these options on `date`

`days_percentile`: 
  - _days_: the number of days back for which implied volatility has been calculated
  - _percentile_: measurement of the cur_iv, as compared to the past Days

`close`: latest closing price of the underlying

So if the last two numbers are "597/ 87%ile", that means that of the last 597 daily implied volatility readings, the the current daily reading is higher than 87% of them.

NOTE: futures symbols begin with the character @ index symbols begin with the character $
