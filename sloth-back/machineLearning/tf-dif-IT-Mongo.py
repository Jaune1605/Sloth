import nltk
import pandas as pd
import joblib
from pymongo import MongoClient
from sklearn.model_selection import train_test_split
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.naive_bayes import MultinomialNB
from sklearn.pipeline import make_pipeline
from sklearn.metrics import classification_report
from nltk.corpus import stopwords

# Téléchargement des stop words
nltk.download('stopwords')
final_stopwords_list = stopwords.words('english') + stopwords.words('french')

# Configuration de la connexion à MongoDB
client = MongoClient("mongodb://sloth:slothPAJO123!@10.18.0.253:27017/slothDatabase")
db = client.slothDatabase
collection = db.questionAnswer

# Récupération des données depuis MongoDB
data = list(collection.find({}, {"_id": 0, "problem": 1, "solution": 1}))
df = pd.DataFrame(data)
df.columns = ['Probleme', 'Solution']  # Renommer les colonnes pour correspondre à vos besoins

# Répétition des données 10 fois
df = pd.concat([df]*10, ignore_index=True)

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

# Sauvegarde du modèle entraîné pour une utilisation ultérieure
joblib.dump(model, 'model_it_problems.pkl')
