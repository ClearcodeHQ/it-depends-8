# Quick guide to psql / PostgreSQL

## Intro

You may not be well versed in psql / PostgreSQL, which is used in this workshop.
For your comfort we provide all commands and queries you will need below.

## Using psql to connect to the database


```sh
docker-compose -f docker-compose.yaml exec postgres env PGOPTIONS="--search_path=campaigns" bash -c 'psql -U $POSTGRES_USER postgres'
```


## psql

`psql` is a PostgreSQL client running in the command line. After connecting to the database
it allows to run SQL queries (always ending with `;`) as well as some special commands, like:

* `\dt` - which list all tables in the database
* `\d TABLE_NAME` - which shows you the definition for a table named `TABLE_NAME`
* `\q` - which lets you quit `psql` ;)

More can be found in the [documentation](https://www.postgresql.org/docs/11/app-psql.html);

## SQL

If you're not familiar with the SQL language it is basically a query language for data manipulation
in the database. Here's all you need:

* `SELECT * FROM table_name;` - shows you all the rows of data in the table named `table_name`.
  For example to list all rows in `campaigns` table you could write `SELECT * FROM campaigns;`
* `UPDATE table_name SET column_name = 'something' WHERE id = 123;` - sets a new value to a column
  `column_name` to 'something', but only if row `id` is 123. Let's say we want to update several
  columns from the `line_items` table for the row identified by `id` 10001:

  ```sql
  UPDATE line_items SET max_bid = 100, compensation_method = 'CPC', last_change = now() WHERE id = 10001;
  ```

  In the example, the `now()` refers to current time.

* `DELETE FROM table_name WHERE id = 123;` - removes a row from `table_name`, that is identified
  by `id` 123.
