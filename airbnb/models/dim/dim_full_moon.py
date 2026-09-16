import holidays
from snowflake.snowpark.functions import udf, col
from snowflake.snowpark.types import BooleanType, DateType

def model(dbt, session):
    dbt.config(
        materialized = "table",
        packages = ["holidays"]
    )

    df = dbt.ref("seed_full_moon_dates")

    @udf(packages=["holidays"], return_type=BooleanType(), input_types=[DateType()])
    def is_holiday(date_col):
        return date_col in holidays.Germany()

    return df.with_column("IS_HOLIDAY", is_holiday(col("FULL_MOON_DATE")))