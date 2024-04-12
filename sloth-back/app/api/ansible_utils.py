import subprocess

def run_ansible_playbook(server_ip, playbook_service):
    try:
        subprocess.run(["ansible-playbook", "-i", f"{server_ip},", playbook_service], check=True)
        return {"success": True, "message": "Le playbook Ansible a été exécuté avec succès."}
    except subprocess.CalledProcessError as e:
        return {"success": False, "message": str(e)}
