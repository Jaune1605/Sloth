# tf-dif-IT.py 
import nltk
import pandas as pd
import joblib
from sklearn.model_selection import train_test_split
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.naive_bayes import MultinomialNB
from sklearn.pipeline import make_pipeline
from sklearn.metrics import classification_report
from nltk.corpus import stopwords

nltk.download('stopwords')
final_stopwords_list = stopwords.words('english') + stopwords.words('french')


# Lecture du fichier CSV
file_path = 'S10/dataProblemeSolution.csv'  # Assurez-vous que le chemin est correct pour votre dossier
df = pd.read_csv(file_path)

# Séparation des données en caractéristiques (X) et labels (y)
X = df['Probleme']
y = df['Solution']

# Division des données en ensembles d'entraînement et de test
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.3, random_state=42)

# Création d'un pipeline avec TF-IDF Vectorizer et Naive Bayes comme classificateur
model = make_pipeline(TfidfVectorizer(stop_words=final_stopwords_list), MultinomialNB())

# Entraînement du modèle
model.fit(X_train, y_train)

# Prédiction sur l'ensemble de test
y_pred = model.predict(X_test)

# Évaluation du modèle
print(classification_report(y_test, y_pred))

# Vous pouvez également sauvegarder le modèle entraîné pour une utilisation ultérieure
joblib.dump(model, 'model_it_problems.pkl')
