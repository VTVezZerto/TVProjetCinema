from flask import Flask, jsonify, render_template
import pymysql
from config import Config

app = Flask(__name__)

def get_connection():
    return pymysql.connect(
        host=Config.DB_HOST,
        user=Config.DB_USER,
        password=Config.DB_PASSWORD,
        database=Config.DB_NAME,
        cursorclass=pymysql.cursors.DictCursor
    )

@app.route('/testbdd', methods=['GET'])
def test_connection():
    connection = None
    try:
        connection = get_connection()
        with connection.cursor() as cursor:
            cursor.execute("SELECT 1")
            resultat = cursor.fetchone()
        return jsonify({"statut": "succes", "donnees": resultat}), 200
    except pymysql.MySQLError as error:
        return jsonify({
            "statut": "erreur",
            "message": f"Impossible de se connecter : {str(error)}"
        }), 500
    finally:
        if connection and connection.open:
            connection.close()

@app.route("/insert")
def insert_data():
    co = get_connection()
    curseur = co.cursor()
    requete = """
        INSERT INTO SEANCE
        (id_salle, id_films, heure, langue)
        VALUES (%s, %s, %s, %s)
    """
    valeurs = (3, 2, "2026-11-06 21:00:00", "VOSTFR")
    curseur.execute(requete, valeurs)
    co.commit()
    curseur.close()
    co.close()
    return jsonify({"statut": "succes", "message": "Ligne insérée"}), 201

@app.route('/')
def index():
    co = get_connection()
    curseur = co.cursor()
    requete_sql = """
                  SELECT SEANCE.id,
                         SEANCE.heure,
                         FILMS.titre,
                         FILMS.id AS id_film, 
                         SALLE.salle,
                         FILMS.resume
                  FROM SEANCE
                           INNER JOIN FILMS ON SEANCE.id_films = FILMS.id
                           INNER JOIN SALLE ON SEANCE.id_salle = SALLE.id
                  WHERE SEANCE.heure >= NOW()
                  ORDER BY SEANCE.heure ASC LIMIT 1 \
                  """
    curseur.execute(requete_sql)
    seance = curseur.fetchone()
    curseur.close()
    co.close()

    return render_template('index.html', prochaine_seance=seance)

@app.route('/film/<int:id>')
def details_film(id):
    co = get_connection()
    curseur = co.cursor()
    # Requête calquée strictement sur vos colonnes : id, titre, resume, age_limite, heure, langue, salle
    requete_sql = """
                  SELECT FILMS.id, 
                         FILMS.titre, 
                         FILMS.resume, 
                         FILMS.age_limite,
                         SEANCE.heure, 
                         SEANCE.langue, 
                         SALLE.salle
                  FROM FILMS
                           LEFT JOIN SEANCE ON FILMS.id = SEANCE.id_films
                           LEFT JOIN SALLE ON SEANCE.id_salle = SALLE.id
                  WHERE FILMS.id = %s LIMIT 1 \
                  """
    curseur.execute(requete_sql, (id,))
    donnees_film = curseur.fetchone()
    curseur.close()
    co.close()

    if donnees_film:
        return render_template('film.html', film=donnees_film)
    return "Film non trouvé", 404


if __name__ == '__main__':
    app.run(debug=True, port=5000)
