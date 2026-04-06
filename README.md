# E-Commerce Analytics Data Platform

An end-to-end data engineering project that simulates an e-commerce business pipeline using Python, PostgreSQL, SQL, and workflow orchestration concepts.

## Project Overview

This project was built to demonstrate practical data engineering skills by designing and implementing a layered analytics pipeline for e-commerce transactional data.

The pipeline covers:

- Raw data generation
- Data ingestion into PostgreSQL
- Data cleaning and staging transformations
- Analytics warehouse modeling
- Business reporting queries
- Workflow orchestration structure with Airflow

## Tech Stack

- Python
- Pandas
- PostgreSQL
- SQLAlchemy
- SQL
- Faker
- Git & GitHub
- Apache Airflow

## Architecture

```text
Generated CSV Data
        ↓
Raw PostgreSQL Tables
        ↓
Staging / Cleaned Tables
        ↓
Dimension + Fact Tables
        ↓
Business Analytics Queries