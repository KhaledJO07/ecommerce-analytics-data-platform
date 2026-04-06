from src.ingestion.generate_data import generate_data
from src.ingestion.create_tables import create_tables
from src.ingestion.load_data import load_csv_to_postgres
from src.transformations.create_staging import create_staging_tables
from src.transformations.create_analytics_model import create_analytics_model

def run_pipeline():
    print("🚀 Starting E-Commerce Analytics Pipeline...\n")

    print("1️⃣ Generating raw data...")
    generate_data()

    print("2️⃣ Creating raw tables...")
    create_tables()

    print("3️⃣ Loading raw data into PostgreSQL...")
    load_csv_to_postgres()

    print("4️⃣ Creating staging tables...")
    create_staging_tables()

    print("5️⃣ Creating analytics warehouse model...")
    create_analytics_model()

    print("\n🎉 Pipeline completed successfully!")

if __name__ == "__main__":
    run_pipeline()