## BINANCE MARKET DATA EXTRACTION
#### [1.0.0] - 2025-12-30 
This is a custom made project which reads a ticker data from the BINANCE API using both the web socket and their REST API. After the data is being read, the notebook does simple data transformations such as calculation of highest/lowest price per minute and rolling moving average of different periods. At the end, the data is written in a RDBMS system (PostgreSQL leveraging TimescaleDB extension). The project is for learning purposes only. Feel free to experiment with the notebook and it's code. 
#### [1.1.0] - 2025-01-04
- Added docker file with .env file storing API keys and secrets, to run the notebook yourself, do the following:
1.Clone the repo in case you haven't with git clone to a local directory
2.Navigate to the directory and run a docker build command (docker build -t binance_project .). Ensure you have a docker running and installed
3.Run the following command and open the provided link so you would be transmitted to jupyterlab (docker run -p 8888:8888 --rm -v "YOUR_FULL_PATH_HERE" --env-file .env  binance_project)
4. When you open the link, navigate to binance_project.ipynb and run the cells you want to (it's recommended to run them sequentially and experiment)
NOTE: This is a demo project, not meant for production use. (learning goals)
