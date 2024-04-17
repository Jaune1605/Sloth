import joblib
import numpy as np

# Charger le modèle sauvegardé
model_loaded = joblib.load('S10/model_it_problems.pkl')

while True:
    # Demander à l'utilisateur d'entrer une nouvelle phrase
    user_input = input("Entrez une description du problème IT (ou tapez 'quitter' pour sortir) : ")
    
    # Vérifier si l'utilisateur veut quitter
    if user_input.lower() == 'quitter':
        print("Fin du programme.")
        break
    
    # Faire une prédiction sur l'entrée de l'utilisateur
    # Utiliser predict_proba pour obtenir les probabilités
    probabilities = model_loaded.predict_proba([user_input])[0]
    
    # Obtenir les indices des trois classes les plus probables
    top3_indices = np.argsort(probabilities)[-3:][::-1]
    
    # Récupérer les labels de classe correspondant à ces indices
    # Pour cela, nous avons besoin d'accéder aux classes_ du pipeline
    # Assurez-vous que votre pipeline a un attribut 'classes_' accessible via le classificateur
    top3_labels = [model_loaded.classes_[i] for i in top3_indices]
    
    # Afficher les trois prédictions les plus plausibles
    print("Prédictions les plus plausibles :")
    for label in top3_labels:
        print(f"- {label} avec une probabilité de {probabilities[top3_indices[top3_labels.index(label)]]:.2f}")

