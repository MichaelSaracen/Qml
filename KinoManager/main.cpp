#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "cpp/database.h"
#include "cpp/server.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    qmlRegisterType<Database>("App.Database", 1, 0, "Database");
    qmlRegisterType<Server>("App.Database", 1, 0, "Server");
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
