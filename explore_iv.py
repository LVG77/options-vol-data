import ibis
from ibis import _

ibis.options.interactive = True

con = ibis.duckdb.connect()
con.attach_sqlite("iv.db")
con.tables

iv = con.tables.item
iv_cast = iv.cast(
    {
        "update": "date",
        "hv20": "int",
        "hv50": "int",
        "hv100": "int",
        "cur_iv": "float",
        "close": "float",
    }
)
iv_tidy = iv_cast.mutate(
    ptile=_.days_percentile.re_extract(r"\d+/ *(\d+)", 1).cast("int"),
    days_ptile=_.days_percentile.re_extract(r"^(\d+)/", 1).cast("int"),
)

sec_lst = ["TD", "BMO", "RY", "CM", "BNS"]
iv_tidy.filter(_.symbol.isin(sec_lst)).order_by(by=["symbol", "update"])
