from pathlib import Path

from dagster_dbt import DbtProject

airbnb_project = DbtProject(
    project_dir=Path(__file__).joinpath("..", "..", "..", "airbnb").resolve(),
    packaged_project_dir=Path(__file__).joinpath("..", "..", "dbt-project").resolve(),
)
airbnb_project.prepare_if_dev()