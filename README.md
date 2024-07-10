# Getting started

## Requirements

- duckdb 1.0.0+
- python 3+

Hop into the project and setup a venv:

```
python -m venv venv
source venv/bin/activate
```

Then install the python dependencies:

```
pip install dbt-core # you can skip if you have dbt installed globally
pip install -r requirements.txt
dbt deps
```

Then we can create the source database. We'll be using DuckDB again but you could load TPCH data from anywhere you'd like.

Launch `duckdb` and load the `reload-data.sql` file, this will create the TPCH database with a scale factor of 1.

```bash
duckdb dbt-duck.duckdb
.read reload-data.sql
```

Finally run with: `dbt build`.

The resulting file will be around 250MB, do not commit that.

### Nix

Run this one-liner to open a nix shell with the right version of DuckDB:
```
nix-shell -I nixpkgs="https://github.com/NixOS/nixpkgs/archive/655a58a72a6601292512670343087c2d75d859c1.tar.gz" -p duckdb
```


# Difference with snowflake

While porting the translate-runner example from Snowflake to DuckDB, I found some differences in the query syntax. This is not an exhaustive list.


## functions

- `current_timestamp()` is `current_timestamp`

## json

Snowflake has a object_construct function. It does not exist in DuckDB. The alternative is as follow:

- use the JSON extension with `to_json`
- to_json takes curly braces

For example, in snowflake:

```
object_construct(
    'insert_batch_id',
    '18145b2c-a11f-4e95-9f30-d4dfff67aac6',
    'row_inserted_at',
    current_timestamp()
)
```

In DuckDB:

```
to_json({
    'insert_batch_id': '18145b2c-a11f-4e95-9f30-d4dfff67aac6',
    'row_inserted_at': current_timestamp
})
```

Note that `current_timestamp()` is also different.

When selecting from json, Snowflake uses `object:property` syntax to access JSON object properties where as duck db uses `.`.

For example:

- `payload:part_name` would be `payload.part_name`