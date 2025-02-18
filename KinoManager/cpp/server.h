#ifndef SERVER_H
#define SERVER_H

#include <QProcess>
#include <QQuickItem>

class Server : public QObject
{
    Q_OBJECT
    QML_ELEMENT
public:
    Server(QObject *parent = nullptr);
    ~Server();

    Q_INVOKABLE void open();


signals:

private:
    QProcess *m_process;
    QProcess *m_browserProcess;

};

#endif // SERVER_H
