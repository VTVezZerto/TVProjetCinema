from flask import Flask, jsonify, render_template, redirect, url_for
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


@app.route('/')
def index():
    co = get_connection()
    curseur = co.cursor()
    curseur.execute("SET lc_time_names = 'fr_FR'")
    requete_sql = """
                  SELECT SEANCE.id,
                         DATE_FORMAT(SEANCE.heure, "%W %e %M %Y") AS heure,
                         FILMS.titre,
                         FILMS.id AS id_film, 
                         SALLE.salle,
                         FILMS.resume
                  FROM SEANCE
                           INNER JOIN FILMS ON SEANCE.id_films = FILMS.id
                           INNER JOIN SALLE ON SEANCE.id_salle = SALLE.id
                  WHERE SEANCE.heure >= NOW()
                  ORDER BY SEANCE.heure ASC LIMIT 3
                  """
    curseur.execute(requete_sql)
    seances = curseur.fetchall()
    curseur.close()
    co.close()

    prochaine = seances[0] if len(seances) > 0 else None
    suivantes = seances[1:] if len(seances) > 1 else []

    return render_template('index.html', prochaine_seance=prochaine, seances_suivantes=suivantes)



# Route /film sans variable : redirige vers l'accueil (index)
@app.route('/film/')
def film_sans_variable():
    return redirect(url_for('index'))


#  Route /film/<int:id_film> avec variable : affiche les infos du film
@app.route('/film/<int:id_film>')
def details_film(id_film):
    co = get_connection()
    curseur = co.cursor()

    # Forcer les noms de jours et mois en français pour cette session MySQL
    curseur.execute("SET lc_time_names = 'fr_FR'")

    # Récupération des informations du film (id, titre, duree, age_limite, langue, resume)
    requete_film = """
                   SELECT id, titre, duree, age_limite, langue, resume
                   FROM FILMS
                   WHERE id = %s
                   """
    curseur.execute(requete_film, (id_film,))
    donnees_film = curseur.fetchone()

    if not donnees_film:
        curseur.close()
        co.close()
        return redirect(url_for('index'))

    # Récupération de toutes les séances du film avec la date formatée en français
    # Note : les % sont doublés (%%) car PyMySQL utilise %s pour les paramètres
    requete_seances = """
                      SELECT SEANCE.id,
                             DATE_FORMAT(SEANCE.heure, "%%W %%e %%M %%Y") AS date_fr,
                             DATE_FORMAT(SEANCE.heure, "%%Hh%%i")         AS heure_fr,
                             SEANCE.langue,
                             SALLE.salle
                      FROM SEANCE
                               INNER JOIN SALLE ON SEANCE.id_salle = SALLE.id
                      WHERE SEANCE.id_films = %s
                      ORDER BY SEANCE.heure ASC
                      """
    curseur.execute(requete_seances, (id_film,))
    liste_seances = curseur.fetchall()

    curseur.close()
    co.close()

    return render_template('film.html', film=donnees_film, seances=liste_seances)


@app.route('/seances')
def seances():
    co = get_connection()
    curseur = co.cursor()
    curseur.execute("SET lc_time_names = 'fr_FR'")
    requete_sql = """
                  SELECT SEANCE.id,
                         DATE_FORMAT(SEANCE.heure, "%%W %%e %%M %%Y") AS heure,
                         SEANCE.langue,
                         FILMS.id                                     AS id_film,
                         FILMS.titre,
                         SALLE.salle
                  FROM SEANCE
                           INNER JOIN FILMS ON SEANCE.id_films = FILMS.id
                           INNER JOIN SALLE ON SEANCE.id_salle = SALLE.id
                  WHERE SEANCE.heure >= NOW() \
                    AND SEANCE.id_salle = %s
                  ORDER BY SEANCE.heure ASC
                  """
    curseur.execute(requete_sql, (1,))
    seances_salle1 = curseur.fetchall()

    curseur.execute(requete_sql, (2,))
    seances_salle2 = curseur.fetchall()

    curseur.execute(requete_sql, (3,))
    seances_salle3 = curseur.fetchall()

    curseur.close()
    co.close()

    return render_template('seances.html',
                           salle1=seances_salle1,
                           salle2=seances_salle2,
                           salle3=seances_salle3)


if __name__ == '__main__':
    app.run(debug=True, port=5000)
