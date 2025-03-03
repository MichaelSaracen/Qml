#ifndef DATABASE_H
#define DATABASE_H

#include <QObject>
#include <QQmlEngine>
#include <QSqlDatabase>

class Database : public QObject
{
    Q_OBJECT
    QML_ELEMENT
public:
    explicit Database(QObject *parent = nullptr);
    Q_INVOKABLE int addQuestionAndAnswer(const QString& question, const QString& answer, int subjectID);
    Q_INVOKABLE int addSubject ( const QString& name );
    Q_INVOKABLE QVariantList querstions(int subjectID);
    Q_INVOKABLE void removeQuestion( int id );
    Q_INVOKABLE void removeSubject ( int id );
    Q_INVOKABLE QVariantList subjects();
    Q_INVOKABLE void updateQuestion( const QString& question,  int taskID );
    Q_INVOKABLE void updateAnswer( const QString& answer, int taskID );
    Q_INVOKABLE void updateSubject( const QString& name, int subjectID );


    static QString filePath();
private:
signals:


};

#endif // DATABASE_H
