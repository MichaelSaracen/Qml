#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "cpp/elapsedtimer.h"

int main(int argc, char *argv[])
{
    // [!] --- type - register

    QGuiApplication app(argc, argv);

    qmlRegisterType<ElapsedTimer>("App", 1, 0, "ElapsedTimer");
    app.setApplicationName("Minesweeper");
    app.setOrganizationName("SweeperOrg");
    app.setOrganizationDomain("OrgDomain");
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
