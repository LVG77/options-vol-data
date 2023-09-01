# Scrape options volatility data
Scrape free weekly options volatility data from https://www.optionstrategist.com/calculators/free-volatility-data

The scraped data can be browsed here: https://flatgithub.com/lvg77/options-vol-data

## Column Headings

`update`: date of the last scraping event. I added this date so that we can construct time series for each security after appending all the commits for [iv.csv](https://github.com/LVG77/options-vol-data/blob/master/iv.csv) file

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
