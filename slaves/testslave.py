import docker
docker_socket = 'tcp://172.17.42.1:4243'
client = docker.client.Client(base_url=docker_socket)
slave_image = 'datalad/buildslave:nd80-1'
container = client.create_container(slave_image)
client.start(container['Id'])
# Optionally examine the logs of the master
client.stop(container['Id'])
client.wait(container['Id'])
