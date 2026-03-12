DB_SERVER = "localhost"
DB_NAME = "DATASET_OLIST"
NON_TRANSACTIONS_PATH = "dataset/nontransactions/_raw/*"
# TRANSACTIONS_PATH = "dataset/transactions/_raw/transactions/*"
LOGGER_DIR = "logs/etl.log"

CONNECTION_STRING = (
    f"mssql+pyodbc://{DB_SERVER}/{DB_NAME}"
    "?driver=ODBC+Driver+17+for+SQL+Server"
    "&trusted_connection=yes"
)
