import os
import json
from dotenv import load_dotenv, dotenv_values
from docker import start_service, get_container_id

file_path = os.path.dirname( __file__ )
postgres_path = os.path.join( file_path, '..' )
env_path = os.path.join(postgres_path, '.env')

os.chdir(os.path.abspath(postgres_path))

config = dotenv_values(env_path)

def main():    
    new_container_id = start_service(config['POSTGRES_DOCKER_CONTAINER_NAME'])
    print('Started container \'{new_container_id}\''.format(new_container_id=new_container_id))

if __name__ == "__main__":
    main()
