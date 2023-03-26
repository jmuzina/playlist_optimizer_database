#! /bin/bash
old_container_id=$(docker-compose ps -q playlist_optimizer_postgres_instance)
if [  ${old_container_id} ]; then 
    echo "Closing Postgres instance with id ${old_container_id}...";
    docker-compose down;
    echo "Closed Postgres instance with id ${old_container_id}."
fi

echo "Spinning up a new Postgres instance..."
docker-compose up -d

new_container_id=$(docker-compose ps -q playlist_optimizer_postgres_instance)
echo "Created new Postgres instance with id ${new_container_id}"