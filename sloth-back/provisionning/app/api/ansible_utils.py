import subprocess
import pathlib

def run_ansible_playbook(host : str, playbook_service : str):
    try:
        output = subprocess.run(["ansible-playbook", "-i", "../ansible/inventory", f"../ansible/playbooks/{playbook_service}.yml"])
        return {"success": True, "message": output.stdout}
    except subprocess.CalledProcessError as e:
        return {"success": False, "message": str(e)}

def get_ansible_playbooks():
    try:
        output = subprocess.run(["ls", "../ansible/playbooks/code"], capture_output=True)

        cleaned_output = output.stdout.decode("utf-8").split("\n")

        cleaned_playbook_output = []

        for playbook in cleaned_output:

            playbook = playbook.split(".")[0]
            cleaned_playbook_output.append(playbook)

        return {"success": True, "message": cleaned_playbook_output}

    except subprocess.CalledProcessError as e:
        return {"success": False, "message": str(e)}