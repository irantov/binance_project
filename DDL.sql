CREATE TABLE trades (
    ts timestamptz NOT NULL,         
    instrument text NOT null default 'BTCUSD',        
    price numeric(18,8) NOT NULL,   
    volume numeric(18,8),  
    highest numeric(18,8),           
    lowest numeric(18,8),            
    ma_10 numeric(18,8),             
    ma_20 numeric(18,8),
    data_source text
);
SELECT create_hypertable('trades', 'ts');
CREATE INDEX idx_trades_instrument ON trades (instrument);
CREATE INDEX idx_trades_ts_brin ON trades USING BRIN (ts);

