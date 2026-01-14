CREATE TABLE trades (
    ts timestamptz NOT null,         
    price numeric(18,8) NOT NULL,
    instrument text NOT null default 'BTCUSD',
    data_source text,
    primary key (ts, price, instrument, data_source)
);
SELECT create_hypertable('trades', 'ts');

CREATE INDEX idx_trades_ts_brin ON trades USING BRIN (ts);

SELECT add_retention_policy('trades', INTERVAL '1 year');

CREATE MATERIALIZED VIEW candles_1m
WITH (timescaledb.continuous) AS
SELECT
    time_bucket('1 minute', ts) AS bucket,
    instrument,
    data_source,
    first(price, ts) AS open,
    max(price) AS high,
    min(price) AS low,
    last(price, ts) AS close,
    avg(price) AS avg_price,
    count(price) AS volume
FROM trades
GROUP BY bucket, instrument, data_source;

SELECT add_continuous_aggregate_policy('candles_1m',
    start_offset => INTERVAL '1 day',   
    end_offset   => INTERVAL '1 minute', 
    schedule_interval => INTERVAL '1 minute'  
);

CREATE MATERIALIZED VIEW candles_1m_ma AS
SELECT
    bucket,
    instrument,
    data_source,
    open,
    high,
    low,
    close,
    avg_price,
    volume,
    avg(avg_price) OVER (
        PARTITION BY instrument
        ORDER BY bucket
        ROWS BETWEEN 9 PRECEDING AND CURRENT ROW
    ) AS ma_10,
    avg(avg_price) OVER (
        PARTITION BY instrument
        ORDER BY bucket
        ROWS BETWEEN 19 PRECEDING AND CURRENT ROW
    ) AS ma_20
FROM candles_1m;

CREATE INDEX idx_candles_1m_ma_bucket_brin ON candles_1m_ma USING BRIN(bucket);

