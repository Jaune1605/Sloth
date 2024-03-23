import json

from python_terraform import Terraform, IsFlagged
from jinja2 import Environment, FileSystemLoader


def render_template(template_name, context):
    """
    Rendu d'un template Jinja2 avec un contexte donné
    :param template_name:  Nom du template
    :param context:  Contexte à utiliser pour le rendu
    :return:
    """
    file_loader = FileSystemLoader('templates')

    env = Environment(loader=file_loader)

    template = env.get_template(template_name)

    return template.render(context)

def init_terraform():
    """
    Initialiser Terraform
    :return:
    """
    tf = Terraform(working_dir='./terraform')

    tf.init(capture_output=False)

    return tf

def apply_terraform(instance_details):
    """
    Appliquer la configuration Terraform pour créer une instance
    :param instance_details:  Détails de l'instance à créer
    :return:
    """
    tf = init_terraform()

    rendered_template = render_template('aws_instance.tf.j2', instance_details)

    tf_file = f"./terraform/instances/{instance_details['name']}.tf"

    with open(tf_file, 'w') as f:
        f.write(rendered_template)

    return tf.apply(skip_plan=True, capture_output=False)

def createInfrastructure(instance_details):
        return_code, stdout, stderr = apply_terraform(instance_details)

        if return_code != 0:
            raise Exception(f'Erreur Terraform: {stderr}')

        return {"message": "Infrastructure created successfully"}

def destroyInfrastructure():

    tf = Terraform(working_dir='./terraform')

    return_code, stdout, stderr = tf.cmd('destroy', '-auto-approve -json')

    if return_code != 0:
        raise Exception(f'Erreur Terraform: {stderr}')

    return {"message": "Infrastructure destroyed successfully : " + json.loads(stdout)}

def getInfrastructure():
    tf = Terraform(working_dir='./terraform')

    return_code, stdout, stderr = tf.cmd('show', '-json')

    if return_code != 0:
        raise Exception(f'Erreur Terraform: {stderr}')

    return json.loads(stdout)
