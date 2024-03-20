from python_terraform import Terraform
from jinja2 import Template
import json

TERRAFORM_DIR = "../terraform/"

def plan_deployments(server_type: str, server_spec: dict) -> dict:

    # Construction du fichier de configuration Terraform à partir du template et des spécifications du serveur

    tf = Terraform(working_dir=TERRAFORM_DIR)

    if server_type in "aws":

        tf_template = open("../terraform/templates/aws-host.tf.j2").read()

        template = Template(tf_template)

        configured_template = template.render(name="my_server2", instance_type="t2.micro", ami="ami-00c71bd4d220aa22a")

        tf.init()

        with open(TERRAFORM_DIR + "aws.tf", "w") as tf:
            tf.write(configured_template)

    elif server_type in "proxmox":

        tf_template = open("../terraform/templates/proxmox-host.tf.j2").read()

        template = Template(tf_template)

        configured_template = template.render(name="my-proxmox-server")

        tf.init()

        with open(TERRAFORM_DIR + "proxmox.tf", "w") as tf:
            tf.write(configured_template)

    return {"plan_message": server_type}

# Create a server 
def deploy_server() -> dict:

    tf = Terraform(working_dir=TERRAFORM_DIR)

    build_output = tf.apply(input=False, skip_plan=True)

    return {"build_message": build_output}

def destroy_server(server_name: str) -> dict:

    Terraform().destroy(TERRAFORM_DIR)

    return {"destroy_message": "Server destroyed successfully"}

def get_infra_state() -> dict:

    tf = Terraform(working_dir=TERRAFORM_DIR)

    state = tf.show(no_color=IsFlagged)

    infra_infos = json.loads(state)

    return {"state": infra_infos}

def get_server_infos(server_name: str) -> dict:

    state = get_infra_state()

    server_info = json.loads(state)

    print(server_info)

    jsoned_server_info = json.JSONEncoder.encode(server_info)

    print(jsoned_server_info)

    output = server_info["resources"]["name"]

    return {"output": output}
