# BACKUP & RESTORE

## BACKUP
Create a directory or use the directory `/var/backups` of your local computer

```bash
pg_dump tddinc -f bkup-20230709.sql -O -v

```
- dbname -> Name of the data base we are going to backup, in my case `tddinc`

- -f file -> Name the file that takes the output of the backup, we use `.sql` because is a plain text and we can read it with a text editor

- -O -> Set the backup in no-owner mode, in order to restore the db with no need of the user owner (because you might backup the db with another user)

- 