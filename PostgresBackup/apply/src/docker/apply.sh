#!/bin/bash

echo "Getting dump: $PGDATABASE/$DUMP_FILE_NAME"
sshpass -p $SSH_PASSWORD rsync -chavzP -e "ssh -p23 -o StrictHostKeyChecking=no" $SSH_USERNAME@$SSH_HOST:/home/backup/$PGDATABASE/$DUMP_FILE_NAME backup_apply.sql || exit 1

echo "Dropping database $PGDATABASE"
psql -d postgres -c "drop database $PGDATABASE"

echo "Creating database $PGDATABASE"
psql -d postgres -c "create database $PGDATABASE"

echo "Applying dumpfile"
pg_restore -d $PGDATABASE --jobs 4 backup_apply.sql

if [ $? -ne 0 ]; then
  rm backup_apply.sql
  echo "Back up not applied, check db connection settings"
  exit  1
fi

echo 'Applied Backed Up successfully'
exit 0
