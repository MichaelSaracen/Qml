#include "server.h"

#include <QDesktopServices>

Server::Server( QObject *parent ) :
    QObject( parent ),
    m_process( new QProcess( this ) ),
    m_browserProcess( new QProcess( this )) {}

Server::~Server()
{
    delete m_process;
    delete m_browserProcess;

}

void Server::open()
{
    qDebug() << "Server wird gestartet..." << SERVER_PATH;
    m_process->setWorkingDirectory("D:/Qml/Projects/KinoManager/server");
    m_process->start( "node", QStringList() << "server.js");

    if ( !m_process->waitForStarted() ) {
        qDebug() << "Fehler beim Starten des Servers:" << m_process->errorString();
    } else {
        // if (m_browserProcess) {
        //     m_browserProcess->terminate(); // Beende den aktuellen Browser-Prozess
        //     m_browserProcess->waitForFinished(); // Warte, bis der Prozess beendet ist
        // }
        qDebug() << "Server läuft auf http://127.0.0.1:8080";

        QStringList arguments ;
        arguments << "--new-tab" << "http://localhost:8080";
        m_browserProcess->start("firefox", arguments);

        if ( !m_browserProcess->waitForStarted()) {
            qDebug() << "Fehler beim Startten des Browsers:" << m_browserProcess->errorString();
        } else {
            qDebug() << "FireFox wurde geöffnet";
        }
    }
}

