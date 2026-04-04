from sqlalchemy import text
from src.ingestion.db import engine

def create_analytics_model():
    with open("sql/analytics_model.sql", "r") as file:
        sql_script = file.read()

    sql_commands = sql_script.split(";")

    with engine.connect() as connection:
        for command in sql_commands:
            command = command.strip()
            if command:
                connection.execute(text(command))
        connection.commit()

    print("✅ Analytics warehouse tables created successfully!")

if __name__ == "__main__":
    create_analytics_model()