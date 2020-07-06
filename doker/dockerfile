FROM mariadb:10.0.29
COPY ["model-dv.sql", "/docker-entrypoint-initdb.d/"]
COPY ["import.sh", "/docker-entrypoint-initdb.d/"]