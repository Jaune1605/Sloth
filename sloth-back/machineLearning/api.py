from flask import Flask, request, jsonify
import joblib
import numpy as np

app = Flask(__name__)

# Charger le modèle sauvegardé
model_loaded = joblib.load('model_it_problems.pkl')

@app.route('/predict', methods=['POST'])
def predict():
    data = request.get_json(force=True)
    user_input = data['phrase']

    # Faire une prédiction sur l'entrée de l'utilisateur
    probabilities = model_loaded.predict_proba([user_input])[0]

    # Obtenir les indices des trois classes les plus probables
    top3_indices = np.argsort(probabilities)[-3:][::-1]

    # Récupérer les labels de classe et les probabilités correspondantes
    top3_labels = [model_loaded.classes_[i] for i in top3_indices]
    top3_probabilities = [probabilities[i] for i in top3_indices]

    # Préparer la réponse
    response = {
        'predictions': [{'label': label, 'probability': round(prob, 2)} for label, prob in zip(top3_labels, top3_probabilities)]
    }

    return jsonify(response)

if __name__ == '__main__':
    app.run(debug=True)
