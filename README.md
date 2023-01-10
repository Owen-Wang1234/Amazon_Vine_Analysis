# Amazon_Vine_Analysis

## Project Overview
The client has requested an analysis of the datasets of product reviews written by members of the Amazon Vine program. The client wants to know if there is any bias towards favorable reviews from Amazon Vine members in the product review datasets.

## Resources

### Data Sources

- Amazon_Reviews_Database_index.txt
- Amazon_Reviews_ETL.ipynb
- challenge_schema.sql

### Software

- Local Computer Python Envronment:
    1. Python 3.9.13
    2. Jupyter Notebook 6.4.12
    3. Pandas 1.4.4
    4. Numpy 1.21.5

- Google Colab Spark Environment:
    1. Spark 3.2.3
    2. Hadoop 2.7
    3. Postgres Driver 42.2.16

- Database Environment:
    1. pgAdmin 4 6.12
    2. PostgreSQL 14.5

### Web Resources
The scale of data involved would strain a conventional computer, so online resources are used to facilitate the process:

- Google Colab - Allows use of cloud computing resources to run the data processing in place of the local computer on hand
- Amazon Web Services (AWS) Relational Databases (RDS) - Allows use of cloud storage to hold databases and tables when the local computer cannot provide sufficient storage
- AWS Simple Storage Service (S3) - Allows use of cloud storage to hold various files online for retrieval by Google Colab without needing to access the local computer

## ETL of Amazon Review Dataset
The first three cells in the Colab Notebook script initializes Spark, installs the PostgreSQL driver, and initializes the Spark session.

After consulting the database index, the Major Appliances dataset is selected for this analysis. The URL to this dataset is taken from the index and entered into the SparkFiles function to read the data into a Spark DataFrame. With the DataFrame established, data tables are created by extracting various columns, transforming them, and naming them in accordance with the provided schema. The data tables must match the schema in column name and data type to write into the PostgreSQL tables correctly.

With the data tables ready, a AWS RDS instance is created and connected to a PostgreSQL platform. A database is created within this instance, and the provided schema is used to create the initial data tables on the SQL end.

A connection is then made to the AWS RDS instance to write the data tables into the SQL tables. Queries are made to verify that the process worked correctly. When the SQL tables are filled out properly, the results are then exported into CSV files for future work without requiring future connections to AWS RDS. When the exports are completed, the RDS instance is disconnected and deleted as part of the AWS cleanup process.