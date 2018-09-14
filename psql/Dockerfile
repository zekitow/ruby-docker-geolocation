FROM postgres:10.4

COPY docker-entrypoint-initdb.d/init-user-db.sh /docker-entrypoint-initdb.d
RUN ["chmod", "+x", "/docker-entrypoint-initdb.d/init-user-db.sh"]