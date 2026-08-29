# 🎵 Spotify Artists Analysis using SQL

## 📌 Project Overview

**Spotify Artists Analysis** is a SQL-based data analytics project built using **MySQL** to analyze artist streaming performance, genres, countries, debut years, and solo vs. collaborative streaming behavior.

The project demonstrates a complete SQL analytics workflow, starting from **database and table creation**, followed by **data validation, exploratory analysis, advanced SQL querying, window functions, views, indexing, query analysis, and business-oriented insights**.

This project was developed as an **intermediate-level SQL data analytics portfolio project**.

---

## 🎯 Project Objectives

The main objectives of this project are to:

* Analyze Spotify artist streaming performance
* Identify the most-streamed artists
* Analyze artist distribution across countries
* Analyze streaming performance across genres
* Compare solo and collaborative streaming behavior
* Analyze artists based on debut year
* Identify top-performing artists within genres and countries
* Calculate streaming contribution percentages
* Apply SQL window functions for ranking and comparison
* Create reusable SQL views
* Demonstrate indexing and query analysis using `EXPLAIN`
* Generate an executive summary of key business metrics

---

## 📂 Dataset

**Dataset:** Spotify Artists Analysis
**Coverage:** 1949–2021
**Database:** MySQL

### Main Columns

| Column                            | Description                         |
| --------------------------------- | ----------------------------------- |
| `artist_name`                     | Name of the artist                  |
| `sex`                             | Artist gender/sex category          |
| `country_of_origin`               | Artist's country of origin          |
| `primary_language`                | Primary language                    |
| `primary_genre`                   | Primary music genre                 |
| `artist_type`                     | Type of artist                      |
| `debut_year`                      | Artist debut year                   |
| `total_streams_millions`          | Total streams in millions           |
| `lead_streams_millions`           | Lead streams in millions            |
| `feature_streams_millions`        | Feature streams in millions         |
| `solo_streams_millions`           | Solo streams in millions            |
| `solo_stream_percentage`          | Percentage of solo streams          |
| `collaborative_streams_millions`  | Collaborative streams in millions   |
| `collaborative_stream_percentage` | Percentage of collaborative streams |

---

# 🗂️ Project Structure

The SQL project is organized into the following sections:

### 1. Database Creation — DDL

* Create database
* Select database
* Create `spotify_artists` table
* Define appropriate data types
* Add `NOT NULL` constraints

### 2. Data Import & Verification

* Verify total records
* Display sample records
* Check duplicate artist names

### 3. Data Cleaning & Validation

* Detect NULL values
* Detect empty values
* Check leading/trailing spaces
* Validate debut years
* Detect invalid stream values
* Validate percentage ranges
* Validate total stream calculations
* Validate lead + feature streams
* Validate solo + collaborative streams

The validation section checks whether the streaming components are internally consistent.

### 4. Exploratory Data Analysis

* Total artists
* Total countries
* Total genres
* Earliest debut year
* Latest debut year
* Average debut year
* Average streams
* Minimum and maximum streams
* Average solo-stream percentage
* Average collaborative-stream percentage

### 5. Basic SQL

Demonstrates:

* `SELECT`
* `WHERE`
* `ORDER BY`
* `LIKE`
* `BETWEEN`
* `LIMIT`
* Filtering
* Sorting

### 6. Intermediate SQL

Includes:

* `GROUP BY`
* `HAVING`
* `COUNT()`
* `SUM()`
* `AVG()`
* `MIN()`
* `MAX()`
* Subqueries
* Above-average analysis
* Country-wise analysis
* Genre-wise analysis
* Artist-type analysis

### 7. Advanced SQL

Includes:

* Subqueries
* Correlated subqueries
* CTEs
* Top-N analysis
* Second and third highest streamed artists
* Genre-level comparisons
* Country-level comparisons
* Streaming contribution analysis

For example, the project uses a CTE to calculate each genre's total streams and its percentage contribution to overall streams.

---

# 🪟 Window Functions

One of the major components of this project is the use of SQL window functions.

The project demonstrates:

* `ROW_NUMBER()`
* `RANK()`
* `DENSE_RANK()`
* `LAG()`
* `LEAD()`
* `NTILE()`
* `PARTITION BY`
* Window aggregations
* Percentage contribution

### Examples

#### Artist Ranking

Ranks artists based on total streams.

#### Top 3 Artists per Genre

Identifies the three highest-streamed artists within every genre.

#### Top 3 Artists per Country

Identifies the three highest-streamed artists within every country.

#### Cumulative Streams

Calculates cumulative streaming totals based on artist ranking.

#### Previous & Next Artist Comparison

Uses `LAG()` and `LEAD()` to compare an artist's streams with neighboring artists.

#### Stream Quartiles

Uses `NTILE(4)` to divide artists into four streaming-performance groups.

The project contains a dedicated window-function section covering these analyses.

---

# 👁️ SQL Views

The project creates reusable views for reporting and analysis.

### Views Created

#### `artist_stream_summary`

Contains artist, country, genre, and total streams for streaming analysis.

#### `country_wise_artist`

Provides:

* Country
* Artist count
* Total streams

#### `genre_wise_artist`

Provides:

* Genre
* Artist count
* Average streams

#### `above_average_artists`

Contains artists whose total streams are above the overall average.

#### `dashboard`

Provides a simplified dataset containing:

* Artist
* Country
* Genre
* Total streams
* Debut year

These views are designed to make repeated analysis and dashboard-oriented reporting easier.

---

# ⚡ Indexing & Query Analysis

The project also explores SQL performance optimization using indexes.

### Indexes Created

* `idx_country_of_origin`
* `idx_primary_genre`
* `idx_total_streams_millions`

The project uses `EXPLAIN` to inspect queries filtering by:

* Country
* Genre
* Total streams

This section demonstrates an understanding of how indexes can support query performance and how `EXPLAIN` can be used for query analysis.

---

# 💼 Business Questions Answered

The project addresses several practical business questions, including:

### 🌍 Country Analysis

* Which country has the most artists?
* Which country generates the highest total streams?
* Which countries have the highest average artist streams?

### 🎵 Genre Analysis

* Which genre has the most artists?
* Which genre generates the highest total streams?
* Which genre has the highest average streams per artist?
* How much does each genre contribute to total streams?

### 👤 Artist Analysis

* Who is the most-streamed artist?
* Who are the top 10 artists?
* Who has the highest solo streams?
* Who has the highest collaborative streams?
* Which artists have the highest solo-stream percentage?
* Which artists rely most heavily on collaborations?

### 📈 Streaming Analysis

* What is the average streaming performance?
* Which artists perform above the overall average?
* Which artists perform above their genre average?
* What percentage of total streams comes from individual artists?
* How are artists distributed across streaming quartiles?

The business-insight section specifically covers country presence, country streaming, genre performance, average streams, collaboration dependency, and solo performance.

---

# 📊 Executive Summary

The project includes an executive summary containing:

* Total Artists
* Total Countries
* Total Genres
* Total Streams
* Average Streams per Artist
* Average Solo-Stream Percentage
* Average Collaborative-Stream Percentage
* Highest-Streamed Artist
* Top Country by Artist Count
* Top Country by Total Streams
* Top Genre by Artist Count
* Top Genre by Total Streams
* Genre with Highest Average Streams
* Top Artist by Solo Streams
* Top Artist by Collaborative Streams
* Artist with Highest Solo-Stream Percentage
* Artist with Highest Collaborative-Stream Percentage
* Earliest Debut Year
* Latest Debut Year

A separate analysis also calculates the **percentage contribution of the top 10 artists to total streams**.

---

# 🛠️ SQL Concepts Demonstrated

This project covers a wide range of SQL concepts:

```text
✔ Database Creation
✔ Table Creation
✔ Data Types
✔ NOT NULL Constraints
✔ Data Validation
✔ NULL & Empty Value Checks
✔ String Functions
✔ SELECT
✔ WHERE
✔ ORDER BY
✔ DISTINCT
✔ LIMIT
✔ LIKE
✔ BETWEEN
✔ Aggregate Functions
✔ GROUP BY
✔ HAVING
✔ CASE
✔ Subqueries
✔ Correlated Subqueries
✔ CTEs
✔ Views
✔ Indexes
✔ EXPLAIN
✔ ROW_NUMBER()
✔ RANK()
✔ DENSE_RANK()
✔ LAG()
✔ LEAD()
✔ NTILE()
✔ PARTITION BY
✔ Window Aggregations
✔ Cumulative Calculations
✔ Percentage Contribution Analysis
```

---

# 🔍 Data Quality Checks

The project performs multiple data-quality validations:

* Duplicate artist detection
* NULL value detection
* Empty value detection
* Leading/trailing whitespace detection
* Debut-year validation
* Invalid stream-value detection
* Percentage-range validation
* Total stream consistency
* Lead + feature stream validation
* Solo + collaborative stream validation

These checks help ensure that the analysis is based on internally consistent data.

---

# 📈 Analytical Areas

The project analyzes Spotify data across multiple dimensions:

| Analysis Area           | Focus                                 |
| ----------------------- | ------------------------------------- |
| Artist Popularity       | Highest and lowest streamed artists   |
| Streaming Performance   | Total and average streams             |
| Genre Analysis          | Genre count and streaming performance |
| Country Analysis        | Artist distribution and streams       |
| Artist Type             | Streaming performance by artist type  |
| Debut Year              | Artist performance by debut period    |
| Solo Streaming          | Solo streams and percentages          |
| Collaborative Streaming | Collaboration performance             |
| Artist Ranking          | Ranking and top-N analysis            |
| Contribution Analysis   | Artist/genre stream contribution      |
| Cumulative Analysis     | Cumulative streaming totals           |

---

# 🚀 Key Learning Outcomes

Through this project, I practiced how to:

* Design a relational SQL table
* Validate data quality
* Perform exploratory data analysis
* Write analytical SQL queries
* Use aggregate functions effectively
* Work with subqueries and correlated subqueries
* Build reusable CTEs
* Apply window functions
* Create reporting views
* Use indexes for query optimization
* Analyze query execution using `EXPLAIN`
* Translate data into business-oriented insights
* Build an executive-level SQL report

---

# 📁 Repository Files

```text
Spotify-Artists-SQL-Analysis/
│
├── screenshots.png
├── Queries.sql
├── README.md
└── Dataset/
    └── spotify_artists.csv
```

---

# 💡 Business Value

This analysis can help answer questions around:

* Which markets have the strongest artist presence?
* Which genres generate the most streams?
* Which artists dominate streaming performance?
* How important are collaborations to artist performance?
* How concentrated are total streams among top artists?
* Which genres have high average streaming performance?
* Which artists outperform their genre averages?

The project therefore goes beyond simple SQL practice and demonstrates how SQL can be used for **data-driven decision-making and reporting**.

---

# 👩‍💻 Author

### Divyanshi Sagal

**BCA Student | SQL & Data Analytics Enthusiast**

Interested in:

* SQL
* Data Analytics
* Python
* Data Visualization
* Business Intelligence

---

# ⭐ Project Highlights

```text
📌 Intermediate-level SQL Analytics Project
📌 MySQL Database
📌 Data Cleaning & Validation
📌 Exploratory Data Analysis
📌 Advanced SQL
📌 CTEs & Subqueries
📌 Window Functions
📌 Views
📌 Indexing & EXPLAIN
📌 Business Insights
📌 Executive Summary
```

---

## ⭐ If you found this project useful

Feel free to **star ⭐ the repository** and explore the SQL queries to understand the analysis workflow.

---

### 📌 Project Status

**Completed — SQL Portfolio Project**

Built for practicing and demonstrating practical **SQL Data Analytics** skills.
