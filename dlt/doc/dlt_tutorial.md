# 🚀 Getting Started with `dlt` + Exasol (via SQLAlchemy)

You can now use Exasol as a destination in `dlt` via SQLAlchemy/sqlalchemy-exasol.\
`sqlalchemy-exasol` version XXXX <TODO VERSION> and above support this.

This tutorial walks you through setting up a pipeline using the built-in
`chess` source and loading the data into Exasol.

------------------------------------------------------------------------

## 📦 1. Install `dlt` Globally

Install `dlt` so you can use the CLI:

``` bash
pip install dlt
```

------------------------------------------------------------------------

## 🏁 2. Initialize a New Pipeline

Create a new folder for your project.

``` bash
mkdir dlt-tutorial
cd dlt-tutorial
```

Use the `chess` source and `sqlalchemy` destination:

``` bash
dlt init chess sqlalchemy

```

> The built-in `chess` source is a simple example and **does not require
> parameters**.

------------------------------------------------------------------------

## 🧪 3. Create and Activate a Virtual Environment

``` bash
python -m venv .venv
source .venv/bin/activate  # On Windows: .venv\Scripts\activate
```

------------------------------------------------------------------------

## ➕ 4. Install Project Dependencies

Install `dlt` with SQLAlchemy support and the Exasol driver:

``` bash
pip install dlt[sqlalchemy] sqlalchemy-exasol
```

Update your `requirements.txt`:

``` txt
dlt[sqlalchemy]
sqlalchemy-exasol
```


------------------------------------------------------------------------

## 🔌 5. Configure the SQLAlchemy Destination (Exasol)


The sample below is what a typical `secrets.toml` section to configure the SQLAlchemy Destination would look like when using a docker container for testing purposes.


```
[destination.sqlalchemy.credentials]
drivername = "exa+websocket"
username    = "sys"
password    = "exasol"
host        = "127.0.0.1"  # will be overridden by EXA_HOST
port        = 9563         # will be overridden by EXA_PORT
query       = { SSLCertificate = "SSL_VERIFY_NONE" }
```

### ⚙️ Configuration Priority

1.  **Environment variables**\
2.  **Project `.dlt/secrets.toml`**\
3.  **Project `.dlt/config.toml`**\
4.  **Global `~/.dlt/secrets.toml` and `~/.dlt/config.toml`**\
5.  **Defaults in code**

👉 Environment variables override everything.\
👉 Project config overrides global config.\
👉 Global config is useful for shared defaults across projects.

See [DLT setup documentation](https://dlthub.com/docs/general-usage/credentials/setup) for more information on how to properly configure pipelines.

For the purpose of this tutorial, we spun up an Exasol Docker database using:
```
docker run --name exasoldb -p 127.0.0.1:9563:8563 --detach --privileged --stop-timeout 120  exasol/docker-db:2025.2.0
```
(More info on Exasol's Docker Database and how to set it up can be found on the [exasol/docker-db page](https://hub.docker.com/r/exasol/docker-db/).)

------------------------------------------------------------------------

## ▶️ 6. Run the Pipeline

``` bash
python chess_pipeline.py
```

This will extract data from the chess API and load it into your Exasol
database.

------------------------------------------------------------------------

## ⚠️ Current Limitations

> **Warning**
>
> Binary types such as `UUINT`, `BLOB`, `BINARY` and `VARBINARY` are currently not
> supported when using
> Exasol as a `dlt` destination via SQLAlchemy.\
> You may currently need to cast or transform such columns to compatible types
> before loading.


------------------------------------------------------------------------

## ✅ Summary

-   Install `dlt` globally
-   Initialize with `dlt init chess sqlalchemy`
-   Use a virtual environment
-   Install `dlt[sqlalchemy]` + `sqlalchemy-exasol`
-   Configure credentials
-   Run and optionally transform your data

------------------------------------------------------------------------

Happy data loading! ♟️🚀