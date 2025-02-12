#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "cpp/field.h"

int main(int argc, char *argv[])
{
    qmlRegisterType<Field>("App", 1, 0, "GameField");

    qreal b = 8;
    qreal c = 13.6;

    qDebug() << qRadiansToDegrees( qAsin(b / c) );

    QGuiApplication app(argc, argv);

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
