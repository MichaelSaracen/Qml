#include "database.h"
#include <QDir>
#include <QSqlError>
#include <QSqlQuery>


Database::Database(QObject *parent)
    : QObject{parent}
{
    QSqlDatabase db = QSqlDatabase::addDatabase("QSQLITE");
    db.setDatabaseName(Database::filePath());

    // Verbindung prüfen.
    if ( !db.open() ) {
        qWarning() << "Database tasks.db konnte nicht geöffnet werden" << db.lastError().text();
    }
}

/**
 * Fügt eine Frage und eine Antwort in die task Table in der Datenbank hinzu.
 * @brief Database::addQuestionAndAnswer
 * @param question
 * @param answer
 * @param subjectID
 */
int Database::addQuestionAndAnswer(const QString &question, const QString &answer, int subjectID)
{
    QString queryString = "INSERT INTO task(question, answer, subjectID) VALUES (?,?,?)";

    QSqlQuery query;
    query.prepare(queryString);
    query.addBindValue(question);
    query.addBindValue(answer);
    query.addBindValue(subjectID);

    if ( !query.exec() ) {
        qWarning() << "Fehler beim hinzufügen des Eintrags:" << query.lastError().text();
        return -1;
    }

    return query.lastInsertId().toInt();
}

/*!
 * Fügt ein neues Fach in die Datenbank hinzu
 * \brief Database::addSubject
 * \param name
 * \return
 */
int Database::addSubject(const QString &name)
{

    QString queryString = "INSERT INTO subject (name) VALUES (?)";

    QSqlQuery query;
    query.prepare(queryString);
    query.addBindValue(name);

    if(!query.exec()) {
        qWarning() << "Fehler!" << name << "konnte nicht hinzugefügt werden. Grund:" << query.lastError().text();
        return -1;
    }

    return query.lastInsertId().toInt();
}

QVariantList Database::querstions(int subjectID)
{
    QVariantList lst;

    QString queryString = "SELECT id, question, answer FROM task WHERE subjectID = ?";

    QSqlQuery query;
    query.prepare(queryString);
    query.addBindValue(subjectID);

    if ( query.exec() ) {
        while (query.next()) {
            QVariantMap map;
            map["taskID"] = query.value("id").toInt();
            map["question"] = query.value("question").toString();
            map["answer"] = query.value("answer").toString();
            lst.append(map);
        }
    } else {
        qDebug() << query.lastError().text();
    }
    return lst;
}

void Database::removeQuestion(int id)
{
    QString queryString = "DELETE FROM task WHERE id = ?";

    QSqlQuery query;
    query.prepare(queryString);
    query.addBindValue(id);

    if ( !query.exec() ) {
        qWarning() << "Fehler beim entfernen des Fachs!" << query.lastError().text();
    }
}

/**
 * Entfernt über die subjectID das Fach aus der Datenbank.
 * @brief Database::removeSubject
 * @param id
 */
void Database::removeSubject(int id)
{
    QString queryString = "DELETE FROM subject WHERE id = ?";

    QSqlQuery query;
    query.prepare(queryString);
    query.addBindValue(id);

    if ( !query.exec() ) {
        qWarning() << "Fehler beim entfernen des Fachs!" << query.lastError().text();
    }
}

/*!
 * Sucht nach allen Fächern, und gibt diese als Liste -sofern welche vorhanden- wieder.
 * \brief Database::subjects
 * \return
 */
QVariantList Database::subjects()
{
    QVariantList lst;

    QString queryString = "SELECT * FROM subject";
    QSqlQuery query(queryString);

    if ( query.exec() ) {
        while (query.next()) {
            QVariantMap map;
            map["subjectID"] = query.value("id").toInt();
            map["name"] = query.value("name").toString();
            lst.append(map);
        }
    } else {
        qDebug() << query.lastError().text();
    }
    return lst;
}

void Database::updateAnswer(const QString &answer, int taskID)
{
    QString queryString = "UPDATE task SET answer = ? WHERE id = ?";

    QSqlQuery query;
    query.prepare(queryString);
    query.addBindValue(answer);
    query.addBindValue(taskID);

    if ( !query.exec() ) {
        qWarning() << "Fehler beim hinzufügen des Eintrags:" << query.lastError().text();
    }
}


void Database::updateQuestion(const QString &question, int taskID)
{
    QString queryString = "UPDATE task SET question = ? WHERE id = ?";

    QSqlQuery query;
    query.prepare(queryString);
    query.addBindValue(question);
    query.addBindValue(taskID);

    if ( !query.exec() ) {
        qWarning() << "Fehler beim hinzufügen des Eintrags:" << query.lastError().text();
    }
}

void Database::updateSubject(const QString &name, int subjectID)
{
    QString queryString = "UPDATE subject SET name = ? WHERE id = ?";

    QSqlQuery query;
    query.prepare(queryString);
    query.addBindValue(name);
    query.addBindValue(subjectID);

    if ( !query.exec() ) {
        qWarning() << "Fehler beim hinzufügen des Eintrags:" << query.lastError().text();
    }
}

/**
 * Sucht nach dem Pfad der Datenbank ( befindet sich im Lokalen Ordner )
 * @brief Database::filePath
 * @return
 */
QString Database::filePath()
{
    QDir dir(QDir::currentPath());
    QString path = dir.absoluteFilePath("db/tasks.db");

    while (!dir.exists(path)) {
        path = dir.absoluteFilePath("db/tasks.db");
        dir.cdUp();
    }
    return path;
}
