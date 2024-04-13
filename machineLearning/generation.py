# generation.py
import pandas as pd
import random

# Définition des templates de problèmes et des labels associés
problemes_templates = [
    # Réseau
    ("Le serveur {} ne répond plus à cause d'une surcharge.", "Réseau"),
    ("La connexion VPN avec le site {} est interrompue fréquemment.", "Réseau"),
    ("Le switch réseau {} a redémarré plusieurs fois de manière inattendue.", "Réseau"),
    ("La bande passante est saturée sur le lien {} depuis ce matin.", "Réseau"),
    # Logiciel
    ("L'application {} affiche un message d'erreur au lancement.", "Logiciel"),
    ("Le système de gestion de base de données {} est en panne depuis quelques heures.", "Logiciel"),
    ("Le processus d'indexation a échoué dans l'application {}.", "Logiciel"),
    ("Mise à jour critique pour le logiciel {} non appliquée.", "Logiciel"),
    # Matériel
    ("Le serveur {} présente des erreurs de disque dur.", "Matériel"),
    ("La carte graphique du poste {} surchauffe lors de l'utilisation.", "Matériel"),
    ("Le système de refroidissement de {} est défectueux.", "Matériel"),
    ("La mémoire RAM dans le serveur {} semble corrompue.", "Matériel"),
    # Sécurité
    ("Une faille de sécurité a été détectée dans le système {}.", "Sécurité"),
    ("Tentative d'intrusion sur le réseau détectée par le système de surveillance {}.", "Sécurité"),
    ("Le certificat de sécurité du site web {} est expiré.", "Sécurité"),
    ("Une activité anormale suspectée sur le compte utilisateur {}.", "Sécurité"),
    # Network
    ("The server {} is no longer responding due to overload.", "Network"),
    ("VPN connection with site {} is frequently interrupted.", "Network"),
    ("The network switch {} has restarted several times unexpectedly.", "Network"),
    ("Bandwidth is saturated on the link {} since this morning.", "Network"),
    # Software
    ("The application {} displays an error message at launch.", "Software"),
    ("The database management system {} has been down for a few hours.", "Software"),
    ("The indexing process failed in the application {}.", "Software"),
    ("Critical update for the software {} has not been applied.", "Software"),
    # Hardware
    ("The server {} is showing hard drive errors.", "Hardware"),
    ("The graphics card in workstation {} overheats during use.", "Hardware"),
    ("The cooling system of {} is defective.", "Hardware"),
    ("The RAM in server {} appears to be corrupted.", "Hardware"),
    # Security
    ("A security flaw was detected in the system {}.", "Security"),
    ("Attempted network intrusion detected by surveillance system {}.", "Security"),
    ("The security certificate for the website {} has expired.", "Security"),
    ("Suspicious activity suspected on user account {}.", "Security")
]

# Génération des données
data = []
for _ in range(1000):  # Générer 1000 lignes
    template, label = random.choice(problemes_templates)
    probleme = template.format(random.randint(1, 100))  # Insérer un numéro aléatoire dans le template
    data.append((probleme, label))

# Création du DataFrame
df = pd.DataFrame(data, columns=["Description du problème", "Label"])

# Sauvegarde dans un fichier CSV
file_path = 'data2.csv'
df.to_csv(file_path, index=False)

print(f"Le fichier {file_path} a été créé avec succès.")
