from textblob import TextBlob
from snowflake.snowpark.functions import udf, col
from snowflake.snowpark.types import FloatType, StringType


def model(dbt, session):
    dbt.config(
        materialized = "table",
        packages = ["textblob"]
    )

    df = dbt.ref("fct_reviews")

    @udf(packages=["textblob"], return_type=FloatType(), input_types=[StringType()])
    def get_sentiment(text):
        return TextBlob(text).sentiment.polarity

    return df.with_column("SENTIMENT_SCORE", get_sentiment(col("REVIEW_TEXT")))