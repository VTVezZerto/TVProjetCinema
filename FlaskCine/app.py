import pymysql
from flask import Flask, jsonify

app = Flask(__name__)


# Exemple de route Flask démontrant votre logique de gestion
@app.route('/', methods=['GET'])
def get_connection():
    connection = None
    try:
        # 1. Exemple de tentative de connexion à la base de données
        connection = pymysql.connect(
            host='localhost',
            user='votre_utilisateur',
            password='votre_mot_de_passe',
            database='votre_bdd',
            cursorclass=pymysql.cursors.DictCursor
        )

        # 2. Exécution de vos requêtes SQL ici...
        with connection.cursor() as cursor:
            cursor.execute("SELECT 1")
            resultat = cursor.fetchone()

        return jsonify({"statut": "succes", "donnees": resultat}), 200

    except pymysql.MySQLError as error:
        # 3. En cas d'erreur de connexion ou SQL
        return jsonify({
            "statut": "erreur",
            "message": f"Impossible de se connecter : {str(error)}"
        }), 500

    finally:
        # 4. Fermeture obligatoire et sécurisée de la connexion
        # (open est une propriété booléenne en PyMySQL, pas une méthode)
        if connection and connection.open:
            connection.close()

@app.route("/insert")
def insert_data():
    co = get_connection
    cuseur = co.cursor()

    requete = """
        INSER INTO SEANCE
        (id_salle, id_films, heure, langue)
        VALUES (%s, %s, %s, %s)
    """

    valeurs = (3, 2, "21:00:00", "VOSTFR")

    cuseur.execute(requete, valeurs)
    co.commit()
# Point d'entrée pour lancer le serveur de développement Flask
if __name__ == '__main__':
    app.run(debug=True, port=5000)
