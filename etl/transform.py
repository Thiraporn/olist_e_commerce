import pandas as pd
import numpy as np
from utils.logging import logger
# logging setup
logger = logger()

# transform data


def transform_data(dataframes):

    for table, df in dataframes.items():
        df = clean_dataframe(df)
        # df.columns = df.columns.str.lower()
        dataframes[table] = df

    return dataframes

# clean and optimise data


def clean_dataframe(df: pd.DataFrame, verbose: bool = True) -> pd.DataFrame:
    df = df.copy()

    # log helper
    def log(msg):
        if verbose:
            logger.info(f"[INFO] {msg}")

    # 1. standardize column names
    df.columns = df.columns.str.strip().str.lower().str.replace(' ', '_')
    log("Standardized column names.")

    # 2. remove exact duplicates
    # dup_count = df.duplicated().sum()
    # if dup_count > 0:
    #     df.drop_duplicates(inplace=True)
    #     log(f"Removed {dup_count} duplicate rows.")

    # 3. trim and lowercase all string (object) values
    for col in df.select_dtypes(include='object'):
        df[col] = df[col].astype(str).str.strip().str.lower()
    log("Standardized string columns (lowercase + trimmed).")

    # 4. detect missing values (including blanks and placeholders)
    placeholder_values = ['n/a', 'na', '--', '-', 'none', 'null', '', 'nan']
    df.replace(placeholder_values, np.nan, inplace=True)
    null_report = df.isnull().sum()
    null_report = null_report[null_report > 0]
    if not null_report.empty:
        log(f"Missing values found in columns:\n{null_report}")

    # 5. flag constant columns
    constant_cols = [col for col in df.columns if df[col].nunique() == 1]
    if constant_cols:
        log(f"Constant columns (consider removing): {constant_cols}")

    # 6. flag high cardinality categorical columns
    # sometime high cardinality will show :
    #     product_name
    #     iphone
    #     iPhone
    #     Iphone
    #     iphone 14
    # mean ===> data unclean/duplicate data

    high_card_cols = [col for col in df.select_dtypes(
        include='object') if df[col].nunique() > 100]
    if high_card_cols:
        log(
            f"High-cardinality columns (consider encoding strategies): {high_card_cols}")

    # 7. detect numeric outliers using IQR
    # for example cases
    #     price = -100
    #     delivery_time = 9000
    #     order_total = 999999
    num_cols = df.select_dtypes(include=np.number).columns
    outlier_report = {}
    for col in num_cols:
        q1, q3 = df[col].quantile([0.25, 0.75])
        iqr = q3 - q1
        lower = q1 - 1.5 * iqr
        upper = q3 + 1.5 * iqr
        outliers = df[(df[col] < lower) | (df[col] > upper)][col].count()
        if outliers > 0:
            outlier_report[col] = outliers
    if outlier_report:
        log(f"Potential numeric outliers detected:\n{outlier_report}")

    # 8. convert applicable columns to category
    # transform column in string(object) to be category if count unique value
    # Example case
    #        order_status
    #         -----------
    #         delivered
    #         cancelled
    #         delivered
    #         delivered
    #  unique = 3 (from rows = 1,000,000)
    #  ==> DataFrame Optimization for
    #       1. reducing memory
    #       2. increasing performance
    #       3. preparing data for analytics / ML
    for col in df.select_dtypes(include='object'):
        n_unique = df[col].nunique()
        if n_unique < len(df) * 0.05:
            df[col] = df[col].astype('category')
    log("Converted suitable object columns to category dtype.")

    # 9. auto detect datetime
    # null support while loading to sql server
    for col in df.select_dtypes(include="object").columns:

        parsed = pd.to_datetime(df[col],  format="mixed", errors='coerce')
        invalid = df[col][parsed.isna()]

        if parsed.notna().mean() > 0.9:
            if not invalid.empty:
                print(f"problem column: {col}")
                print(invalid.head())
            # print(col)
            # print(df[col].min(), df[col].max())
            # print(df.dtypes)
            df[col] = parsed
            # df = df[df[col] >= "1753-01-01"]

    log("Data cleaning complete.")
    return df

  # for col in df.select_dtypes(include="object").columns:
    #     parsed = pd.to_datetime(df[col], format="mixed", errors="coerce")
    #   parsed = pd.to_datetime(df[col], format="mixed", errors="coerce")
    #   parsed = pd.to_datetime(
    #     df[col],  format="%Y-%m-%d %H:%M:%S", errors="coerce")
    # parsed = pd.to_datetime(df[col], errors="coerce")
    # parsed = pd.to_datetime(df[col], format="mixed", errors="coerce")
    #     if parsed.notna().mean() > 0.9:
    #         df[col] = parsed


# test
# py -m etl.transform
