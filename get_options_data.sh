#!/usr/bin/bash
echo "update,symbol,hv20,hv50,hv100,date,cur_iv,days_percentile,close" > data.csv \
&& curl -s https://www.optionstrategist.com/calculators/free-volatility-data \
| sed -n "/<pre>/,/<\/pre>/p" \
| sed "s/<[^>]*>//g" \
| sed "/^\*/d" \
| sed "1,/^Symbol/d" \
| sed "s/\\([^/ *]\\)  */\\1,/g" \
| sed "/OPTION/d" \
| sed "s/%ile,*/%ile,/g" \
| awk -F, "NF==8" >> data.csv

# Assign today's date in yyyy-mm-dd format to a variable
DATE=$(date +%Y-%m-%d)

# Use awk to append the date to each line except the first one
awk -v d="$DATE" -F"," 'BEGIN {OFS = ","} NR>1 {$0=d","$0}1' data.csv > iv.csv

# remove temp data.csv file
rm data.csv

##=========== Anotated explanations of the script ==========

# echo "update,symbol,hv20,hv50,hv100,date,cur_iv,days_percentile,close" > data.csv \
# && curl -s https://www.optionstrategist.com/calculators/free-volatility-data \
# # Use sed to extract the text between <pre> and </pre> tags
# | sed -n "/<pre>/,/<\/pre>/p" \
# # Use sed to remove any HTML tags from the text
# | sed "s/<[^>]*>//g" \
# # Use sed to delete any lines that start with an asterisk
# | sed "/^\*/d" \
# # Use sed to delete the lines from the beginning until the line that starts with Symbol
# | sed "1,/^Symbol/d" \
# # Use sed to replace any sequence of spaces that is not preceded by a slash
# | sed "s/\\([^/ *]\\)  */\\1,/g" \
# # Use sed to delete any lines that contain OPTION
# | sed "/OPTION/d" \
# # Use sed to replace any occurrence of %ile followed by zero or more commas with %ile followed by one comma
# | sed "s/%ile,*/%ile,/g" \
# # Use awk to filter out any lines that do not have exactly eight fields separated by commas
# | awk -F, "NF==8" >> data.csv
