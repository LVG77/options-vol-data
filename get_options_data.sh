#!/usr/bin/sh
echo "symbol,hv20,hv50,hv100,date,cur_iv,days_percentile,close" > data.csv \
&& curl -s https://www.optionstrategist.com/calculators/free-volatility-data \
| sed -n "/<pre>/,/<\/pre>/p" \
| sed "s/<[^>]*>//g" \
| sed "/^\*/d" \
| sed "1,/^Symbol/d" \
| sed "s/\\([^/ *]\\)  */\\1,/g" \
| sed "/OPTION/d" \
| sed "s/%ile,*/%ile,/g" \
| awk -F, "NF==8" >> data.csv
