-- cleanup table if tpch is loaded previously
DROP TABLE IF EXISTS customer;
DROP TABLE IF EXISTS lineitem;
DROP TABLE IF EXISTS nation;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS part;
DROP TABLE IF EXISTS partsupp;
DROP TABLE IF EXISTS region;
DROP TABLE IF EXISTS supplier;

-- install the `tpch` plugin and create tables for tpch with a scale factor of 1
INSTALL tpch;
LOAD tpch;
CALL dbgen(sf = 1);