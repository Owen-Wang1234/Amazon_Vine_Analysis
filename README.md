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

After consulting the database index, the **Major Appliances** dataset is selected for this analysis. The URL to this dataset is taken from the index and entered into the SparkFiles function to read the data into a Spark DataFrame. With the DataFrame established, data tables are created by extracting various columns, transforming them, and naming them in accordance with the provided schema. The data tables must match the schema in column name and data type to write into the PostgreSQL tables correctly.

With the data tables ready, a AWS RDS instance is created and connected to a PostgreSQL platform. A database is created within this instance, and the provided schema is used to create the initial data tables on the SQL end.

A connection is then made to the AWS RDS instance to write the data tables into the SQL tables. Queries are made to verify that the process worked correctly. When the SQL tables are filled out properly, the results are then exported into CSV files for future work without requiring future connections to AWS RDS. When the exports are completed, the RDS instance is disconnected and deleted as part of the AWS cleanup process.

## Analysis of Vine Reviews
After the `vine_table` is established, an analysis can be carried out to determine if bias exists in the Vine program. There are three different ways to do this:

### PySpark Method
A new Google Colab notebook is created with the PySpark session started. The code cells used during the ETL of the Amazon Review Dataset can be used here to recreate the `vine_table` DataFrame. An alternative method is to place `vine_table.csv` into a Amazon S3 bucket so that Spark can load it into a DataFrame.

This DataFrame is filtered into separate DataFrames to get usable data; the first filter gets the reviews that have at least twenty votes, and the second filter selects those reviews where at least half of the votes mark them as helpful. These helpful reviews are split into two DataFrames: One for Vine (paid) reviews and the other for non-Vine (unpaid) reviews.

With these DataFrames completed, the counts of total helpful reviews, total Vine reviews, and total non-Vine reviews are obtained. Next, the counts of 5-Star reviews in the helpful DataFrame, the Vine DataFrame, and the non-Vine DataFrame are obtained. Then, these counts are used to determine the percentages of 5-Star reviews.

### Pandas Method
A new Jupyter notebook is created with Pandas and Numpy imported (Numpy is included just in case). The `vine_table.csv` is imported into a DataFrame using the `read_csv` method from Pandas.

This DataFrame is filtered into separate DataFrames to get usable data; the first filter gets the reviews that have at least twenty votes, and the second filter selects those reviews where at least half of the votes mark them as helpful. These helpful reviews are split into two DataFrames: One for Vine (paid) reviews and the other for non-Vine (unpaid) reviews.

With these DataFrames completed, the counts of total helpful reviews, total Vine reviews, and total non-Vine reviews are obtained. Next, the counts of 5-Star reviews in the helpful DataFrame, the Vine DataFrame, and the non-Vine DataFrame are obtained. Then, these counts are used to determine the percentages of 5-Star reviews.

### SQL Method
If the SQL tables from Deliverable 1 are not still there, then `vine_table` is to be recreated using the provided schema. The `vine_table.csv` is then used to import into the table.

The first filtering query gets the reviews that have at least twenty votes into a separate table. The second filtering query selects, from that table into another separate table, the reviews where at least half of the votes mark them as helpful. These helpful reviews are split into two tables: One for Vine (paid) reviews and the other for non-Vine (unpaid) reviews.

With these tables created, queries are used to get the count of total helpful reviews, the count of 5-Star reviews in the helpful DataFrame, and the percentage of 5-Star reviews. This is also done for Vine reviews and non-Vine reviews.

## Results
With the analysis complete, the results are tabulated below.

DATASET SELECTED: **MAJOR APPLIANCES**

| Review Type | Total Reviews | 5-Star Reviews | 5-Star Percentage |
| --- | ---: | ---: | ---: |
| Helpful | 4,992 | 1,981 | 39.683% |
| Vine (paid) | 35 | 18 | 51.429% |
| non-Vine (unpaid) | 4,957 | 1,963 | 39.601% |

## Summary
Even if the percentages can imply a bias towards more positive reviews among Vine (paid) members, that hypothesis cannot be fully validated, especially in the Major Appliances dataset with such a small pool of Vine reviews. Even if there is a more balanced proportion of Vine to non-Vine members, a better way to check for positivity bias in individual datasets could involve charting out the distribution of the star-ratings for Vine and non-Vine groups in each dataset.

Another approach is to get the percentages of 5-Star reviews for each dataset, getting the mean percentages for these collections, and then running a statistical t-test to check the p-values for statistical significance.

At a deeper level, the 5-Star reviews can be run through Natural Language Processing to verify that the actual review content truly reflects the star rating.

Filtering reviews for verified purchases could help to ensure that the reviews are genuine based on actual experience with the product. However, filtering reviews in this manner may run the risk of leaving a very small pool for analysis.