from setuptools import find_packages, setup

setup(
    name="my_dbt_dagster_project",
    version="0.0.1",
    packages=find_packages(),
    package_data={
        "my_dbt_dagster_project": [
            "dbt-project/**/*",
        ],
    },
    install_requires=[
        "dagster",
        "dagster-cloud",
        "dagster-dbt",
        "dbt-core<1.12",
        "dbt-snowflake<1.12",
        "dbt-snowflake<1.12",
        "dbt-snowflake<1.12",
    ],
    extras_require={
        "dev": [
            "dagster-webserver",
        ]
    },
)