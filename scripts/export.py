import os
import subprocess
from dotenv import load_dotenv, dotenv_values
from docker import get_container_id

file_path = os.path.dirname( __file__ )
postgres_path = os.path.join( file_path, '..' )
env_path = os.path.join(postgres_path, '.env')
export_path = os.path.join(postgres_path, 'data')
docker_container_dump_path='/tmp/dump_result.sql'

config = dotenv_values(env_path)

def dump_metadata(id:str, data_inclusive:bool=False):
    """
    Dump Postgres data within its Docker container
    @param id: ID of the Postgres Docker container
    @param data_inclusive: Whether to include data in the export. If true, schema & data are copied. Otherwise, only schema DDL is copied.
    """
    args = ['docker', 'exec', id, 'sh', '-c', 'pg_dump -U postgres -n playlist_optimizer -f {docker_container_dump_path}'.format(docker_container_dump_path=docker_container_dump_path)]
    if data_inclusive:
        args.append('-s')
    print('Creating schema dump...')
    subprocess.call(args)
    print('Successfully created schema dump.')

def copy_metadata_to_host(id: str, data_inclusive:bool=False):
    """
    Copy dumped Postgres data to the host machine
    @param id: ID of the Postgres Docker container
    @param data_inclusive: Whether actual data was included in the export
    """
    copy_file_name = 'data.sql' if data_inclusive else 'schema.sql'
    copy_file_path = os.path.join(export_path, copy_file_name)
    export_container_file_path = '{id}:{docker_path}'.format(id=id, docker_path=docker_container_dump_path)

    # Copy the data to host machine
    subprocess.call(['docker', 'cp', export_container_file_path, copy_file_path])
    # Delete the dump result from the docker container
    subprocess.call(['docker', 'exec', id, 'sh', '-c', 'rm {docker_container_dump_path}'.format(docker_container_dump_path=docker_container_dump_path)])

    print('Schema copied to ' + os.path.abspath(copy_file_path))

def main():
    id = get_container_id(config['POSTGRES_DOCKER_CONTAINER_NAME'])
    if id is None:
        print('No postgres instance running. Run start.py to start a new database instance.')
        return exit(1)

    data_inclusive_raw_input:str = input('Do you want to include actual data in your export? (Y/n)\n')
    data_inclusive = data_inclusive_raw_input.lower().startswith('y')

    dump_metadata(id, data_inclusive)
    copy_metadata_to_host(id, data_inclusive)

if __name__ == "__main__":
    main()