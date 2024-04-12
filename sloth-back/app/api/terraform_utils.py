import json
import os
import subprocess
from python_terraform import Terraform
from jinja2 import Environment, FileSystemLoader

def render_template(template_name, context):
    """
    Rendu d'un template Jinja2 avec un contexte donné
    :param template_name:  Nom du template
    :param context:  Contexte à utiliser pour le rendu
    :return:
    """
    file_loader = FileSystemLoader('../templates')

    env = Environment(loader=file_loader)

    template = env.get_template(template_name)

    return template.render(context)

def init_terraform():
    """
    Initialiser Terraform
    :return:
    """
    tf = Terraform(working_dir='../terraform')

    tf.init(capture_output=False)

    return tf

def apply_terraform(provider : str, instance_details : dict):
    """
    Appliquer la configuration Terraform pour créer une instance
    :param instance_details:  Détails de l'instance à créer
    :return:
    """
    
    tf = init_terraform()

    if provider == 'aws':
        rendered_template = render_template('aws_instance.tf.j2', instance_details)
    elif provider == 'Proxmox':
        rendered_template = render_template('proxmox_instance.tf.j2', instance_details)

    tf_file = f"../terraform/modules/{provider}/{instance_details['name']}.tf"

    with open(tf_file, 'w') as f:
        f.write(rendered_template)

    return tf.apply(skip_plan=True, capture_output=False)

def createInfrastructure(provider : str, instance_details : dict):
        
        subprocess.run(['ssh-keygen', '-t', 'rsa', '-b', '4096', '-f', f'../keys/{instance_details["name"]}-key', '-N', ''])

        instance_details['public_key'] = open(f'../keys/{instance_details["name"]}-key.pub').read()

        return_code, stdout, stderr = apply_terraform(provider,instance_details)

        if return_code != 0:
            raise Exception(f'Erreur Terraform: {stderr}')
        
        # Generate the SSH key pair for the instance

        # Add the public key to the instance
        #subprocess.run(['sshpass', '-p', instance_details['password'], 'ssh-copy-id', '-i', f'../keys/{instance_details["name"]}-key.pub', f'{instance_details["username"]}@{instance_details["ipAddress"]}'])

        # Add the resource to the inventory file
        with open('../ansible/inventory', 'a') as f:
            f.write(f"{instance_details['name']} ansible_host={instance_details['ipAddress']} ansible_user=sloth-admin ansible_ssh_private_key_file=../keys/{instance_details['name']}-key\n")

        return {"message": "Infrastructure created successfully"}

def destroyInfrastructure(provider: str, resource_name: str):
    """
    Destroy a specific resource
    As the -target option don't work, we will delete the resource file and apply the destroy command
    The effect will be the deletion of the resource
    """

    tf_file = f"../terraform/modules/{provider}/{resource_name}.tf"

    if not os.path.exists(tf_file):
        return {"message": "Resource not found"}
    
    os.remove(tf_file)

    tf = Terraform(working_dir='../terraform')

    return tf.apply(skip_plan=True, capture_output=False)

def getInfrastructure():

    servers_list = []

    tf = Terraform(working_dir='../terraform')

    return_code, stdout, stderr = tf.cmd('show', '-json')

    if return_code != 0:
        raise Exception(f'Erreur Terraform: {stderr}')

    for servers in json.loads(stdout)['values']['root_module']['child_modules']:
        for server in servers['resources']:

            try:
                ip = server['values']['initialization'][0]['ip_config'][0]['ipv4'][0]['address']
            except:
                ip = 'N/A'

            try:
                cpu_architecture = server['values']['cpu'][0]['architecture']
            except:
                cpu_architecture = 'N/A'

            try:
                cpu_count = server['values']['cpu'][0]['cores']
            except:
                cpu_count = 'N/A'
            
            try: 
                memory_size = server['values']['memory'][0]['dedicated']
            except:
                memory_size = 'N/A'

            try:
                mac_address = server['values']['mac_addresses'][0]
            except:
                mac_address = 'N/A'

            try:
                bridge_name = server['values']['network_device'][0]['bridge']
            except:
                bridge_name = 'N/A'

            if server['type'] == 'aws_instance':
                type = 'aws'
            elif server['type'] == 'proxmox_virtual_environment_vm':
                type = 'proxmox'

            server_infos = { 'name': server['name'], 'type': type, 'id': server['values']['id'], 'ip': ip, 'mac_address': mac_address, 'cpu_architecture': cpu_architecture, 'cpu_count': cpu_count, 'memory_size': memory_size, 'bridge_name': bridge_name}
            print(server_infos)
            servers_list.append(server_infos)

    return servers_list
