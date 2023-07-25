#!/bin/bash
DUMP_FILE_NAME="backupOn`date +%Y-%m-%d-%H-%M`.sql"
echo "Creating dump: $DUMP_FILE_NAME"

pg_dump -w --format=p --blobs --no-owner --no-privileges > $DUMP_FILE_NAME
# For backup in custom/archived format for fast restore
pg_dump -w --format=c --blobs --no-owner --no-privileges > $DUMP_FILE_NAME.compressed

if [ $? -ne 0 ]; then
  rm $DUMP_FILE_NAME
  rm $DUMP_FILE_NAME.compressed
  echo "Back up not created, check db connection settings"
  exit 1
fi


sshpass -p $SSH_PASSWORD ssh -o StrictHostKeyChecking=no $SSH_USERNAME@$SSH_HOST -p 23 "mkdir -p /home/backup/$PGDATABASE"
sshpass -p $SSH_PASSWORD rsync -chavzP -e "ssh -p23" $DUMP_FILE_NAME $SSH_USERNAME@$SSH_HOST:/home/backup/$PGDATABASE || exit 1
sshpass -p $SSH_PASSWORD rsync -chavzP -e "ssh -p23" $DUMP_FILE_NAME.compressed $SSH_USERNAME@$SSH_HOST:/home/backup/$PGDATABASE || exit 1

echo 'Successfully Backed Up'
exit 0
