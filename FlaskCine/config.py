from flask import Flask
import os
from dotenv import load_dotenv
app = Flask(__name__)

# 1. Chargement explicite du fichier de configuration
load_dotenv('config.env')
# 2. Lecture des variables avec os.getenv()
# Syntaxe : os.getenv('NOM_VARIABLE', 'valeur_par_defaut') (ici sans valeur par défaut)
class Config:
    DB_HOST = os.getenv('DB_HOST')
    DB_USER = os.getenv('DB_USER')
    DB_PASSWORD = os.getenv('DB_PASSWORD')
    DB_NAME = os.getenv('DB_NAME')
