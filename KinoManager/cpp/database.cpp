#include "database.h"

#include <QFile>
#include <QSqlDatabase>
#include <QSqlError>
#include <QSqlQuery>


Database::Database(QObject *parent)
    : QObject(parent), m_lastInsertedID(0)
{
    qDebug() << DATABASE_PATH;
    QSqlDatabase db = QSqlDatabase::addDatabase("QSQLITE");
    db.setDatabaseName(DATABASE_PATH);
    if ( db.open() ) {
        qDebug() << "Die Datenbank wurde erfolgreich geöffnet";
    } else {
        qDebug() << "Fehler beim Öffnen der Datenbank" << db.lastError().text();
    }
}


bool Database::addMovie(const QString &title, const QString &genre, const QString &fsk, const QString &duration, const QString &description, const QString &imagePath)
{
    if ( !QSqlDatabase::database().isOpen() ) {
        qDebug() << "Fehler beim hinzufügen der Daten. Die Datenbak ist nicht geöffnet.";
        return false;
    }

    QString queryText = R"(
        INSERT INTO Movie ( title, genre, fsk, duration, description, picture )
        VALUES (:title, :genre, :fsk, :duration, :description, :picture )
    )";

    QString imageBase64 = imageToBase64(imagePath);

    QSqlQuery query;
    query.prepare(queryText);
    //qDebug() << title <<imageBase64 ;

    query.bindValue(":title", title);
    query.bindValue(":genre", genre);
    query.bindValue(":fsk", fsk);
    query.bindValue(":duration", duration);
    query.bindValue(":description", description);
    query.bindValue(":picture",  imageBase64);

    if ( !query.exec() ) {
        qDebug() << "Fehler, der Eintrag wurde nicht gespeichert!" << query.lastError().text();
        return false;
    }

    qDebug() << title << "wurde erfolgreich hinzugefügt!" ;
    m_lastInsertedID =  query.lastInsertId().toInt();

    return true;
}

/**
 * @brief Database::imageToBase64
 * Wandelt den Pfad des Bildes in einen Base64 String um. Dies wird dazu verwendet, um diesen Inhalt als BLOB in
 * die Datenbank aufzunehmen.
 * @param path
 * @return
 */
QString Database::imageToBase64(const QString &path) const
{
    QUrl url(path);
    QString correctPath = url.isLocalFile() ? url.toLocalFile() : path;

    QFile file( correctPath );
    if ( !file.open( QIODevice::ReadOnly )) {
        qDebug() << "Fehler beim öffnen des Bildes:" << file.errorString();
        return QString();
    }

    QByteArray ba = file.readAll();
    return "data:image/png;base64," + ba.toBase64();
}

/*!
 * \brief Database::lastInsertedID
 * \return
 */
int Database::lastInsertedID() const { return m_lastInsertedID; }

/*!
 * \brief Database::movies
 * Gibt alle Filme, mit alle Informationen, aus der Datenbank wieder.
 * \return
 */
QVariantList Database::movies() const
{
    if ( !QSqlDatabase::database().isOpen() ) {
        qDebug() << "Fehler: Die Datenbak is nicht geöffnet";
        return QVariantList();
    }
    QSqlQuery query("SELECT * FROM Movie");
    if ( !query.exec() ) {
        qDebug() << "Fehler: Die Abfrage konnte nicht ausgeführt werden" << query.lastError().text();
        return QVariantList();
    }

    QVariantList allMovies;

    while ( query.next() ) {
        QVariantMap movie;
        movie["id"] = query.value("id");
        movie["title"] = query.value("title");
        movie["genre"] = query.value("genre");
        movie["fsk"] = query.value("fsk");
        movie["duration"] = query.value("duration");
        movie["description"] = query.value("description");
        movie["picture"] =  query.value("picture");
        allMovies.append(movie);
    }



    return allMovies;
}

/*!
 * \brief Database::removeEntry
 * Entfernt über die id, den Eintrag aus der Datenbank.
 * \param id
 */
void Database::removeEntry(int id)
{
    QSqlQuery query;
    query.prepare("DELETE FROM Movie WHERE id=:id");
    query.bindValue(":id", id);

    if ( !query.exec() ) {
        qDebug() << "Fehler: das Entfernen ist fehlgeschlagen!" << query.lastError().text();
        return;
    }
}

/*!
 * \brief Database::removeMovies
 * Leert die Movie Tabelle komplett!
 */
void Database::removeMovies()
{
    if ( !QSqlDatabase::database().isOpen() ) {
        qDebug() << "Fehler: Die Datenbak is nicht geöffnet";
        return;
    }

    QSqlQuery query ( "DELETE FROM Movie" );

    if ( !query.exec() ) {
        qDebug() << "Fehler beim Entfernen aller Spalten aus der Movie Tabelle:" << query.lastError().text();
        return;
    }

    m_lastInsertedID = 0;
    qDebug() << "Alle Einträge wurden aus der Movie - Tabell entfernt!";
}







































