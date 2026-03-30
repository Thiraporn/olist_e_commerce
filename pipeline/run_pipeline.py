from etl.extract import extract_data, merge_file
from etl.transform import transform_data
from etl.load import load_data, load_data_star_schema
from utils.logging import logger
import config.database_config as config
from pathlib import Path
import glob


# logging setup
logger = logger()


def run_pipeline():

    logger.info("Start ETL.......")
    logger.info("................")
    # extract data
    # logger.info(f"extract data from sorce  file {files}")
    files = glob.glob(config.NON_TRANSACTIONS_PATH)
    data = extract_data(files)

    # extract data by merge file pattern ....yyyymm -------------------> sameple data 3M++ take too long.........
    # # print(dir(config))
    # merge_files = glob.glob(config.TRANSACTIONS_PATH)
    # m_data = merge_file(merge_files)
    # data[Path(merge_files[0]).parent.name] = m_data
    # # print(f"type(m_data) = {type(m_data)}")
    # # print(f"type(data) = {type(data)}")

    logger.info("Extract completed")

    # transfrom data
    data = transform_data(data)
    logger.info("Transform completed")

    # load data to DB
    load_data(data)
    logger.info("Load completed")

    # load data to star schema
    load_data_star_schema()

    logger.info("................")
    logger.info("End ETL.......")


if __name__ == "__main__":
    run_pipeline()


# python -m pipeline.run_pipeline
