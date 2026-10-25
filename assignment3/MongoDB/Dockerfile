FROM mongo:7

# Mongo runs this script when its data directory is first created.
COPY init-db.js /docker-entrypoint-initdb.d/
