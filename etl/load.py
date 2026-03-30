from sqlalchemy import create_engine, text
from sqlalchemy.types import BigInteger, Boolean, Float, Text, DateTime
from pathlib import Path
import config.database_config as config
from utils.logging import logger
import pandas as pd
# logging setup
logger = logger()

# database connection
engine = create_engine(config.CONNECTION_STRING)
print("DB Connected!")
logger.info("DB Connected!")


def load_data(dataframes):

    for table, df in dataframes.items():
        # staging table
        stg_table = f"stg_{table}"
        logger.info(f"Clearing table if exist {stg_table}")
        # sql = f"""
        # IF OBJECT_ID('{stg_table}', 'U') IS NOT NULL
        #     DROP TABLE IF EXISTS{stg_table}
        # """
        sql = f"""
        DROP TABLE IF EXISTS {stg_table}
        """

        with engine.begin() as conn:
            logger.info(f"insert table {stg_table}")
            conn.execute(text(sql))
            conn.commit()  # commit the drop operation

        print(f"Loading {stg_table}")
        logger.info("insert table")

        # mapping data type before insert sqlserver
        dtype_map = map_dtype(df)
        print(dtype_map)
        try:
            df.to_sql(
                stg_table,
                engine,
                index=False,
                if_exists="replace",
                dtype=dtype_map

            )
            # logging seccess or insert tracking
            # shutil.copyfile(file, f"dataset/..../_proceses/{Path(file).name}")
        except Exception as e:
            print(f"An error occurred: {e}")
            logger.info(f"An error occurred: {e}")
            # logging error  copy file or insert tracking
            # shutil.copyfile(file, f"dataset/..../_error/{Path(file).name}")


def map_dtype(df):
    dtype_map = {}
    for col, dtype in df.dtypes.items():
        if pd.api.types.is_datetime64_any_dtype(dtype):
            dtype_map[col] = DateTime()
        elif "datetime" in str(dtype):
            dtype_map[col] = DateTime()
        elif "int" in str(dtype):
            dtype_map[col] = BigInteger()
        elif "float" in str(dtype):
            dtype_map[col] = Float()
        elif "bool" in str(dtype):
            dtype_map[col] = Boolean()
        else:
            dtype_map[col] = Text()
    return dtype_map


def load_data_star_schema():
    """
    Run the sp_load_star_schema stored procedure.
    If it doesn't exist, drop & create from SQL file.
    """
    sp_file_path = Path("etl/sp_load_star_schema.sql")

    if not sp_file_path.exists():
        print(f"SQL file not found: {sp_file_path}")
        return

    # read SP SQL
    with open(sp_file_path, "r", encoding="utf-8") as f:
        sp_sql = f.read()

    # Remove any GO statements (pyodbc ไม่รู้จัก)
    sp_sql = "\n".join([line for line in sp_sql.splitlines()
                        if line.strip().upper() != "GO"])

    with engine.begin() as conn:
        # Ensure correct database
        conn.execute(text(f"USE {config.DB_NAME}"))

        # 1. Drop SP if exists
        drop_sql = """
            IF OBJECT_ID('sp_load_star_schema', 'P') IS NOT NULL
                DROP PROCEDURE sp_load_star_schema;
            """
        logger.info("Dropping existing SP if exists...")
        conn.execute(text(drop_sql))

        # 2. Create SP
        logger.info("Creating SP...")
        conn.execute(text(sp_sql))

        # 3. Execute SP
        logger.info("Executing SP...")
        conn.execute(text("EXEC sp_load_star_schema"))

        logger.info("SP executed successfully!")

# Example call
# if __name__ == "__main__":
#     run_star_schema_sp()

# test
# py -m etl.load
