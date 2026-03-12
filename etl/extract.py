import pandas as pd
# import glob
from pathlib import Path
# import config.database_config as config
from utils.logging import logger
import re

# logging setup
logger = logger()
loaders = {
    ".csv": pd.read_csv,
    ".xlsx": pd.read_excel,
    ".json": pd.read_json
}


def extract_data(files):
    # files = glob.glob(config.PATH)
    # csv_files = glob.glob(config.CSV_PATH)
    # xlsx_files = glob.glob(config.XLSX_PATH)
    dataframes = {}
    for file in files:
        logger.info("Start ETL.......")
        name = Path(file).name
        ext = Path(file).suffix
        table = Path(file).stem

        logger.info(f"Extract file: {name}")
        if ext in loaders:
            df = loaders[ext](file)
            dataframes[table] = df
    return dataframes


def merge_file(files):
    logger.info("Start Merge.......")
    dataframes = []
    for file in files:

        filename = Path(file).name
        ext = Path(file).suffix
        # detect month pattern YYYYMM
        match = re.search(r"\d{6}", filename)
        if not match:
            print("skip:", filename)
            continue

        # choose loader
        loader = loaders.get(ext)
        if loader is None:
            continue

        df = loader(file)
        month = match.group()
        df["month"] = month
        dataframes.append(df)

    merged_df = pd.concat(dataframes, ignore_index=True)
    logger.info("End Merge.......")
    return merged_df

# def merge_file(pattern):
#     files = glob.glob(path)

#     dfs = []

#     for file in files:

#         filename = os.path.basename(file)

#         # detect month pattern YYYYMM
#         match = re.search(r"\d{6}", filename)
    # if not match:
    #     print("skip:", filename)
    #     continue
#         if match:
#             month = match.group()
#         else:
#             month = None

#         # detect file type
#         if file.endswith(".csv"):
#             df = pd.read_csv(file)

#         elif file.endswith(".xlsx"):
#             df = pd.read_excel(file)

#         else:
#             continue

#         df["month"] = month

#         dfs.append(df)

#     merged_df = pd.concat(dfs, ignore_index=True)

#     return merged_df

 # table = os.path.basename(file).replace(".csv", "")
    # df = pd.read_csv(file)
    # table = os.path.basename(file).split(".")[0]
    # detect file type
    # if ext == ".csv":
    #     df = pd.read_csv(file)
    # elif ext == ".xlsx" :
    #     df = pd.read_excel(file)
    # elif ext == ".json" :
    #     df = pd.read_json(file)
    # else:
    #     continue

    # dataframes[table] = df


# python -m etl.extract
