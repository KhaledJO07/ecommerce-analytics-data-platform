from airflow import DAG
from airflow.operators.bash import BashOperator
from datetime import datetime

default_args = {
    "owner": "khaled",
    "start_date": datetime(2025, 1, 1),
    "retries": 1
}

with DAG(
    dag_id="ecommerce_analytics_pipeline",
    default_args=default_args,
    schedule_interval=None,
    catchup=False,
    description="End-to-end e-commerce analytics data pipeline"
) as dag:

    generate_data = BashOperator(
        task_id="generate_data",
        bash_command="python src/ingestion/generate_data.py"
    )

    create_tables = BashOperator(
        task_id="create_raw_tables",
        bash_command="python src/ingestion/create_tables.py"
    )

    load_data = BashOperator(
        task_id="load_raw_data",
        bash_command="python src/ingestion/load_data.py"
    )

    create_staging = BashOperator(
        task_id="create_staging_tables",
        bash_command="python src/transformations/create_staging.py"
    )

    create_analytics = BashOperator(
        task_id="create_analytics_model",
        bash_command="python src/transformations/create_analytics_model.py"
    )

    generate_data >> create_tables >> load_data >> create_staging >> create_analytics