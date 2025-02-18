#ifndef DATABASE_H
#define DATABASE_H

#include <QQuickItem>

class Database : public QObject
{
    Q_OBJECT
    QML_ELEMENT
public:
    Database(QObject *parent = nullptr);
    [[nodiscard]] Q_INVOKABLE bool addMovie(const QString &title, const QString &genre, const QString &fsk, const QString &duration, const QString &description, const QString &imagePath);
    [[nodiscard]] Q_INVOKABLE QString imageToBase64(const QString &path) const;
    [[nodiscard]] Q_INVOKABLE int lastInsertedID() const;
    [[nodiscard]] Q_INVOKABLE QVariantList movies() const;
    Q_INVOKABLE void removeEntry( int id );
    Q_INVOKABLE void removeMovies( );



signals:

private:
    int m_lastInsertedID;
};

#endif // DATABASE_H
