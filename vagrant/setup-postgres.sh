 #!/usr/bin/env bash
 
 sudo pg_dropcluster --stop 9.1 main
 sudo pg_createcluster --start --locale en_US.UTF-8 9.1 main
 
 sudo -u postgres psql postgres
 CREATE ROLE vagrant LOGIN SUPERUSER PASSWORD 'vag';
 \quit
 
 createdb
 