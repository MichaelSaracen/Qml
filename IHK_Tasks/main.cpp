#include <QFile>
#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include "cpp/database.h"

QString logFileName;

void customMessageHandler(QtMsgType type, const QMessageLogContext &context, const QString &msg) {

    if (logFileName.isEmpty()) {
        QString timestamp = QDateTime::currentDateTime().toString("yyyyMMdd_HHmmss");
        logFileName = QString("../../logs/app_log_%1.txt").arg(timestamp);
    }

    QFile logFile(logFileName);
    if (!logFile.open(QIODevice::Append | QIODevice::Text)) {
        qWarning() << "Log-Datei konnte nicht geöffnet werden!";
        return;
    }
    QTextStream out(&logFile);
    QString timestamp = QDateTime::currentDateTime().toString("yyyy-MM-dd HH:mm:ss");

    // Log-Format mit Datei und Zeile
    QString logMessage = QString("[%1] [%2] %3 (%4:%5)\n")
                             .arg(timestamp)
                             .arg(type == QtDebugMsg ? "DEBUG" :
                                      type == QtWarningMsg ? "WARNING" :
                                      type == QtCriticalMsg ? "CRITICAL" :
                                      type == QtFatalMsg ? "FATAL" : "INFO")
                             .arg(msg)
                             .arg(context.file ? context.file : "Unknown")  // Dateiname
                             .arg(context.line); // Zeilennummer

    out << logMessage;
    logFile.close();  // Datei schließen

    // Falls es ein Fatal-Fehler ist, Programm beenden
    if (type == QtFatalMsg) {
        abort();
    }
}

int main(int argc, char *argv[])
{
    qInstallMessageHandler(customMessageHandler);
    QGuiApplication app(argc, argv);
    app.setOrganizationDomain("Saracen.org");
    app.setOrganizationName("Saracen");
    app.setApplicationName("IHK_TASKS");

    qmlRegisterType<Database>("App.Appearance", 1, 0, "Database");

    QQmlApplicationEngine engine;
    engine.addImportPath(":/");
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreated,
        &app,
        [url](QObject *obj, const QUrl &objUrl) {
            if (!obj && url == objUrl)
                QCoreApplication::exit(-1);
        },
        Qt::QueuedConnection);
    engine.load(url);


    return app.exec();
}
