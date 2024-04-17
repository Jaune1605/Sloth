import subprocess
import pathlib

def run_ansible_playbook(host : str, playbook_service : str):
    try:
        output = subprocess.run(["ansible-playbook", "-i", "../ansible/inventory", f"../ansible/playbooks/code/{playbook_service}.yml", "-l", host], capture_output=True)
        print(output.stdout)
        print(output.stderr)
        return {"success": True, "message": output.stdout}
    except subprocess.CalledProcessError as e:
        return {"error": False, "message": str(e)}
    except Exception as e:
        return {"error": False, "message": str(e)}

def get_ansible_playbooks():
    try:
        output = subprocess.run(["ls", "../ansible/playbooks/code"], capture_output=True)

        cleaned_output = output.stdout.decode("utf-8").split("\n")

        cleaned_playbook_output = []

        for playbook in cleaned_output:

            playbook = playbook.split(".")[0]

            if playbook != "":
                cleaned_playbook_output.append(playbook)

        return {"success": True, "message": cleaned_playbook_output}

    except subprocess.CalledProcessError as e:
        return {"error": False, "message": str(e)}