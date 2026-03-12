import logging
import config.database_config as config


def logger():  # logging setup
    logging.basicConfig(
        filename=config.LOGGER_DIR,
        level=logging.INFO,
        format="%(asctime)s - %(levelname)s - %(message)s"
    )

    return logging
