from sqlalchemy import text
from src.ingestion.db import engine

def create_staging_tables():
    with open("sql/staging.sql", "r") as file:
        sql_script = file.read()

    sql_commands = sql_script.split(";")

    with engine.connect() as connection:
        for command in sql_commands:
            command = command.strip()
            if command:
                connection.execute(text(command))
        connection.commit()

    print("✅ Staging tables created successfully!")

if __name__ == "__main__":
    create_staging_tables()