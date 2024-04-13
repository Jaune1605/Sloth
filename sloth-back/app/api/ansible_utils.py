import subprocess

def run_ansible_playbook(host : str, playbook_service : str):
    try:
        output = subprocess.run(["ansible-playbook", "-i", "../ansible/inventory", f"../ansible/playbooks/{playbook_service}.yml"])
        return {"success": True, "message": output.stdout}
    except subprocess.CalledProcessError as e:
        return {"success": False, "message": str(e)}
