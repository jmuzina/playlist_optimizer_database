#! /bin/bash
echo "Looking for running docker container...";
container_id=$(docker-compose ps -q playlist_optimizer_postgres_instance)
if [ ! "$container_id" ]; then
    echo "No postgres instance running. Run start.sh to start a new database instance.";
    exit 2;
fi

echo -n "Include data in schema dump (y/N)?: ";
read includeData;

echo 'Creating schema dump...';
if [[ $includeData == y* ]] ; then
    docker exec $container_id sh -c "pg_dump -U postgres -f home/schema.sql";
elif [[ $includeData == n* ]] ; then
    docker exec $container_id sh -c "pg_dump -U postgres -s -f home/schema.sql";
else 
    echo 'Unknown data preservation argument ${includeData} provided. Supported arguments: y, n';
    exit 2;
fi
echo 'Schema dump successfully created.'

echo 'Copying schema dump to host repository...'
echo "${container_id}:home/schema.sql"
docker cp "${container_id}:home/schema.sql" ../data/schema.sql;

echo 'Copied schema dump to host repository.';