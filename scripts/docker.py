import subprocess

def get_container_id(name_or_id: str) -> str:
    """
    Get the ID of the currently running docker container matching the provided name or ID
    @return: ID of the running container
    """
    try:
        id = subprocess.check_output([
            'docker-compose', 'ps', '-q', name_or_id
        ])
        return id.decode('utf-8').rstrip()
    except subprocess.CalledProcessError:
        pass

def stop_service(service_name: str) -> str:
    return subprocess.check_output(['docker-compose', 'rm', '-f', '-s', '-v', service_name])
    

def start_service(name: str) -> str:
    """
    Start the service in this directory
    @param name: Name of the new service
    @return: ID of the newly created service's container
    """
    existing_id = get_container_id(name)
    if existing_id is not None:
        stop_service(name)

    subprocess.call(['docker-compose', 'up', '--force-recreate', '-d', name])
    created_id = get_container_id(name)

    if created_id is None:
        raise Exception('Failed to create new docker service\'{service_name}\''.format(service_name=name))
    
    return created_id