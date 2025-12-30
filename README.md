# binance_project
2024/12/30 
Version 1.0
This is a custom made project which reads a ticker data from the BINANCE API using both the web socket and their REST API. After the data is being read, the notebook does simple data transformations such as calculation of highest/lowest price per minute and rolling moving average of different periods. At the end, the data is written in a RDBMS system (PostgreSQL leveraging TimescaleDB extension). The project is for learning purposes only.
