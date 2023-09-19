import duckdb
import pandas as pd

duckdb.sql("LOAD sqlite;")
duckdb.sql("CALL sqlite_attach('iv.db')")
duckdb.sql("FROM item")
duckdb.sql("describe item")

iv = duckdb.sql(
    """
    select 
        cast(update as Date) as update,
        symbol,
        cast(hv20 as INT) as hv20,
        cast(hv50 as INT) as hv50,
        cast(hv100 as INT) as hv100,
        date,
        cur_iv::double cur_iv,
        days_percentile,
        regexp_extract(days_percentile, '(\d+)/', 1)::int as days,
        regexp_extract(days_percentile, '/ *(\d+)%ile', 1)::int as ptile,
        close::double as close
    from item 
"""
)

duckdb.sql(
    """
    select 
        cast(update as Date) as update,
        cast(columns('^hv') as INT),
    from item 
"""
)

duckdb.sql("from iv")

duckdb.sql("select update, count(*) from iv group by all")
sec_lst = ["TD", "BMO", "RY", "CM", "BNS"]
sec_lst_str = ",".join(f"'{t}'" for t in sec_lst)
sec_df = duckdb.sql(f"select * from iv where symbol in ({sec_lst_str})").to_df()
sec_df.pivot_table(index="update", columns="symbol", values="cur_iv").plot.line(
    style=".-"
)
