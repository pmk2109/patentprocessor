#configured to my starcluster environment

cd /mnt/sgeadmin
for i in `ls *.xml`
    do echo $i

    cd /home/sgeadmin/patentprocessor/
    echo "python"
    python parse_sq.py -p /mnt/sgeadmin --xmlregex $i
    echo "mysqldump"
    mysqldump -root uspto -T /var/lib/mysql/uspto
    echo "drop database"
    mysql -root uspto < load_drop.sql
    echo "ingest"
    mysql [options] --local-infile=1 uspto < starcluster/load.sql

done